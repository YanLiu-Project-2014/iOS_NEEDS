//
//  BidViewController.m
//  NEEDS
//
//  Created by JackYu on 5/17/14.
//  Copyright (c) 2014 Jackyu. All rights reserved.
//

#import "BidViewController.h"

@interface BidViewController ()

@end

static NSString *placeHolderString = @"在此填写竞标理由~";

@implementation BidViewController

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
    
    // 竞标和取消按钮圆角
    [self.submitButton.layer setCornerRadius:self.submitButton.frame.size.height/2];
    [self.cancelButton.layer setCornerRadius:self.cancelButton.frame.size.height/2];
    
    // 填充数据
    if (self.needDetail != NULL) {
        self.needNameLabel.text = [self.needDetail name];
    }
    
    self.textView.text = placeHolderString;
    self.backSign = YES;
}

- (void)doNetWork{
    [AppDelegate.engine doBidWithNeed:[self.needDetail pk_id] content:self.textView.text completionHandler:^(){
        [self.view removeFromSuperview];
        [self.bidDelegate bidSuccessed];
    }errorHandler:^(NSError *error){
        [UIAlertView showWithError:error];
        [self.bidDelegate bidFailed];
    }];
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

- (IBAction)backgroundTouchDown:(id)sender {
    // 恢复界面位置
    [UIView animateWithDuration:0.3f animations:^(void){
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }completion:nil];
    
    if (self.backSign) {
        [self.view removeFromSuperview];
        [self.bidDelegate bidCancel];
    }else{
        [self.textView resignFirstResponder];
        self.backSign = YES;
    }
}

- (IBAction)submitAction:(id)sender {
    [self doNetWork];
}

- (IBAction)cancelAction:(id)sender {
    [self backgroundTouchDown:nil];
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    // 清除placeholder
    if ([self.textView.text isEqualToString:placeHolderString]) {
        self.textView.text = @"";
    }
    // 上拉界面
    [UIView animateWithDuration:0.7f animations:^(void){
        self.view.frame = CGRectMake(0, -100, self.view.frame.size.width, self.view.frame.size.height);
        self.backSign = NO;
    }completion:nil];
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    if ([self.textView.text length] == 0) {
        self.textView.text = placeHolderString;
        self.backSign = YES;
    }
}
@end
