//
//  LoginViewController.h
//  NEEDS
//
//  Created by JackYu on 5/4/14.
//  Copyright (c) 2014 Jackyu. All rights reserved.
//


@protocol LoginResultOperationDelegate <NSObject>

- (void) loginSuccessedOperation;

- (void) loginFailedOperation;

@end


#import <UIKit/UIKit.h>
#import "YUNEEDSAppDelegate.h"
#import "YUNEEDSConfig.h"
#import "MKNetworkKit/MKNetworkEngine.h"
#import "MainMenuViewController.h"
#import "MBProgressHUD.h"

@interface LoginViewController : UIViewController<UIAlertViewDelegate>

@property(nonatomic, strong) id<LoginResultOperationDelegate> delegate;


@property (weak, nonatomic) IBOutlet UISegmentedControl *userTypeSeguementControl;
@property (weak, nonatomic) IBOutlet UITextField *login_tf_name;
@property (weak, nonatomic) IBOutlet UITextField *login_tf_pwd;


- (IBAction)backToPreviousViewAction:(id)sender;

/**
 *  When user touch background, keyboard will be hidden.
 *
 *  @param sender
 *
 *  @since 1.0
 */
- (IBAction)background_TouchDown:(id)sender;

/**
 *  When user editing in name field, view will scroll.
 *
 *  @param sender
 *
 *  @since 1.0
 */
- (IBAction)TextField_EditDidBegin:(id)sender;

/**
 *  When user stop editing, the cursor will be at pwd field.
 *
 *  @param sender
 *
 *  @since 1.0
 */
- (IBAction)TextField_DidEndOnExit:(id)sender;

/**
 *  When user stop editing, the view will recovery.
 *
 *  @param sender
 *
 *  @since 1.0
 */
- (IBAction)TextField_pwd_DidEndOnExit:(id)sender;

/**
 *  When user touches the login button, this method will be called.
 *
 *  @param sender
 *
 *  @since 1.0
 */
- (IBAction)UIButton_login_TouchUpInside:(id)sender;

/**
 *  The real login method.
 *
 *  @param name     user name.
 *  @param pwd      user password.
 *  @param mUserType // 用户类型： 1-需求发布者 2-服务提供商 0-未设置用户类型
 *
 *  @return user object.
 *
 *  @since 1.0
 */
- (void)DoLogin:(NSString*)name password:(NSString*)pwd userType:(int)mUserType;
@end
