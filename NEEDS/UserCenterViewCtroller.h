//
//  UserCenterViewCtroller.h
//  NEEDS
//
//  Created by JackYu on 5/7/14.
//  Copyright (c) 2014 Jackyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YUNEEDSConfig.h"
#import "UserCenterNavigationViewController.h"

@interface UserCenterViewCtroller : UIViewController<UIAlertViewDelegate, UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *creditLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)backToMenuAction:(id)sender;
- (IBAction)logoutButtonTouchUpInside:(id)sender;

@end
