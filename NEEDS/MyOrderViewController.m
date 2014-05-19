//
//  MyOrderViewController.m
//  NEEDS
//
//  Created by JackYu on 5/7/14.
//  Copyright (c) 2014 Jackyu. All rights reserved.
//

#import "MyOrderViewController.h"

@interface MyOrderViewController (){
    NSMutableArray *data; // 表格会显示的数据
    NSMutableArray *data0; // 第一个tab对应的表格的数据
    NSMutableArray *data1;
    NSMutableArray *data2;
    BOOL tab0LoadFirstTime; // 改tab是不是第一次被加载
    BOOL tab1LoadFirstTime;
    BOOL tab2LoadFirstTime;
    int tabChoosedIndex;
    MJRefreshHeaderView *header;
    MJRefreshFooterView *footer;
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
    if (((MyOrderNavigationController*)self.navigationController).userType == 2) { // 服务商
        [[self.tabButtons objectAtIndex:0] setTitle:@"竞标中" forState:UIControlStateNormal];
    }else{ // 需求发布者
        [[self.tabButtons objectAtIndex:0] setTitle:@"未托管" forState:UIControlStateNormal];
    }
    [[self.tabButtons objectAtIndex:1] setTitle:@"开发中" forState:UIControlStateNormal];
    [[self.tabButtons objectAtIndex:2] setTitle:@"已完成" forState:UIControlStateNormal];
    
    // 设置 tab 标题颜色 正常黑色，点中紫色
    for ( int i =0 ; i < [self.tabButtons count]; i++) {
        [[self.tabButtons objectAtIndex:i] setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [[self.tabButtons objectAtIndex:i]setTitleColor:GlobalColorAlpha forState:UIControlStateHighlighted];
    }
    
    self.tabIndicator = [[UIView alloc] initWithFrame:CGRectMake(3, 102, 100, 2)];
    [self.tabIndicator setBackgroundColor:GlobalColor];
    [self.view addSubview:self.tabIndicator];
    
    // 注册上拉下拉刷新控件
    header = [[MJRefreshHeaderView alloc] init];
    header.delegate = self;
    header.scrollView = self.tableView;
    
    footer = [[MJRefreshFooterView alloc] init];
    footer.delegate = self;
    footer.scrollView = self.tableView;
    
    tab0LoadFirstTime = YES;
    tab1LoadFirstTime = YES;
    tab2LoadFirstTime = YES;
    
    [self chooseTabWithInt:0];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (((MyOrderNavigationController*)self.navigationController).userType == 2) { // 服务商
        [[self.tabButtons objectAtIndex:0] setTitle:@"竞标中" forState:UIControlStateNormal];
    }else{ // 需求发布者
        [[self.tabButtons objectAtIndex:0] setTitle:@"未托管" forState:UIControlStateNormal];
    }
}

- (void)chooseTabWithInt:(int)tabIndex{
    [UIView animateWithDuration:0.3f animations:^(){
        // 设置tab标题颜色
        for (int i=0 ; i<[self.tabButtons count]; i++) {
            if (i != tabIndex) {
                [[self.tabButtons objectAtIndex:i] setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }else{
                [[self.tabButtons objectAtIndex:i] setTitleColor:GlobalColorAlpha forState:UIControlStateNormal];
            }
        }
        // 设置indicator位置
        [self.tabIndicator setFrame:CGRectMake(3+106*tabIndex, 102, 100, 2)];
    }completion:nil];
    
    // 更换table中数据
    switch (tabIndex) {
        case 0:
            data = data0;
            if (tab0LoadFirstTime) {
                [self getDataFromNet:tabIndex offset:0];
            }
            break;
        case 1:
            data = data1;
            if (tab1LoadFirstTime) {
                [self getDataFromNet:tabIndex offset:0];
            }
            break;
        default:
            data = data2;
            if (tab2LoadFirstTime) {
                [self getDataFromNet:tabIndex offset:0];
            }
            break;
    }
    tabChoosedIndex = tabIndex;
    [self.tableView reloadData];
}

- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"HH : mm : ss.SSS";
    if (header == refreshView) { // 刷新数据
        [self getDataFromNet:tabChoosedIndex offset:0];
    } else { // 加载更多数据
        [self getDataFromNet:tabChoosedIndex offset:(int)[data count]];
    }
}

- (void) getDataFromNet:(int)tabIndex offset:(int)mOffset{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.labelText = @"正在加载";
    [AppDelegate.engine getOrderWithUsertype:[((MyOrderNavigationController*)self.navigationController) userType] orderType:tabIndex+1 offset:mOffset completionHandler:^(NSMutableArray *results){
        // 关闭加载框
        [MBProgressHUD hideAllHUDsForView:self.navigationController.view animated:YES];
        
        // 关闭上拉下拉刷新
        [header endRefreshing];
        [footer endRefreshing];
        
        switch (tabIndex) {
            case 0:
                if (mOffset != 0) {
                    [data0 addObjectsFromArray:results];
                }else{
                    data0 = [results mutableCopy];
                }
                data = data0;
                tab0LoadFirstTime = NO;
                break;
            case 1:
                if (mOffset != 0) {
                    [data1 addObjectsFromArray:results];
                }else{
                    data1 = [results mutableCopy];
                }
                data = data1;
                tab1LoadFirstTime = NO;
                break;
            default:
                if (mOffset != 0) {
                    [data2 addObjectsFromArray:results];
                }else{
                    data2 = [results mutableCopy];
                }
                data = data2;
                tab2LoadFirstTime = NO;
                break;
        }
        [self.tableView reloadData];
    }errorHandler:^(NSError *error){
        // 关闭加载框
        [MBProgressHUD hideAllHUDsForView:self.navigationController.view animated:YES];
        
        // 关闭上拉下拉刷新
        [header endRefreshing];
        [footer endRefreshing];
        
        [UIAlertView showWithError:error];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"SegueMyorderToMyorderdetail"]) {
        [segue.destinationViewController setNeedID:[[data objectAtIndex:[self.tableView indexPathForSelectedRow].row] pk_id]];
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [data count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"ssssdfaadfa";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        UIView *bgView = [[UIView alloc] init];
        [bgView setBackgroundColor:GlobalColorAlpha];
        [bgView setAlpha:0.5f];
        [cell setSelectedBackgroundView:bgView];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"￥%@  %@", [[data objectAtIndex:indexPath.row] budget], [[data objectAtIndex:indexPath.row] name]];
    cell.detailTextLabel.text = [((MyOrderDetail*)[data objectAtIndex:indexPath.row]) createtime];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"SegueMyorderToMyorderdetail" sender:self];
}

- (IBAction)tabClickAction:(id)sender {
    [self chooseTabWithInt:(int)((UIButton*)sender).tag];
}

- (IBAction)backToMenuAction:(id)sender {
    [self.slidingViewController anchorTopViewToRightAnimated:YES];
}
@end
