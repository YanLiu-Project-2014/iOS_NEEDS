//
//  NeedsListTableViewController.m
//  NEEDS
//
//  Created by JackYu on 5/12/14.
//  Copyright (c) 2014 Jackyu. All rights reserved.
//

#import "NeedsListTableViewController.h"
#import "UIAlertView+MKNetworkKitAdditions.h"

@interface NeedsListTableViewController (){
    NSArray *data;
}

@end

@implementation NeedsListTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"YUNEEDSConst" ofType:@"plist"];
    NSDictionary *configDictionary = [[NSDictionary alloc] initWithContentsOfFile:path];
    NSString *naviTitle = [[[NSArray alloc] initWithArray:[configDictionary objectForKey:@"NEEDTypes"]] objectAtIndex:self.needsCategory];
    self.navigationItem.title = naviTitle;
    
    [self getDataFromServer];
}

- (void) getDataFromServer{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.labelText = @"正在加载需求列表，请稍微...";
    // 获取数据
    [AppDelegate.engine fetchNeedsListByCategory:[NSString stringWithFormat:@"%d", self.needsCategory] offSet:0 completionHandler:^(NSMutableArray *results){
        [MBProgressHUD hideAllHUDsForView:self.navigationController.view animated:YES];
        data = [results mutableCopy];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"needsListTableViewControllerIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        UIView *seperateView = [[UIView alloc] initWithFrame:CGRectMake(0, cell.frame.size.height-1, cell.frame.size.width, 1)];
        [seperateView setBackgroundColor:[UIColor lightGrayColor]];
        [cell addSubview:seperateView];
    }
    
    cell.textLabel.text = [[data objectAtIndex:indexPath.row] name];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"￥%@ %@", [[data objectAtIndex:indexPath.row] budget], [[data objectAtIndex:indexPath.row] description]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"SegueNeedslistToNeeddetail" sender:self];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"SegueNeedslistToNeeddetail"]) {
        [((NeedDetailViewController *)segue.destinationViewController) setNeedID:[((NeedDetail *)[data objectAtIndex:[self.tableView indexPathForSelectedRow].row]) pk_id]];
    }
}

- (IBAction)backToMainPageAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
