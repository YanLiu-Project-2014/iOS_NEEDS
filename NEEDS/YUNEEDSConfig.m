//
//  YUNEEDSConfig.m
//  NEEDS
//
//  Created by JackYu on 5/13/14.
//  Copyright (c) 2014 Jackyu. All rights reserved.
//

#import "YUNEEDSConfig.h"

static YUNEEDSConfig *sharedConfigInstance = nil;
static User *applicationUser = nil;
static int applicationUserType = 0; // 用户类型： 1-需求发布者 2-服务提供商 0-未设置用户类型

@implementation YUNEEDSConfig

+ (YUNEEDSConfig*) getSharedConfig{
    @synchronized(self){
        if (sharedConfigInstance == nil) {
            sharedConfigInstance = [[YUNEEDSConfig alloc] init];
        }
    }
    return sharedConfigInstance;
}

//唯一一次alloc单例，之后均返回nil
+ (id) allocWithZone:(struct _NSZone *)zone{
    @synchronized(self){
        if (sharedConfigInstance == nil) {
            sharedConfigInstance = [super allocWithZone:zone];
            return sharedConfigInstance;
        }
    }
    return nil;
}

- (void)saveUser:(User *)user userType:(int)mUserType{
    applicationUser = user;
    applicationUserType = mUserType;
}

- (User *)getUser{
    return applicationUser;
}

- (int)getUserType{
    return applicationUserType;
}

- (NSString*)getSid{
    if ([applicationUser sid]) {
        return [applicationUser sid];
    }else{
        return @"";
    }
}

- (BOOL)isLogin{
    if (applicationUserType == 0) {
        return NO;
    }else{
        return YES;
    }
}

- (void)saveUserToLocale{
    NSLog(@"保存到本地application user:%@",[applicationUser description]);
//    [[NSUserDefaults standardUserDefaults] setObject:[User formatToString:applicationUser] forKey:@"AppUser"];
    
    if (applicationUserType != 0) {
        [[NSUserDefaults standardUserDefaults] setObject:[applicationUser sid] forKey:@"sid"];
        [[NSUserDefaults standardUserDefaults] setObject:[applicationUser uid] forKey:@"uid"];
        [[NSUserDefaults standardUserDefaults] setObject:[applicationUser user_type] forKey:@"user_type"];
        [[NSUserDefaults standardUserDefaults] setObject:[applicationUser user_name] forKey:@"user_name"];
    }
    
    [[NSUserDefaults standardUserDefaults] setInteger:applicationUserType forKey:@"AppUserType"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSLog(@"测试读取。。。");
    [self readUserFromLocale];
}

- (void)readUserFromLocale{
    applicationUserType = [[NSUserDefaults standardUserDefaults] integerForKey:@"AppUserType"];
    if (applicationUserType != 0) {
        applicationUser = [User alloc];
        [applicationUser setSid:[[NSUserDefaults standardUserDefaults] objectForKey:@"sid"]];
        [applicationUser setUid:[[NSUserDefaults standardUserDefaults] objectForKey:@"uid"]];
        [applicationUser setUser_name:[[NSUserDefaults standardUserDefaults] objectForKey:@"user_name"]];
        [applicationUser setUser_type:[[NSUserDefaults standardUserDefaults] objectForKey:@"user_type"]];
    }else{
        applicationUser = nil;
    }
    
    NSLog(@"从本地读取数据%@",[applicationUser description]);
    NSLog(@"从本地读取类型：%d", applicationUserType);
    
}

- (void)doLogoutConfig{
    applicationUserType = 0;
    applicationUser = nil;
    [self saveUserToLocale];
}

@end
