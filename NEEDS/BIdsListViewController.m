//
//  BIdsListViewController.m
//  NEEDS
//
//  Created by JackYu on 5/18/14.
//  Copyright (c) 2014 Jackyu. All rights reserved.
//

#import "BIdsListViewController.h"

@interface BIdsListViewController (){
    NSArray *data;
}

@property(strong, nonatomic)UITableView *tableView;

@end

@implementation BIdsListViewController

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
    // 添加表
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, [UIApplication sharedApplication].keyWindow.frame.size.width, [UIApplication sharedApplication].keyWindow.frame.size.height-64) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    // 加载数据
    [self getDataFromServerWithOffset:0];
}

- (void)getDataFromServerWithOffset:(int)mOffset{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.labelText = @"正在加载...";
    [AppDelegate.engine getBidsListWithNeed:[self.needDetail pk_id] offset:mOffset completionHandler:^(NSMutableArray *result){
        [MBProgressHUD hideAllHUDsForView:self.navigationController.view animated:YES];
        data = result;
        [self.tableView reloadData];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [data count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"sfasdfasdf";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    cell.textLabel.text = [((BidDetail*)[data objectAtIndex:indexPath.row]) name];
    cell.detailTextLabel.text = [((BidDetail*)[data objectAtIndex:indexPath.row]) time];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"SegueBidslistToBidedetail" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"SegueBidslistToBidedetail"]) { // 跳转到竞标详情页面
        [((BidDetailViewController*)segue.destinationViewController) setBid:[data objectAtIndex:[self.tableView indexPathForSelectedRow].row]];
        [((BidDetailViewController*)segue.destinationViewController) setSelectDelegate:self];
    }
}

// 选取中标服务商成功后委托事件
- (void)selectBidSuccess{
    [self performSelector:@selector(backToParent) withObject:nil afterDelay:0.5f];
}
- (void)backToParent{
//    [self.navigationController popViewControllerAnimated:YES];
}

@end
