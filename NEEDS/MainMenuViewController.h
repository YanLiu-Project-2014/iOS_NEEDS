//
//  MainMenuViewController.h
//  NEEDS
//
//  Created by JackYu on 5/13/14.
//  Copyright (c) 2014 Jackyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YUNEEDSConfig.h"
#import "LoginViewController.h"
#import "UserCenterNavigationViewController.h"
#import "MenuCell.h"
#import "NeedTypesViewController.h"

typedef void (^VoidBlock)(void);

@interface MainMenuViewController : UIViewController<UITableViewDataSource,UITableViewDelegate, UIAlertViewDelegate, LoginResultOperationDelegate, LogoutResultOperationDelegate>

@property(strong, nonatomic) UITableView *tableView;

@end
