//
//  MyOrderViewController.h
//  NEEDS
//
//  Created by JackYu on 5/7/14.
//  Copyright (c) 2014 Jackyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+ECSlidingViewController.h"

@interface MyOrderViewController : UIViewController

@property (nonatomic, readwrite) int userType; // 要显示“我的订单”的用户类型 需要再跳转前设置好， 默认需求发布者.(1:需求发布者， 2：服务商)

@property (weak, nonatomic) IBOutlet UIButton *firstTabButton;
@property (weak, nonatomic) IBOutlet UIButton *secondTabButton;
@property (weak, nonatomic) IBOutlet UIButton *thirdTabButton;
@property (weak, nonatomic) IBOutlet UIView *tabIndicator;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)tabClickAction:(id)sender;
- (IBAction)backToMenuAction:(id)sender;

@end
