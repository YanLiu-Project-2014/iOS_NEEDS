//
//  ReleaseRequirementsViewController.h
//  NEEDS
//
//  Created by JackYu on 5/7/14.
//  Copyright (c) 2014 Jackyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YUNEEDSAppDelegate.h"
#import "ChooseCategoryViewController.h"
#import "UIViewController+ECSlidingViewController.h"
#import "WTReTextField.h"

@interface ReleaseRequirementsViewController : UIViewController<UITextViewDelegate, ChooseCategoryDelegate>
@property (weak, nonatomic) IBOutlet UITextField *needNameField;
@property (weak, nonatomic) IBOutlet WTReTextField *needBudgetField;
@property (weak, nonatomic) IBOutlet UITextField *categoryField;
@property (weak, nonatomic) IBOutlet UITextView *needDescriptionField;


- (IBAction)menuButtonTapped:(id)sender;

- (IBAction)releaseNeedAction:(id)sender;
- (IBAction)chooseCategoryAction:(id)sender;
- (IBAction)backgroundTouchDown:(id)sender;
- (IBAction)textFieldEditingDidEnd:(id)sender;

@end
