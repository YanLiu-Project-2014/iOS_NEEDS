//
//  MyOrderViewController.h
//  NEEDS
//
//  Created by JackYu on 5/7/14.
//  Copyright (c) 2014 Jackyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+ECSlidingViewController.h"
#import "MyOrderNavigationController.h"
#import "YUNEEDSAppDelegate.h"
#import "YUNEEDSConfig.h"
#import "MyOrderDetail.h"
#import "MJRefresh.h"
#import "MBProgressHUD.h"
#import "MyOrderDetailViewController.h"

@interface MyOrderViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, MJRefreshBaseViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *firstTabButton;
@property (weak, nonatomic) IBOutlet UIButton *secondTabButton;
@property (weak, nonatomic) IBOutlet UIButton *thirdTabButton;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *tabButtons;

@property (strong, nonatomic) UIView *tabIndicator;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)tabClickAction:(id)sender;
- (IBAction)backToMenuAction:(id)sender;

@end
