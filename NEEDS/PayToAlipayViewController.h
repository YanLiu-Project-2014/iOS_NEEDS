//
//  PayToAlipayViewController.h
//  NEEDS
//
//  Created by JackYu on 5/18/14.
//  Copyright (c) 2014 Jackyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YUNEEDSAppDelegate.h"
#import "MBProgressHUD.h"
#import "UIViewController+ECSlidingViewController.h"
#import "NeedDetail.h"

@interface PayToAlipayViewController : UIViewController<UIAlertViewDelegate>

// 设置页面数据内容
@property(strong, nonatomic) NeedDetail *needDetail;

//
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *budgetLabel;
- (IBAction)submitAction:(id)sender;

@end
