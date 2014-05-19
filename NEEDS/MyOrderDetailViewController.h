//
//  MyOrderDetailViewController.h
//  NEEDS
//
//  Created by JackYu on 5/18/14.
//  Copyright (c) 2014 Jackyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YUNEEDSConfig.h"
#import "NeedDetail.h"
#import "NeedProcessView.h"
#import "NeedDetailFirstCell.h"
#import "NeedDetailSecondeCell.h"
#import "NeedDetailThirdCell.h"
#import "NeedDetailfourthCell.h"
#import "MBProgressHUD.h"
#import "YUNEEDSAppDelegate.h"
#import "LoginViewController.h"
#import "BidViewController.h"
#import "KxMenu.h"
#import "YUNEEDSConfig.h"
#import "BIdsListViewController.h"
#import "ProviderDetailViewController.h"
#import "PayToAlipayViewController.h"
#import "MessageDetailViewController.h"
#import "ConfirmDeliveryViewController.h"
#import "YUNEEDSConfig.h"
#import "RateViewController.h"

@interface MyOrderDetailViewController : UIViewController<UITableViewDataSource, UITableViewDelegate,UIAlertViewDelegate, LoginResultOperationDelegate, BidDelegate>

// 数据部分，跳转前配置
@property(strong, nonatomic) NSString *needID;

// IBoutlet
@property(strong, nonatomic) UITableView *tableView;


@end
