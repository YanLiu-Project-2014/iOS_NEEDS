//
//  ConfirmDeliveryViewController.h
//  NEEDS
//
//  Created by JackYu on 5/19/14.
//  Copyright (c) 2014 Jackyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YUNEEDSAppDelegate.h"
#import "MBProgressHUD.h"
#import "UIViewController+ECSlidingViewController.h"

@interface ConfirmDeliveryViewController : UIViewController<UIAlertViewDelegate>
// 数据， 跳转前设置好
- (void) initWithRequirementId:(NSString*)rID userType:(int)mUserType;

// iBAction
- (IBAction)confirmAction:(id)sender;

@end
