//
//  NeedDetailViewController.h
//  NEEDS
//
//  Created by JackYu on 5/13/14.
//  Copyright (c) 2014 Jackyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YUNEEDSConfig.h"
#import "NeedDetail.h"
#import "YUNEEDSAppDelegate.h"
#import "YUNEEDSConfig.h"
#import "UIAlertView+MKNetworkKitAdditions.h"
#import "MBProgressHUD.h"
#import "NeedProcessView.h"
#import "LoginViewController.h"
#import "BidViewController.h"

@interface NeedDetailViewController : UIViewController<UIAlertViewDelegate, LoginResultOperationDelegate, BidDelegate>

@property(nonatomic, strong)NSString *needID;

@property (weak, nonatomic) IBOutlet UIButton *leaveMessageButton;
@property (weak, nonatomic) IBOutlet UIButton *bidButton;

- (IBAction)leaveMessageAction:(id)sender;
- (IBAction)bidAction:(id)sender;

@end
