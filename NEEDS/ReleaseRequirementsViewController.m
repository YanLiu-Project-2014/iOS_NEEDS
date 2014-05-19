//
//  ReleaseRequirementsViewController.m
//  NEEDS
//
//  Created by JackYu on 5/7/14.
//  Copyright (c) 2014 Jackyu. All rights reserved.
//

#import "ReleaseRequirementsViewController.h"
#import "UIViewController+ECSlidingViewController.h"
#import "ChooseCategoryViewController.h"

@interface ReleaseRequirementsViewController (){
    int categoryIndex;
    NSString *descriptionHolderStr;
}

@property(strong, nonatomic) ChooseCategoryViewController *chooseCategoryVC;

@end

@implementation ReleaseRequirementsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.chooseCategoryVC = [self.storyboard instantiateViewControllerWithIdentifier:@"chooseCategoryVC"];
    categoryIndex = -1;
    [self.needDescriptionField.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [self.needDescriptionField.layer setBorderWidth:0.5f];
    descriptionHolderStr = @"在此填写详细描述";
    self.needDescriptionField.text = descriptionHolderStr;
    self.needBudgetField.pattern = @"^([1-9]{1}\\d{1,5}(\\.\\d{1,2})?)$";// /^\d{9}\.\d{2}$/
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)menuButtonTapped:(id)sender {
    [self.slidingViewController anchorTopViewToRightAnimated:YES];
}

- (IBAction)releaseNeedAction:(id)sender {
    [self doNetWorkWithName:[self.needNameField text] category:categoryIndex budget:self.needBudgetField.text description:self.needDescriptionField.text];
}

- (IBAction)chooseCategoryAction:(id)sender {
    [self.chooseCategoryVC setDelegate:self];
    [self.navigationController pushViewController:self.chooseCategoryVC animated:YES];
}

- (IBAction)backgroundTouchDown:(id)sender {
    [self.needNameField resignFirstResponder];
    [self.needBudgetField resignFirstResponder];
    [self.needDescriptionField resignFirstResponder];
}

- (IBAction)textFieldEditingDidEnd:(id)sender {
    
}

- (void)doNetWorkWithName:(NSString*)name category:(int)mCategory budget:(NSString*)mBudget description:(NSString*)mDescription{
    if ([name length]>0 && [mBudget length] && mCategory>=0 && [mBudget length]>0 && [mDescription length]>0) {
        [AppDelegate.engine releaseNeedWithName:name category:mCategory budget:mBudget description:mDescription completionHandler:^(){
            UIAlertView *successAlert = [[UIAlertView alloc] initWithTitle:@"成功" message:@"成功" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            [successAlert show];
        }errorHandler:^(NSError *error){
            [UIAlertView showWithError:error];
        }];
    }
}

// 选择类别代理事件
- (void)choose:(int)category name:(NSString *)mName{
    [self.categoryField setText:mName];
    categoryIndex = category;
}

// textView的委托事件
- (void)textViewDidBeginEditing:(UITextView *)textView{
    if ([self.needDescriptionField.text isEqualToString:descriptionHolderStr]) {
        self.needDescriptionField.text = @"";
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    if ([self.needDescriptionField.text length] == 0) {
        self.needDescriptionField.text = descriptionHolderStr;
    }
}

// textField的委托事件
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
}
@end
