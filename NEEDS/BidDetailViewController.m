//
//  BidDetailViewController.m
//  NEEDS
//
//  Created by JackYu on 5/18/14.
//  Copyright (c) 2014 Jackyu. All rights reserved.
//

#import "BidDetailViewController.h"

@interface BidDetailViewController (){
    BidDetail *data;
}

@end

@implementation BidDetailViewController

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
    [self setViewData];
    
    // 获取网络数据
    [self getDataFromServer];
}

- (void)getDataFromServer{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.labelText = @"正在加载...";
    [AppDelegate.engine getBidDetailWithId:[self.bid pk_id] completionHandler:^(JSONModel *result){
        [MBProgressHUD hideAllHUDsForView:self.navigationController.view animated:YES];
        data = (BidDetail*)result;
        [self setViewData];
    }errorHandler:^(NSError *error){
        [MBProgressHUD hideAllHUDsForView:self.navigationController.view animated:YES];
        [UIAlertView showWithError:error];
    }];
}

- (void)doNetWork{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.labelText = @"正在加载...";
    [AppDelegate.engine selectBidProviderWithProviderId:[data provider_id] requirementId:[data requirement_id] completionHandler:^(){
        [MBProgressHUD hideAllHUDsForView:self.navigationController.view animated:YES];
        UIAlertView *successAlert = [[UIAlertView alloc] initWithTitle:@"操作成功" message:@"选取竞标商成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
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

- (void)setViewData{
    self.providerName.text = [data name];
    self.bidDate.text = [data time];
    self.bidDescription.text = [data content];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self.navigationController popViewControllerAnimated:YES];
    [self.selectDelegate selectBidSuccess];
}

- (IBAction)chooseBidProviderAction:(id)sender {
    [self doNetWork];
}
@end
