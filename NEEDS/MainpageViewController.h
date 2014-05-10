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
@property (weak, nonatomic) IBOutlet UITextField *search_TextField;


- (IBAction)searchField_EditingDidBegin:(id)sender;
- (IBAction)searchField_DidEndOnExit:(id)sender;
- (IBAction)shadeView_TouchDown:(id)sender;

@end
