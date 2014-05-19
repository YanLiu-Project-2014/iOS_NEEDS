//
//  ProviderDetailViewController.h
//  NEEDS
//
//  Created by JackYu on 5/16/14.
//  Copyright (c) 2014 Jackyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProviderView.h"
#import "YUNEEDSAppDelegate.h"
#import "YUNEEDSConfig.h"
#import "MBProgressHUD.h"
#import "UIAlertView+MKNetworkKitAdditions.h"

@interface ProviderDetailViewController : UIViewController

// 数据， 跳转前设置完全
@property(strong, nonatomic) NSString *providerId;

@end
