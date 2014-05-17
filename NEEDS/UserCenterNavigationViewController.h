//
//  UserCenterNavigationViewController.h
//  NEEDS
//
//  Created by JackYu on 5/15/14.
//  Copyright (c) 2014 Jackyu. All rights reserved.
//

@protocol LogoutResultOperationDelegate <NSObject>

- (void)logoutSuccessOperatino;

@end

#import <UIKit/UIKit.h>

@interface UserCenterNavigationViewController : UINavigationController

@property(weak, nonatomic) id<LogoutResultOperationDelegate> logoutDelegate;

@end
