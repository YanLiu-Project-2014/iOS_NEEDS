//
//  MainMenuViewController.m
//  NEEDS
//
//  Created by JackYu on 5/13/14.
//  Copyright (c) 2014 Jackyu. All rights reserved.
//

#import "MainMenuViewController.h"
#import "UIViewController+ECSlidingViewController.h"
//#import "MainpageViewController.h"

static NSArray *publisherData;
static NSArray *providerData;

@interface MainMenuViewController (){
    int menuSelectionHighlightedIndex;
    int menuTempSelectionHighlightedIndex;
    NSArray *iconData;
}
@property(nonatomic, strong) NSArray *data;
@property(nonatomic, strong) UINavigationController *firstViewController;
@property(nonatomic, strong) UINavigationController *secondViewController;
@property(nonatomic, strong) UINavigationController *thirdViewConroller;
@property(nonatomic, strong) UserCenterNavigationViewController *fourthViewController;
@end

@implementation MainMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    iconData = [NSArray arrayWithObjects:@"",@"menu_icon_mainpage",@"menu_icon_releaseNeed",@"menu_icon_myorder",@"menu_icon_usercenter", nil];
    publisherData = [NSArray arrayWithObjects:@"Needs", @"主页", @"发布需求", @"我的订单", @"用户中心", nil];
    providerData = [NSArray arrayWithObjects:@"Needs", @"主页", @"需求市场", @"我的订单", @"用户中心", nil];
    
    UIImageView *backImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"menu_background"]];
    [backImage setFrame:CGRectMake(0, 0, 128, self.view.frame.size.height)];
    [self.view addSubview:backImage];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 128, self.view.frame.size.height) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.opaque = NO;
    [self.view addSubview:self.tableView];
    
    menuSelectionHighlightedIndex = 1;
    
    self.firstViewController = (UINavigationController *)self.slidingViewController.topViewController;
    self.fourthViewController = (UserCenterNavigationViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"UserCenter"];
    self.thirdViewConroller = (UINavigationController *)[self.storyboard instantiateViewControllerWithIdentifier:@"MyOrderVC"];
    [self.fourthViewController setLogoutDelegate:self];
    [self refreshUserType]; // 这里会初始化第二个 viewcontroller
}

- (void)refreshUserType{
    if ([[YUNEEDSConfig getSharedConfig] getUserType] != 2) { // 需求发布者
        self.secondViewController = (UINavigationController *)[self.storyboard instantiateViewControllerWithIdentifier:@"ReleaseRequirement"];
        self.data = publisherData;
    }else{
        NeedTypesViewController *secondViewController = (NeedTypesViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"MarketNaviVC"];
        [secondViewController setParentType:1];
        UINavigationController *secondNaviController = [[UINavigationController alloc] initWithRootViewController:secondViewController];
        self.secondViewController = secondNaviController;
        self.data = providerData;
    }
    [self.tableView reloadData];
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

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.data count];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            return 70;
            break;
        default:
            return 50;
            break;
    }
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"sssssss";
    static NSString *firtIdentifier = @"sssssss";
    
    if (indexPath.row == 0) {
        UITableViewCell *cell;
        if (!cell) {
            cell = [self.tableView dequeueReusableCellWithIdentifier:firtIdentifier];
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.backgroundColor = [UIColor clearColor];
            UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(24, 35, 80, 20)];
            titleLable.text = [self.data objectAtIndex:indexPath.row];
            titleLable.textColor = [UIColor whiteColor];
            [cell addSubview:titleLable];
            [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
            titleLable.font = [UIFont boldSystemFontOfSize:25];
            cell.userInteractionEnabled = NO;
            cell.textLabel.textColor = [UIColor whiteColor];
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            //
            UIImageView *footerSeperator = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"menu_seperator"]];
            [footerSeperator setFrame:CGRectMake(0, [self tableView:self.tableView heightForRowAtIndexPath:indexPath]-2, cell.frame.size.width, 2)];
            [cell addSubview:footerSeperator];
        }
        return cell;
    }else{
        UINib *nib = [UINib nibWithNibName:@"MenuCell" bundle:nil];
        [self.tableView registerNib:nib forCellReuseIdentifier:identifier];
        MenuCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
        [cell initCellWithImg:[iconData objectAtIndex:indexPath.row] title:[self.data objectAtIndex:indexPath.row]];
        cell.menuLabel.textColor = [UIColor whiteColor];
        cell.menuLabel.font = [UIFont systemFontOfSize:15];
        [cell setBackgroundColor:[UIColor clearColor]];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            break;
        case 1:
            self.slidingViewController.topViewController = self.firstViewController;
            break;
        case 2:
            if (![self doAuth:indexPath]) {
                return;
            }else{
                self.slidingViewController.topViewController = self.secondViewController;
            }
            break;
        case 3:
            if (![self doAuth:indexPath]){
                return;
            }else{
                self.slidingViewController.topViewController = self.thirdViewConroller;
            }
            break;
        default: // 个人中心
            if (![self doAuth:indexPath]) {
                return;
            }else{
                self.slidingViewController.topViewController = self.fourthViewController;
            }
            break;
    }

    menuSelectionHighlightedIndex = (int)indexPath.row;
    [self.slidingViewController resetTopViewAnimated:YES];
}

- (BOOL)doAuth:(NSIndexPath*)indexPath {
    if (![[YUNEEDSConfig getSharedConfig] isLogin]) {
        menuTempSelectionHighlightedIndex = (int)indexPath.row;
        UIAlertView *loginAlert = [[UIAlertView alloc] initWithTitle:@"登陆提示" message:@"该功能需要登陆后使用，是否前往登陆开启更多功能？" delegate:self cancelButtonTitle:@"不了，谢谢" otherButtonTitles:@"前往登陆", nil];
        [loginAlert show];
        return NO;
    }else{
        return YES;
    }

}

- (void)backMenuSelectionHighlight{
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:menuSelectionHighlightedIndex inSection:0] animated:YES scrollPosition:0];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            [self backMenuSelectionHighlight];
            break;
        default:{
            LoginViewController *loginVC = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginVC"];
            [loginVC setDelegate:self];
            [self presentViewController:loginVC animated:YES completion:nil];
            break;
        }
    }
}

// 登陆完成后操作协议实现方法
- (void) loginSuccessedOperation{
    [self refreshUserType];
    menuSelectionHighlightedIndex = menuTempSelectionHighlightedIndex;
    [self tableView:self.tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:menuTempSelectionHighlightedIndex inSection:0]];
}

- (void) loginFailedOperation{
    NSLog(@"bakc...");
    [self backMenuSelectionHighlight];
}

// 退出登陆完成后操作协议实现方法
- (void) logoutSuccessOperatino{
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] animated:YES scrollPosition:0];
    
    self.slidingViewController.topViewController = self.firstViewController;
    menuSelectionHighlightedIndex = 1;
    [self.slidingViewController resetTopViewAnimated:YES];
}

@end
