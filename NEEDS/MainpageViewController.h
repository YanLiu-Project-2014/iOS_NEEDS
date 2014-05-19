//
//  MainpageViewController.h
//  NEEDS
//
//  Created by JackYu on 5/7/14.
//  Copyright (c) 2014 Jackyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "YUNEEDSAppDelegate.h"
#import "ECSlidingViewController.h"
#import "NeedDetailViewController.h"
#import "ProviderDescriptionCell.h"
#import "ProviderDetailViewController.h"

@interface MainpageViewController : UIViewController<ECSlidingViewControllerDelegate, UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIButton *messageButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITableView *providerTableView;

@property (weak, nonatomic) IBOutlet UILabel *providerName;
@property (weak, nonatomic) IBOutlet UILabel *rateLabel;
@property (weak, nonatomic) IBOutlet UITextView *providerGoodatLabel;


- (IBAction)refreshMainpageAction:(id)sender;

- (IBAction)menuButtonTapped:(id)sender;


@end