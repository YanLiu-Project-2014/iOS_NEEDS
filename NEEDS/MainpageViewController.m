//
//  MainpageViewController.m
//  NEEDS
//
//  Created by JackYu on 5/7/14.
//  Copyright (c) 2014 Jackyu. All rights reserved.
//

#import "MainpageViewController.h"

#import "UIViewController+ECSlidingViewController.h"
#import "MEDynamicTransition.h"
#import "METransitions.h"

@interface MainpageViewController (){
    BOOL chooseSearchTypeIsShow;
    NSArray *needsData;
    NSArray *providersData;
    ProviderDetail *providerDetail;
}
@property (nonatomic, strong) METransitions *transitions;
@property (nonatomic, strong) UIPanGestureRecognizer *dynamicTransitionPanGesture;

@property(nonatomic, readwrite) BOOL networkOperationIsDone;
@end

@implementation MainpageViewController

/**
 *  主页主要参数： 原先底部tab（46）, 顶部搜索（60）
 *
 *  @param nibNameOrNil   nil
 *  @param nibBundleOrNil nil
 *
 *  @return nil
 *
 *  @since 1.0
 */
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
//    self.slidingViewController.anchorLeftPeekAmount = 300.f;
//    self.slidingViewController.anchorLeftRevealAmount = 100.f;
    
//    self.slidingViewController.anchorRightPeekAmount = 300.f;
    self.slidingViewController.anchorRightRevealAmount = 128.f;
    
//    self.clearsSelectionOnViewWillAppear = NO;
    
    self.transitions.dynamicTransition.slidingViewController = self.slidingViewController;
    
    self.slidingViewController.topViewAnchoredGesture = ECSlidingViewControllerAnchoredGestureTapping | ECSlidingViewControllerAnchoredGesturePanning;
    self.slidingViewController.customAnchoredGestures = @[];
    [self.navigationController.view removeGestureRecognizer:self.dynamicTransitionPanGesture];
    [self.navigationController.view addGestureRecognizer:self.slidingViewController.panGesture];


    
    [self getDataFromRemoteServer];
    
}

- (UIPanGestureRecognizer *)dynamicTransitionPanGesture {
    if (_dynamicTransitionPanGesture) return _dynamicTransitionPanGesture;
    
    _dynamicTransitionPanGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self.transitions.dynamicTransition action:@selector(handlePanGesture:)];
    
    return _dynamicTransitionPanGesture;
}

- (void) getDataFromRemoteServer{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.labelText = @"正在加载数据...";
    [AppDelegate.engine getSelectionInMainpage:@"" completionHandler:^(NSDictionary *resultsDictionary){
        [MBProgressHUD hideAllHUDsForView:self.navigationController.view animated:YES];
        needsData = [resultsDictionary objectForKey:@"NeedDetail"];
//        providerDetail = [[resultsDictionary objectForKey:@"ProviderDetail"] objectAtIndex:0];
        providersData = [resultsDictionary objectForKey:@"ProviderDetail"];
        [self refreshView];
    }errorHandler:^(NSError *error){
        [MBProgressHUD hideAllHUDsForView:self.navigationController.view animated:YES];
        [UIAlertView showWithError:error];
    }];
}

- (void) refreshView{
    [self.tableView reloadData];
    [self.providerTableView reloadData];
//    self.providerName.text = [providerDetail name];
//    self.providerGoodatLabel.text = [providerDetail advantage];
//    self.rateLabel.text = [NSString stringWithFormat:@"好评率：%@",[providerDetail rate_count]];
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
    if ([segue.identifier isEqualToString:@"segueMainpageToNeedDetail"]) { 
        [segue.destinationViewController setNeedID:[[needsData objectAtIndex:[self.tableView indexPathForSelectedRow].row] pk_id]];
    }else if ([segue.identifier isEqualToString:@"segueMainpageToNeedTypes"]){
        [segue.destinationViewController setParentType:0];
    }else if ([segue.identifier isEqualToString:@"segueMainpageToProviderDetail"]){
        [segue.destinationViewController setProviderId:((ProviderDetail*)[providersData objectAtIndex:[self.providerTableView indexPathForSelectedRow].row]).pk_id];
    }
}


- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;//[needsData count];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.tableView) {
        return [needsData count];//[[needsData objectAtIndex:section] count];
    }else{
        return [providersData count];
    }
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.tableView) {
        static NSString *identify = @"ttttt";
        UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identify];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identify];
            UIView *seperatedView = [[UIView alloc] initWithFrame:CGRectMake(10, cell.frame.size.height-1, cell.frame.size.width-20, 1)];
            [seperatedView setBackgroundColor:[UIColor lightGrayColor]];
            [cell addSubview:seperatedView];
        }
        cell.textLabel.text = [[needsData objectAtIndex:indexPath.row] name];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"￥%@ %@", [[needsData objectAtIndex:indexPath.row] budget], [[needsData objectAtIndex:indexPath.row] description]];
        return cell;
    }else{
        static NSString *providerIdentifier = @"sssssss";
        UINib *nib = [UINib nibWithNibName:@"ProviderDescriptionCell" bundle:nil];
        [self.providerTableView registerNib:nib forCellReuseIdentifier:providerIdentifier];
        ProviderDescriptionCell *cell = [self.providerTableView dequeueReusableCellWithIdentifier:providerIdentifier];
        [cell initCellWithName:[[providersData objectAtIndex:indexPath.row] name] rateText:[[providersData objectAtIndex:indexPath.row] rate_count] advantageText:[[providersData objectAtIndex:indexPath.row] advantage]];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.tableView) {
        [self performSegueWithIdentifier:@"segueMainpageToNeedDetail" sender:self];
        [self performSelector:@selector(delete:) withObject:nil afterDelay:0.5];
    }else{//segueMainpageToProviderDetail
        [self performSegueWithIdentifier:@"segueMainpageToProviderDetail" sender:self];
        [self performSelector:@selector(deleteProviderCell:) withObject:nil afterDelay:0.5];
    }
}

- (void) delete:(id)sender{
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}

- (void) deleteProviderCell:(id)sender{
    [self.providerTableView deselectRowAtIndexPath:[self.providerTableView indexPathForSelectedRow] animated:YES];
}

- (IBAction)refreshMainpageAction:(id)sender {
    [self getDataFromRemoteServer];
}

- (IBAction)menuButtonTapped:(id)sender {
    [self.slidingViewController anchorTopViewToRightAnimated:YES];
}
@end
