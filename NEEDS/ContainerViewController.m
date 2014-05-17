//
//  MainpageViewController.m
//  NEEDS
//
//  Created by JackYu on 5/7/14.
//  Copyright (c) 2014 Jackyu. All rights reserved.
//

#import "ContainerViewController.h"

@interface ContainerViewController ()
@property(nonatomic, strong) IBOutlet UIView *contentView;
@property(nonatomic,strong) UIViewController *firstViewController;
@property(nonatomic,strong) UIViewController *secondViewController;
@property(nonatomic,strong) UIViewController *thirdViewController;
@property(nonatomic,strong) UIViewController *fourthViewController;
@property(nonatomic,strong) UIViewController *fifthViewContrller;

@property(nonatomic,readwrite) int g_flag;
@property(nonatomic,strong) UIViewController *currentViewController; // 当前正在显示的view controller
@end

@implementation ContainerViewController

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
    
    // 创建底部tab
    MainTabbarView *tabbar=[[MainTabbarView alloc]initWithFrame:self.view.frame];
    [tabbar showCustomerTabView];
    [tabbar showProviderTabView];
    tabbar.delegate=self;
    [self.view addSubview:tabbar];
    
//    // 创建内容显示区域（view）
//    self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 70)];
//    [self.view addSubview:self.contentView];
//    NSLog(@"content frame:%@", NSStringFromCGRect(self.contentView.frame));
    
    // 初始化子view controller 并添加到子viewcontroller里面
    self.firstViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Mainpage"];
    self.firstViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-46);
    [self addChildViewController:self.firstViewController]; // 添加主页
    
    self.secondViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ReleaseRequirements"];
    self.secondViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-46);
    [self addChildViewController:self.secondViewController]; // 添加发布需求
    
    self.thirdViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"NeedMarket"];
    self.thirdViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-46);
    [self addChildViewController:self.thirdViewController]; // 添加需求市场
    
    self.fourthViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MyOrder"];
    self.fourthViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-46);
    [self addChildViewController:self.fourthViewController]; // 添加我的订单
    
    self.fifthViewContrller = [self.storyboard instantiateViewControllerWithIdentifier:@"UserCenter"];
    self.fifthViewContrller.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-46);
    [self addChildViewController:self.fifthViewContrller]; // 添加用户中心
    
    // 显示第一个VC中的view， 即主页内容
    [self.view addSubview:self.firstViewController.view];
    NSLog(@"first frame, x:%f,y:%f,w:%f,h:%f",self.firstViewController.view.frame.origin.x, self.firstViewController.view.frame.origin.y, self.firstViewController.view.frame.size.width,self.firstViewController.view.frame.size.height);
    self.g_flag = 1;
    self.currentViewController = self.firstViewController;
//    self.currentViewController = self.secondViewController;
    
}

/**
 *  显示主页
 *
 *  @since 1.0
 */
- (void)firstBtnClick{
    if(self.g_flag==1)
        return;
    [self transitionFromViewController:self.currentViewController toViewController:self.firstViewController duration:0 options:0 animations:^{
    }  completion:^(BOOL finished) {
        self.currentViewController=self.firstViewController;
        self.g_flag=1;
    }];
}

/**
 *  显示发布需求页面
 *
 *  @since 1.0
 */
- (void)secondBtnClick{
    if(self.g_flag==2)
        return;
    [self transitionFromViewController:self.currentViewController toViewController:self.secondViewController duration:0 options:0 animations:^{
    }  completion:^(BOOL finished) {
        self.currentViewController=self.secondViewController;
        self.g_flag=2;
    }];
}

/**
 *  显示需求市场页面
 *
 *  @since 1.0
 */
- (void)thirdBtnClick{
    if(self.g_flag==3)
        return;
    [self transitionFromViewController:self.currentViewController toViewController:self.thirdViewController duration:0 options:0 animations:^{
    }  completion:^(BOOL finished) {
        self.currentViewController=self.thirdViewController;
        self.g_flag=3;
    }];
}

/**
 *  显示我的订单页面
 *
 *  @since 1.0
 */
- (void)fourthBtnClick{
    if(self.g_flag==4)
        return;
    [self transitionFromViewController:self.currentViewController toViewController:self.fourthViewController duration:0 options:0 animations:^{
    }  completion:^(BOOL finished) {
        self.currentViewController=self.fourthViewController;
        self.g_flag=4;
    }];
}

/**
 *  显示用户中心页面
 *
 *  @since 1.0
 */
- (void)fifthBtnClick{
    if(self.g_flag==5)
        return;
    [self transitionFromViewController:self.currentViewController toViewController:self.fifthViewContrller duration:0 options:0 animations:^{
    }  completion:^(BOOL finished) {
        self.currentViewController=self.fifthViewContrller;
        self.g_flag=5;
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

@end
