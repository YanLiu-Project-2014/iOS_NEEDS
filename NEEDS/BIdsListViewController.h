//
//  BIdsListViewController.h
//  NEEDS
//
//  Created by JackYu on 5/18/14.
//  Copyright (c) 2014 Jackyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BidDetail.h"
#import "YUNEEDSAppDelegate.h"
#import "NeedDetail.h"
#import "MBProgressHUD.h"
#import "UIViewController+ECSlidingViewController.h"
#import "BidDetailViewController.h"

@interface BIdsListViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, selectionBidProviderDelegate>

// 数据，跳转前需要设置完全
@property(nonatomic, strong) NeedDetail *needDetail;

@end
