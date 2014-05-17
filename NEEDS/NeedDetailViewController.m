//
//  NeedDetailViewController.m
//  NEEDS
//
//  Created by JackYu on 5/13/14.
//  Copyright (c) 2014 Jackyu. All rights reserved.
//

#import "NeedDetailViewController.h"

@interface NeedDetailViewController (){
    UIFont *titleFont;
    UIFont *contentFont;
    NeedDetail *data;
    
    // 第一层
    UIView *firstBlockView;
    UILabel *firstBlockTitleLabel;
    
//    UIImageView *userImageView;
    UILabel *nameLabel;
    UIImageView *selectionIcon;
    UILabel *stateLabel;
    UILabel *priceLabel;
    UILabel *createTimeLabel;
    UILabel *deadLineLabel;
    UILabel *userNameLabel;
    UILabel *categoryLabel;
    
    // 第二层
    UIView *secondBlockView;
    UILabel *secondBlockTitleLabel;
    UIView *progressView;
    UILabel *secondBlockDescriptinoLabel;
    
    // 第三层
    UIView *thirdBlockView;
    UILabel *thirdBlockTitleLabel;
    UITextView *thirdBlockDescription;
}
@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, strong) BidViewController *bidViewController;
@end

@implementation NeedDetailViewController

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
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64-52)]; // 64+16
    [self.scrollView setContentSize:CGSizeMake(self.view.frame.size.width, 568)];
    
    // 配置参数
    titleFont = [UIFont boldSystemFontOfSize:16];
    contentFont = [UIFont systemFontOfSize:14];
    
    // 底部button
    [self.leaveMessageButton.layer setCornerRadius:self.leaveMessageButton.frame.size.height/2];
    [self.bidButton.layer setCornerRadius:self.bidButton.frame.size.height/2];
    
    [self drawView];
    [self getDataFromServer];
    
    self.bidViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"BidVC"];
    [self.bidViewController setBidDelegate:self];
    
    NSLog(@"tt%f",self.view.frame.size.height);
}

- (void)getDataFromServer{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.labelText = @"正在加载需求详情，请稍候...";
    [AppDelegate.engine getNeedDetailById:self.needID completionHandler:^(JSONModel *aModelObject){
        [MBProgressHUD hideAllHUDsForView:self.navigationController.view animated:YES];
        data = (NeedDetail *)aModelObject;
        [self refreshView];
    }errorHandler:^(NSError *error){
        [MBProgressHUD hideAllHUDsForView:self.navigationController.view animated:YES];
        [UIAlertView showWithError:error];
    }];
}

- (void) drawView{
    // 第一层
    firstBlockView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 300, 30)];
    [firstBlockView setBackgroundColor:GlobalColor];
    firstBlockTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(11, 4, 79, 21)];
    firstBlockTitleLabel.text = @"基本信息";
    firstBlockTitleLabel.font = titleFont;
    firstBlockTitleLabel.textColor = [UIColor whiteColor];
    [firstBlockView addSubview:firstBlockTitleLabel];
    [self.scrollView addSubview:firstBlockView];
    
    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 48, 210, 21)];
    nameLabel.text = [data name];//@"防伪查询";
    nameLabel.font = contentFont;
    [self.scrollView addSubview:nameLabel];
    
    selectionIcon = [[UIImageView alloc] initWithFrame:CGRectMake(279, 58, 21, 21)];
    if ([[data good] isEqualToString:@"1"]) {
        [selectionIcon setImage:[UIImage imageNamed:@"selection_icon.png"]];
    }
    [self.scrollView addSubview:selectionIcon];
    
    stateLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 73, 120, 21)];
    stateLabel.text = [NSString stringWithFormat:@"状态:%@", [data state]];
    stateLabel.font = contentFont;
    [self.scrollView addSubview:stateLabel];
    
    priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(180, 74, 120, 21)];
    priceLabel.text = [NSString stringWithFormat:@"预算:%@", [data budget]];//@"xxx元";
    priceLabel.font = contentFont;
    [self.scrollView addSubview:priceLabel];
    
    createTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 99, 280, 21)];
    createTimeLabel.text = [NSString stringWithFormat:@"创建日期:%@", [data createtime]];
    createTimeLabel.font = contentFont;
    [self.scrollView addSubview:createTimeLabel];
    
    deadLineLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 125, 280, 21)];
    deadLineLabel.text = [NSString stringWithFormat:@"截止日期:%@", [data createtime]];
    deadLineLabel.font = contentFont;
    [self.scrollView addSubview:deadLineLabel];
    
    userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 151, 280, 21)];
    userNameLabel.text = [NSString stringWithFormat:@"创建者:%@", [data user_name]];//@"用户名";
    userNameLabel.font = contentFont;
    [self.scrollView addSubview:userNameLabel];
    
    categoryLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 177, 280, 21)];
    categoryLabel.text = [NSString stringWithFormat:@"类别:%@", [data category]];
    categoryLabel.font = contentFont;
    [self.scrollView addSubview:categoryLabel];
    
//    userImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 60, 60)];
//    [userImageView setImage:[UIImage imageNamed:@"default_user_img"]];
//    [self.scrollView addSubview:userImageView];
    
    // 第二层
    secondBlockView = [[UIView alloc] initWithFrame:CGRectMake(10, 220, 300, 30)];
    [secondBlockView setBackgroundColor:GlobalColor];
    secondBlockTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(11, 4, 79, 21)];
    secondBlockTitleLabel.text = @"交易详情";
    secondBlockTitleLabel.font = titleFont;
    secondBlockTitleLabel.textColor = [UIColor whiteColor];
    [secondBlockView addSubview:secondBlockTitleLabel];
    [self.scrollView addSubview:secondBlockView];
    
//    progressView = [[UIView alloc] initWithFrame:CGRectMake(20, 258, 280, 106)];
//    [progressView setBackgroundColor:[UIColor lightGrayColor]];
//    progressView = [[NeedProcessView alloc] initWithFrame:CGRectMake(20, 258, 280, 106)];
    NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"NeedProcessView" owner:self options:nil];
    progressView = (NeedProcessView *)[nibs objectAtIndex:0];
    [(NeedProcessView *)progressView setState:4];
    [progressView setFrame:CGRectMake(20, 258, 280, 106)];
    [self.scrollView addSubview:progressView];
    
    secondBlockDescriptinoLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 378, 280, 21)];
    secondBlockDescriptinoLabel.text = [NSString stringWithFormat:@"目前共有%d人参加了该竞标",22];
    secondBlockDescriptinoLabel.font = contentFont;
    [self.scrollView addSubview:secondBlockDescriptinoLabel];
    
    // 第三层
    thirdBlockView = [[UIView alloc] initWithFrame:CGRectMake(10, 417, 300, 30)];
    [thirdBlockView setBackgroundColor:GlobalColor];
    thirdBlockTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(11, 4, 79, 21)];
    thirdBlockTitleLabel.text = @"具体要求";
    thirdBlockTitleLabel.font = titleFont;
    thirdBlockTitleLabel.textColor = [UIColor whiteColor];
    [thirdBlockView addSubview:thirdBlockTitleLabel];
    [self.scrollView addSubview:thirdBlockView];
    
    thirdBlockDescription = [[UITextView alloc] initWithFrame:CGRectMake(20, 455, 280, 223)];
    thirdBlockDescription.text = [data description];
    thirdBlockDescription.font = contentFont;
    [self.scrollView addSubview:thirdBlockDescription];
    
    [self.view addSubview:self.scrollView];
}

- (void) refreshView{
    [self.bidViewController setNeedDetail:data];
    // 第一层
//    [userImageView setImage:[UIImage imageNamed:@"default_user_img"]];
    
    nameLabel.text = [data name];//@"防伪查询";
    
    if ([[data good] isEqualToString:@"1"]) {
        NSLog(@"get good str%@",[data good]);
        [selectionIcon setImage:[UIImage imageNamed:@"selection_icon.png"]];
    }else{
        NSLog(@"good str%@",[data good]);
    }
    
    stateLabel.text = [NSString stringWithFormat:@"状态:%@", [data getStateDescription]];
    
    priceLabel.text = [NSString stringWithFormat:@"预算:%@", [data budget]];//@"xxx元";
    
    createTimeLabel.text = [NSString stringWithFormat:@"创建日期:%@", [data createtime]];
    
    deadLineLabel.text = [NSString stringWithFormat:@"截止日期:%@", [data createtime]];
    
    userNameLabel.text = [NSString stringWithFormat:@"创建者:%@", [data user_name]];//@"用户名";
    
    categoryLabel.text = [NSString stringWithFormat:@"类别:%@", [data category]];
    
    // 第二层
//    [progressView setBackgroundColor:[UIColor lightGrayColor]];
    
    secondBlockDescriptinoLabel.text = [NSString stringWithFormat:@"目前共有%@人参加了该竞标",[data bid_count]];
    
    // 第三层
    thirdBlockDescription.text = [data description];
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

- (IBAction)leaveMessageAction:(id)sender {
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
//        [self performSegueWithIdentifier:@"SegueNeeddetailToBid" sender:self];
        [self.bidViewController.view setAlpha:0.0f];
        [self.navigationController.view addSubview:self.bidViewController.view];
        [UIView animateWithDuration:0.3f animations:^(void){
            [self.bidViewController.view setAlpha:1.0f];
        }completion:nil];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 1) { // 登录提示框
        if (buttonIndex >= 1) {
            LoginViewController *loginVC = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginVC"];
            [loginVC setDelegate:self];
            [self presentViewController:loginVC animated:YES completion:nil];
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
@end
