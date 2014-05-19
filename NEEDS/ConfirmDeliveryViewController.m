//
//  ConfirmDeliveryViewController.m
//  NEEDS
//
//  Created by JackYu on 5/19/14.
//  Copyright (c) 2014 Jackyu. All rights reserved.
//

#import "ConfirmDeliveryViewController.h"

@interface ConfirmDeliveryViewController (){
    NSString *requirementId;
    int userType;
}

@end

@implementation ConfirmDeliveryViewController

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
}

- (void)doNetWork{
    [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    [AppDelegate.engine confirmActionWithUserType:userType requirementId:requirementId completionHandler:^(){
        [MBProgressHUD hideAllHUDsForView:self.navigationController.view animated:YES];
        UIAlertView *successAlert = [[UIAlertView alloc] initWithTitle:@"操作成功" message:@"确认成功" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [successAlert show];
    }errorHandler:^(NSError *error){
        [MBProgressHUD hideAllHUDsForView:self.navigationController.view animated:YES];
        [UIAlertView showWithError:error];
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

- (IBAction)confirmAction:(id)sender {
    [self doNetWork];
}

- (void)initWithRequirementId:(NSString *)rID userType:(int)mUserType{
    requirementId = rID;
    userType = mUserType;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
