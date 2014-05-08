//
//  MainpageViewController.h
//  NEEDS
//
//  Created by JackYu on 5/7/14.
//  Copyright (c) 2014 Jackyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainpageViewController : UIViewController

@property(nonatomic,strong) UIButton *messageButton;
@property(nonatomic,strong) UIButton *searchButton;

- (IBAction)searchField_DidEndOnExit:(id)sender;
@end
