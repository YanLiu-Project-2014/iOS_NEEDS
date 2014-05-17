//
//  User.m
//  NEEDS
//
//  Created by JackYu on 5/5/14.
//  Copyright (c) 2014 Jackyu. All rights reserved.
//

#import "User.h"

@implementation User

- (NSString*)description{
    return [NSString stringWithFormat:@"sid:%@, uid:%@, user_type:%@, user_name:%@", self.sid, self.uid, self.user_type, self.user_name];
}

+ (NSString*)formatToString:(User*)user{
    return [NSString stringWithFormat:@"%@ %@ %@ %@", user.sid, user.uid, user.user_type, user.user_name];
}

+ (User *)formatFromString:(NSString *)string{
    NSArray *result = [string componentsSeparatedByString:@" "];
    User *user = [User alloc];
    [user setSid:[result objectAtIndex:0]];
    [user setUid:[result objectAtIndex:1]];
    [user setUser_type:[result objectAtIndex:2]];
    [user setUser_name:[result objectAtIndex:3]];
    return user;
}

@end
