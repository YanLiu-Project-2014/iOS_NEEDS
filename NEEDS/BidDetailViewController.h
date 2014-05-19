//
//  BidDetailViewController.h
//  NEEDS
//
//  Created by JackYu on 5/18/14.
//  Copyright (c) 2014 Jackyu. All rights reserved.
//

@protocol selectionBidProviderDelegate <NSObject>

- (void)selectBidSuccess;

@end

#import <UIKit/UIKit.h>
#import "BidDetail.h"
#import "YUNEEDSAppDelegate.h"
#import "MBProgressHUD.h"
#import "UIViewController+ECSlidingViewController.h"

@interface BidDetailViewController : UIViewController<UIAlertViewDelegate>

// 数据， 跳转前需要设置完全
@property(strong, nonatomic) BidDetail *bid;
@property(retain, nonatomic) id<selectionBidProviderDelegate> selectDelegate;

// IBOutlet
@property (weak, nonatomic) IBOutlet UILabel *providerName;
@property (weak, nonatomic) IBOutlet UITextView *bidDescription;
@property (weak, nonatomic) IBOutlet UILabel *bidDate;

// IBAction
- (IBAction)chooseBidProviderAction:(id)sender;

@end
