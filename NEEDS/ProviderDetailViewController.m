//
//  ProviderDetailViewController.m
//  NEEDS
//
//  Created by JackYu on 5/16/14.
//  Copyright (c) 2014 Jackyu. All rights reserved.
//

#import "ProviderDetailViewController.h"

@interface ProviderDetailViewController (){
    ProviderView *contentView;
    ProviderDetail *data;
}

@property(nonatomic, strong) UIScrollView *scrollView;

@end

@implementation ProviderDetailViewController

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
    // 加载网络数据
    [self getDataFromServer];
}

- (void)getDataFromServer{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.labelText = @"正在加载...";
    [AppDelegate.engine getUserDetailInfoWithType:@"2" userId:self.providerId completionHandler:^(JSONModel *result){
        [MBProgressHUD hideAllHUDsForView:self.navigationController.view animated:YES];
        data = (ProviderDetail*)result;
        [self setViewData];
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

- (void)setViewData{
    [self.scrollView removeFromSuperview];
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height + [UIApplication sharedApplication].statusBarFrame.size.height, self.view.frame.size.width, self.view.frame.size.height-self.navigationController.navigationBar.frame.size.height-[UIApplication sharedApplication].statusBarFrame.size.height)];
    
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ProviderView" owner:self options:nil];
    contentView = [nib objectAtIndex:0];
    
    NSLog(@"data:%@\n\n\n",data);
    [contentView initWithProvider:data];
    
    [self.scrollView setContentSize:CGSizeMake(contentView.frame.size.width, contentView.frame.size.height)];
    [self.scrollView addSubview:contentView];
    [self.view addSubview:self.scrollView];

}

@end
