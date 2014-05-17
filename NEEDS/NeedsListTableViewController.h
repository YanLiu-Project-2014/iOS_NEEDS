//
//  NeedsListTableViewController.h
//  NEEDS
//
//  Created by JackYu on 5/12/14.
//  Copyright (c) 2014 Jackyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YUNEEDSAppDelegate.h"
#import "NeedDetail.h"
#import "MBProgressHUD.h"
#import "NeedDetailViewController.h"

@interface NeedsListTableViewController : UITableViewController

@property(nonatomic, readwrite) int needsCategory; // 需求类别，具体内容为数字，如：0，1，2...
@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)backToMainPageAction:(id)sender;
@end
