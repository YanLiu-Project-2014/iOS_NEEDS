//
//  NeedTypesViewController.h
//  NEEDS
//
//  Created by JackYu on 5/13/14.
//  Copyright (c) 2014 Jackyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NeedsListTableViewController.h"
#import "UIViewController+ECSlidingViewController.h"

@interface NeedTypesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, readwrite) int parentType; // 0:上一级页面为主页 1：上一级页面为菜单

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
