//
//  MyOrderDetailViewController.m
//  NEEDS
//
//  Created by JackYu on 5/18/14.
//  Copyright (c) 2014 Jackyu. All rights reserved.
//

#import "MyOrderDetailViewController.h"

@interface MyOrderDetailViewController (){
    NeedDetail *data;
}
@property(nonatomic, strong) BidViewController *bidViewController;
@end

@implementation MyOrderDetailViewController

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
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, [UIApplication sharedApplication].keyWindow.frame.size.width, [UIApplication sharedApplication].keyWindow.frame.size.height-64) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:self.tableView];
    
    // 配置视图
    self.bidViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"BidVC"];
    [self.bidViewController setBidDelegate:self];
    
    // 获取网络数据
    [self getDataFromServer];
    UIBarButtonItem *editBarButtonItem = [[UIBarButtonItem alloc ]initWithTitle:@"编辑" style:UIBarButtonItemStyleBordered target:self action:@selector(showMenu:)];
    self.navigationItem.rightBarButtonItem = editBarButtonItem;
}
- (void)getDataFromServer{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.labelText = @"正在加载需求详情，请稍候...";
    [AppDelegate.engine getNeedDetailById:self.needID completionHandler:^(JSONModel *aModelObject){
        [MBProgressHUD hideAllHUDsForView:self.navigationController.view animated:YES];
        data = (NeedDetail *)aModelObject;
        [self.tableView reloadData];
    }errorHandler:^(NSError *error){
        [MBProgressHUD hideAllHUDsForView:self.navigationController.view animated:YES];
        [UIAlertView showWithError:error];
    }];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 44;
    switch (indexPath.section) {
        case 0:
            return 160;
            break;
        case 1:
            return 140;
        case 2:
            return 100;
        default:
            return 59;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10.f;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 30)];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, 0, backView.frame.size.width-20, backView.frame.size.height)];
    [view setBackgroundColor:GlobalColorAlpha];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, tableView.frame.size.width-20, 30)];
    switch (section) {
        case 0:
            titleLabel.text = @"基本信息";
            break;
        case 1:
            titleLabel.text = @"交易详情";
            break;
        case 2:
            titleLabel.text = @"具体要求";
            break;
        default:
            titleLabel.text = @"讨论";
            break;
    }
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont italicSystemFontOfSize:16];
    [view addSubview:titleLabel];
    [backView addSubview:view];
    return backView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier_0 = @"sdfasdfa0";
    static NSString *identifier_1 = @"afasgasdg1";
    static NSString *identifier_2 = @"afasgasdg2";
    static NSString *identifier_3 = @"afasgasdgasdf3";
    switch (indexPath.section) {
        case 0:{
            UINib *nib = [UINib nibWithNibName:@"NeedDetailFirstCell" bundle:nil];
            [self.tableView registerNib:nib forCellReuseIdentifier:identifier_0];
            NeedDetailFirstCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identifier_0];
            [cell initCellWithNeed:data];
            [cell setBackgroundColor:[UIColor clearColor]];
            [cell setUserInteractionEnabled:NO];
            
            // 设置图标
            if ([[data good] isEqualToString:@"1"]) {
                UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"selection_icon.png"]];
                [img setFrame:CGRectMake(250, 6, 30, 30)];
                [cell addSubview:img];
            }
            return cell;
        }
            break;
        case 1:{
            UINib *nib = [UINib nibWithNibName:@"NeedDetailSecondeCell" bundle:nil];
            [self.tableView registerNib:nib forCellReuseIdentifier:identifier_1];
            NeedDetailSecondeCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identifier_1];
            [cell initCellWithNeed:data];
            [cell setBackgroundColor:[UIColor clearColor]];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            return cell;
        }
            break;
        case 2:{
            UINib *nib = [UINib nibWithNibName:@"NeedDetailThirdCell" bundle:nil];
            [self.tableView registerNib:nib forCellReuseIdentifier:identifier_2];
            NeedDetailThirdCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identifier_2];
            [cell initCell:data];
            [cell setBackgroundColor:[UIColor clearColor]];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            return cell;
        }
            break;
        default:{
            UINib *nib = [UINib nibWithNibName:@"NeedDetailfourthCell" bundle:nil];
            [self.tableView registerNib:nib forCellReuseIdentifier:identifier_3];
            NeedDetailfourthCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identifier_3];
            [cell initCell];
            [cell setBackgroundColor:[UIColor clearColor]];
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            [cell setUserInteractionEnabled:NO];
            return cell;
        }
            break;
    }
}


- (IBAction)bidAction:(id)sender {
    if (![[YUNEEDSConfig getSharedConfig] isLogin]) {
        // 先登录
        UIAlertView *loginAlert = [[UIAlertView alloc] initWithTitle:@"请先登录" message:@"竞标功能需要登录以后才可使用" delegate:self cancelButtonTitle:@"不了，谢谢" otherButtonTitles:@"好的，登录", nil];
        loginAlert.tag = 1;
        [loginAlert show];
    }else if ([[YUNEEDSConfig getSharedConfig] getUserType] != 2){
        // 只有服务提供方可以竞标
        UIAlertView *wrongTypeAlert = [[UIAlertView alloc] initWithTitle:@"提示信息" message:@"对不起，竞标功能只有服务商可以使用，请使用服务商账户登录后使用" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [wrongTypeAlert show];
    }else{
        // 可以竞标
        [self.bidViewController.view setAlpha:0.0f];
        [self.navigationController.view addSubview:self.bidViewController.view];
        [self.bidViewController setNeedDetail:data];
        [UIView animateWithDuration:0.3f animations:^(void){
            [self.bidViewController.view setAlpha:1.0f];
        }completion:nil];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 1) { // 登录提示框
        if (buttonIndex >= 1) {
            [self doLogin];
        }
    }
}

// 登录成功后操作协议
- (void)loginSuccessedOperation{
    UIAlertView *loginSuccessAlert = [[UIAlertView alloc] initWithTitle:@"提示信息" message:@"登录成功" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
    [loginSuccessAlert show];
}

- (void)loginFailedOperation{
    UIAlertView *loginFailedAlert = [[UIAlertView alloc] initWithTitle:@"提示信息" message:@"登录失败" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
    [loginFailedAlert show];
}

// 竞标完成后操作协议
- (void)bidSuccessed{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)bidFailed{
    
}

- (void)bidCancel{
    
}

// 菜单按钮
- (IBAction)showMenu:(UIBarButtonItem *)sender
{
    NSArray *menuItems;
    menuItems = [self getKxMenuItems];
    
    KxMenuItem *first = menuItems[0];
    first.foreColor = [UIColor colorWithRed:47/255.0f green:112/255.0f blue:225/255.0f alpha:1.0];
    first.alignment = NSTextAlignmentCenter;
    
    CGRect frame = CGRectMake(self.view.frame.size.width-41,32,25,20);
    if ([menuItems count] > 1) {
        [KxMenu showMenuInView:self.navigationController.view
                      fromRect:frame
                     menuItems:menuItems];
    }else{
        UIAlertView *noOperationAlert = [[UIAlertView alloc] initWithTitle:@"提示信息" message:@"没有更多操作" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [noOperationAlert show];
    }
}

- (NSMutableArray*)getKxMenuItems{
    NSMutableArray *menuItems = [[NSMutableArray alloc] init];
    
    [menuItems addObject:[KxMenuItem menuItem:@"选择操作"
                   image:nil
                  target:nil
                  action:NULL]];

    
    if (![[YUNEEDSConfig getSharedConfig] isLogin]) { // 未登录用户
        [menuItems addObject:[KxMenuItem menuItem:@"登陆"
                                           image:[UIImage imageNamed:@""]
                                          target:self
                                           action:@selector(doLogin)]];
        return menuItems;
    }
    
    if ([[YUNEEDSConfig getSharedConfig] getUserType] == 1) { // 需求发布方
        switch ([[data state] intValue]) {
            case 1: // 1.2 号动作
                [menuItems addObject:[KxMenuItem menuItem:@"竞标列表"
                                                    image:[UIImage imageNamed:@""]
                                                   target:self
                                                   action:@selector(seeBidList)]];
                return menuItems;
                break;
            case 2:{ // 1.3, 1.7 号动作
                [menuItems addObject:[KxMenuItem menuItem:@"查看服务商"
                                                    image:[UIImage imageNamed:@""]
                                                   target:self action:@selector(seeProvierInfo)]];
                [menuItems addObject:[KxMenuItem menuItem:@"留言给服务商"
                                                    image:[UIImage imageNamed:@""]
                                                   target:self action:@selector(messageToProvider)]];
                return menuItems;
            }
            case 3:{ // 1.3, 1.4, 1.7 号动作
                [menuItems addObject:[KxMenuItem menuItem:@"查看服务商"
                                                    image:[UIImage imageNamed:@""]
                                                   target:self action:@selector(seeProvierInfo)]];
                [menuItems addObject:[KxMenuItem menuItem:@"托管酬金"
                                                    image:[UIImage imageNamed:@""]
                                                   target:self action:@selector(payToAlipay)]];
                [menuItems addObject:[KxMenuItem menuItem:@"留言给服务商"
                                                    image:[UIImage imageNamed:@""]
                                                   target:self action:@selector(messageToProvider)]];
                return menuItems;
            }
            case 4:{ // 1.3, 1.7 号动作
                [menuItems addObject:[KxMenuItem menuItem:@"查看服务商"
                                                    image:[UIImage imageNamed:@""]
                                                   target:self action:@selector(seeProvierInfo)]];
                [menuItems addObject:[KxMenuItem menuItem:@"留言给服务商"
                                                    image:[UIImage imageNamed:@""]
                                                   target:self action:@selector(messageToProvider)]];
                return menuItems;
            }
            case 5:{ // 1.3, 1.9, 1.7 号动作
                [menuItems addObject:[KxMenuItem menuItem:@"查看服务商"
                                                    image:[UIImage imageNamed:@""]
                                                   target:self action:@selector(seeProvierInfo)]];
                [menuItems addObject:[KxMenuItem menuItem:@"确认收到服务"
                                                    image:[UIImage imageNamed:@""]
                                                   target:self action:@selector(confirmDelivery)]];
                [menuItems addObject:[KxMenuItem menuItem:@"留言给服务商"
                                                    image:[UIImage imageNamed:@""]
                                                   target:self action:@selector(messageToProvider)]];
                return menuItems;
            }
            case 6:{ // 1.3, 1.7 号动作
                [menuItems addObject:[KxMenuItem menuItem:@"查看服务商"
                                                    image:[UIImage imageNamed:@""]
                                                   target:self action:@selector(seeProvierInfo)]];
                [menuItems addObject:[KxMenuItem menuItem:@"留言给服务商"
                                                    image:[UIImage imageNamed:@""]
                                                   target:self action:@selector(messageToProvider)]];
                return menuItems;
            }
            case 7:{ // 1.3, 1.6, 1.7 号动作
                [menuItems addObject:[KxMenuItem menuItem:@"查看服务商"
                                                    image:[UIImage imageNamed:@""]
                                                   target:self action:@selector(seeProvierInfo)]];
                [menuItems addObject:[KxMenuItem menuItem:@"给服务商评价"
                                                    image:[UIImage imageNamed:@""]
                                                   target:self action:@selector(commentProvider)]];
                [menuItems addObject:[KxMenuItem menuItem:@"留言给服务商"
                                                    image:[UIImage imageNamed:@""]
                                                   target:self action:@selector(messageToProvider)]];
                return menuItems;
            }
            default:
                break;
        }
        return menuItems;
    }else { // 服务商
        int stateNow = [[data state] intValue];
        if (stateNow == 1) { // 2.1 号动作 （状态1）
            [menuItems addObject:[KxMenuItem menuItem:@"竞标"
                                                image:[UIImage imageNamed:@""]
                                               target:self
                                               action:@selector(doBidAction)]];
            return menuItems;
        }else if (stateNow == 6) { // 2.2 号动作 （状态6）
            [menuItems addObject:[KxMenuItem menuItem:@"确认收款"
                                                image:[UIImage imageNamed:@""]
                                               target:self
                                               action:@selector(confirmPayment)]];
        }
        // 2.3 号动作 （状态2~7）
        [menuItems addObject:[KxMenuItem menuItem:@"留言"
                                            image:[UIImage imageNamed:@""]
                                           target:self
                                           action:@selector(messageToPublisher)]];
        return menuItems;
    }
    
}

// （0.0号动作）执行登陆操作
- (void)doLogin{
    LoginViewController *loginVC = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginVC"];
    [loginVC setDelegate:self];
    [self presentViewController:loginVC animated:YES completion:nil];
}

// （1.2号动作）执行查看竞标者列表操作
- (void)seeBidList{
    [self performSegueWithIdentifier:@"SegueMyorderdetailToBidslist" sender:self];
}

// （1.3号动作）执行查看服务商操作
- (void)seeProvierInfo{
    ProviderDetailViewController *providerDetailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ProviderDetailVC"];
    [providerDetailVC setProviderId:[data fk_provider]];
    [self.navigationController pushViewController:providerDetailVC animated:YES];
}

// （1.4号动作）执行托管酬金操作
- (void)payToAlipay{
    [self performSegueWithIdentifier:@"SegueMyorderdetailToPaytoalipay" sender:self];
}

// （1.9号动作）执行确认收到交付物操作(会将钱打给服务商)
- (void)confirmDelivery{
    [self performSegueWithIdentifier:@"SegueOrderdetailToConfirm" sender:self];
}

// （1.6号动作）执行评价服务商操作
- (void)commentProvider{
    [self performSegueWithIdentifier:@"SegueNeeddetailToRateview" sender:self];
}

// （1.7号动作）执行留言操作
- (void)messageToProvider{
    MessageDetailViewController *meesageDetailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MessageDetailVC"];
    [meesageDetailVC setUser:[data fk_provider]];
    [self.navigationController pushViewController:meesageDetailVC animated:YES];
}

// （2.1号动作）执行竞标操作
- (void)doBidAction{
    [self bidAction:nil];
}

// （2.2号动作）执行确认收款操作
- (void)confirmPayment{
    [self performSegueWithIdentifier:@"SegueOrderdetailToConfirm" sender:self];
}

// （2.3号动作）执行留言操作
- (void)messageToPublisher{
    MessageDetailViewController *meesageDetailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MessageDetailVC"];
    [meesageDetailVC setUser:[data fk_publisher]];
    [self.navigationController pushViewController:meesageDetailVC animated:YES];
}

- (void) pushMenuItem:(id)sender
{
    NSLog(@"%@", sender);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"SegueMyorderdetailToBidslist"]) {// 跳转到竞标者列表页面
        [((BIdsListViewController*)segue.destinationViewController) setNeedDetail:data];
    }else if ([segue.identifier isEqualToString:@"SegueMyorderdetailToPaytoalipay"]){ // 跳转到支付界面
        [((PayToAlipayViewController*)segue.destinationViewController) setNeedDetail:data];
    }else if ([segue.identifier isEqualToString:@"SegueOrderdetailToConfirm"]){ // 跳转到确认页面
        [((ConfirmDeliveryViewController*)segue.destinationViewController) initWithRequirementId:[data pk_id] userType:[[YUNEEDSConfig getSharedConfig] getUserType]];
    }else if ([segue.identifier isEqualToString:@"SegueNeeddetailToRateview"]){// 跳转到评价页面
        [((RateViewController*)segue.destinationViewController) initWithRequirementId:[data pk_id]];
    }
    
}


@end
