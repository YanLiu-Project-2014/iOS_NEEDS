//
//  RateViewController.h
//  NEEDS
//
//  Created by JackYu on 5/19/14.
//  Copyright (c) 2014 Jackyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YUNEEDSAppDelegate.h"
#import "MBProgressHUD.h"
#import "UIViewController+ECSlidingViewController.h"

@interface RateViewController : UIViewController<UIAlertViewDelegate>

// 数据，跳转前设置
- (void)initWithRequirementId:(NSString*)reuqirementId;

- (IBAction)rateAction:(id)sender;
@end
