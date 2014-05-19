//
//  UserCenterViewCtroller.m
//  NEEDS
//
//  Created by JackYu on 5/7/14.
//  Copyright (c) 2014 Jackyu. All rights reserved.
//

#import "UserCenterViewCtroller.h"
#import "UIViewController+ECSlidingViewController.h"

@interface UserCenterViewCtroller (){
    NSArray *data;
}

@end

@implementation UserCenterViewCtroller

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
    data = [NSArray arrayWithObjects:@"用户资料", @"我的订单", @"消息中心", nil];
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
    return 3;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"asdfasdfasdf";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        UIView *seperatorView = [[UIView alloc] initWithFrame:CGRectMake(10, cell.frame.size.height-1, cell.frame.size.width-20, 1)];
        [seperatorView setBackgroundColor:[UIColor lightGrayColor]];
        [cell addSubview:seperatorView];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    cell.textLabel.text = [data objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //    [self performSelector:@selector(deselectTableViewCellAtIndexPath:) withObject:nil afterDelay:0.5f];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 2:
            [self performSegueWithIdentifier:@"SegueUsercenterToMessagecenter" sender:self];
            break;
            
        default:
            break;
    }
}

- (void)deselectTableViewCellAtIndexPath:(NSIndexPath*)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (IBAction)backToMenuAction:(id)sender {
    [self.slidingViewController anchorTopViewToRightAnimated:YES];
}

- (IBAction)logoutButtonTouchUpInside:(id)sender {
    
    UIAlertView *confirmAlert = [[UIAlertView alloc] initWithTitle:@"确认提示框" message:@"是否确认登陆" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"继续退出", nil];
    [confirmAlert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex >= 1) {
        [[YUNEEDSConfig getSharedConfig] doLogoutConfig];
        [((UserCenterNavigationViewController *)self.navigationController).logoutDelegate logoutSuccessOperatino];
    }
}
@end
