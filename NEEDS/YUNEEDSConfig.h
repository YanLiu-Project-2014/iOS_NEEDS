//
//  YUNEEDSConfig.h
//  NEEDS
//
//  Created by JackYu on 5/13/14.
//  Copyright (c) 2014 Jackyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#define GlobalColor [UIColor colorWithRed:78/255.f green:33/255.f blue:117/255.f alpha:0.8f]

@interface YUNEEDSConfig : NSObject

+ (YUNEEDSConfig *) getSharedConfig;

- (void)saveUser:(User *)user userType:(int)mUserType;

- (User *)getUser;

- (int)getUserType;

- (NSString *)getSid;

- (BOOL)isLogin;

- (void)saveUserToLocale;

- (void)readUserFromLocale;

- (void)doLogoutConfig;

@end
