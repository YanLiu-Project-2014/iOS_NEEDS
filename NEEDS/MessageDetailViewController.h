//
//  MessageDetailViewController.h
//  NEEDS
//
//  Created by JackYu on 5/19/14.
//  Copyright (c) 2014 Jackyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YUNEEDSAppDelegate.h"
#import "YUNEEDSConfig.h"
#import "MessageCell.h"
#import "MessageFrame.h"
#import "MessageDetail.h"
#import "Message.h"
#import "UIViewController+ECSlidingViewController.h"
#import "MBProgressHUD.h"

@interface MessageDetailViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

// 数据， 跳转前设置
@property(nonatomic, strong) NSString *user;

// IBOutlet
@property (weak, nonatomic) IBOutlet UITextField *addMessageTextField;

// IBAction
- (IBAction)addMessageAction:(id)sender;
@end
