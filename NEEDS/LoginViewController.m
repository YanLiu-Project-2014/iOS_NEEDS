//
//  LoginViewController.m
//  NEEDS
//
//  Created by JackYu on 5/4/14.
//  Copyright (c) 2014 Jackyu. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) MKNetworkOperation *loginOperation;
@property (strong, nonatomic) MBProgressHUD *progressHUD;
@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)background_TouchDown:(id)sender {
    // 恢复界面（之前动画）
    self.view.frame = CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height);
    
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:UIEventTypeTouches];
}

- (IBAction)TextField_EditDidBegin:(id)sender {
    CGRect frame = ((UITextField*)sender).frame;
    int offset = frame.origin.y+102 - (self.view.frame.size.height-216); // 键盘高度216
    NSTimeInterval aminationDuration = 0.30f;
    [UIView beginAnimations:@"ttt" context:nil];
    [UIView setAnimationDuration:aminationDuration];
    if (offset >0) {
        self.view.frame = CGRectMake(0, -offset, self.view.frame.size.width, self.view.frame.size.height);
    }
    [UIView commitAnimations];
    
}

- (IBAction)TextField_DidEndOnExit:(id)sender {
    [self.login_tf_pwd becomeFirstResponder];
}

- (IBAction)TextField_pwd_DidEndOnExit:(id)sender {
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [[UIApplication sharedApplication] sendAction:@selector(UIButton_login_TouchUpInside:) to:nil from:nil forEvent:UIEventTypeTouches];
}

- (IBAction)UIButton_login_TouchUpInside:(id)sender {
    // check whether user name and pwd is null.
    if (!([self.login_tf_name.text isEqualToString:@""] || [self.login_tf_pwd.text isEqualToString:@""])) {
        [self DoLogin:self.login_tf_name.text password:self.login_tf_pwd.text userType:((int)[self.userTypeSeguementControl selectedSegmentIndex]+1)];
    }else{
        NSString *alertStr;
        if ([self.login_tf_name.text isEqualToString:@""]) {
            alertStr = @"用户名不能为空";
        }else{
            alertStr = @"密码不能为空";
        }
        UIAlertView *login_alert = [[UIAlertView alloc]initWithTitle:@"" message:alertStr delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:(NSString *)nil, nil];
        [login_alert show];
    }
}

- (void)DoLogin:(NSString*)name password:(NSString*)pwd userType:(int)mUserType{
    if (self.loginOperation != nil) { // have login operation already exit?
        [self.loginOperation cancel];
        self.loginOperation = nil;
    }
    
    self.progressHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.progressHUD.labelText = NSLocalizedString(@"登录中...", @"");
    self.progressHUD = nil;
    self.loginOperation = [AppDelegate.engine doLogin:name password:pwd userType:mUserType completionHandler:^(JSONModel *user){
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [[YUNEEDSConfig getSharedConfig] saveUser:(User *)user userType:mUserType];
        [[YUNEEDSConfig getSharedConfig] saveUserToLocale];
        
        [self.delegate loginSuccessedOperation];
        [self dismissViewControllerAnimated:YES completion:nil];
//        user = nil;
//        MainpageViewController *MainpageVC = [self.storyboard instantiateViewControllerWithIdentifier:@"Mainpage"];
//        [self.view removeFromSuperview];
//        [self.view insertSubview:MainpageVC.view atIndex:0];
    }errorHandler:^(NSError *error){
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (error != NULL) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ccc" message:@"cccs" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self backToPreviousViewAction:nil];
}

- (IBAction)backToPreviousViewAction:(id)sender {
    [self.delegate loginFailedOperation];
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
