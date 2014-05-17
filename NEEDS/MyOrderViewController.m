//
//  MyOrderViewController.m
//  NEEDS
//
//  Created by JackYu on 5/7/14.
//  Copyright (c) 2014 Jackyu. All rights reserved.
//

#import "MyOrderViewController.h"

@interface MyOrderViewController (){
    NSArray *data; // 表格会显示的数据
    NSArray *data1; // 第一个tab对应的表格的数据
    NSArray *data2;
    NSArray *data3;
}

@end

@implementation MyOrderViewController

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
    if (self.userType == 2) { // 服务商
        [self.firstTabButton setTitle:@"竞标中" forState:UIControlStateNormal];
        [self.secondTabButton setTitle:@"开发中" forState:UIControlStateNormal];
        [self.thirdTabButton setTitle:@"已完成" forState:UIControlStateNormal];
    }else{ // 需求发布者
        [self.firstTabButton setTitle:@"未托管" forState:UIControlStateNormal];
        [self.secondTabButton setTitle:@"开发中" forState:UIControlStateNormal];
        [self.thirdTabButton setTitle:@"已完成" forState:UIControlStateNormal];
    }
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

- (IBAction)tabClickAction:(id)sender {
}

- (IBAction)backToMenuAction:(id)sender {
    [self.slidingViewController anchorTopViewToRightAnimated:YES];
}
@end
