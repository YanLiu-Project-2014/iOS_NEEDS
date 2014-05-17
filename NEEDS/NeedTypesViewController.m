//
//  NeedTypesViewController.m
//  NEEDS
//
//  Created by JackYu on 5/13/14.
//  Copyright (c) 2014 Jackyu. All rights reserved.
//

#import "NeedTypesViewController.h"

@interface NeedTypesViewController (){
    NSArray *data;
}

@end

@implementation NeedTypesViewController

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
    data = [NSArray arrayWithObjects:@"桌面Windows应用", @"桌面Mac应用", @"桌面Linux应用", @"桌面Web应用", @"移动Android应用", @"移动iOS应用", @"移动Web应用", @"嵌入式软件开发", nil];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"YUNEEDSConst" ofType:@"plist"];
    NSDictionary *configDictionary = [[NSDictionary alloc] initWithContentsOfFile:path];
    data = [[NSArray alloc] initWithArray:[configDictionary objectForKey:@"NEEDTypes"]];
    NSLog(@"data:%@",data);
    
    // 控制导航条显示
    if (self.parentType == 0) { // 上一级页面为主页
        
    }else{// 上一级页面为菜单
        UIButton *menuButton = [[UIButton alloc] initWithFrame:CGRectMake(41, 32, 25, 20)];
        [menuButton setImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
        [menuButton addTarget:self action:@selector(backToMenuAction) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backToMenuBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
//        UIBarButtonItem *backToMenuBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(backToMenuAction)];
        self.navigationItem.leftBarButtonItem = backToMenuBarButtonItem;
    }
}

- (void)backToMenuAction{
    [self.slidingViewController anchorTopViewToRightAnimated:YES];
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
    static NSString *identifier = @"needtypeslisttableviewidentifier";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        // 添加分割线
        UIView *seperateView = [[UIView alloc] initWithFrame:CGRectMake(0, cell.frame.size.height-1, cell.frame.size.width, 1)];
        [seperateView setBackgroundColor:[UIColor lightGrayColor]];
        [cell addSubview:seperateView];
    }
    cell.textLabel.text = [data objectAtIndex:indexPath.row];
    
    return cell;
}

- (void) delete:(id)sender{
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIBarButtonItem *returnButtonItem = [[UIBarButtonItem alloc] init];
    returnButtonItem.title = @"重选类型";
    self.navigationItem.backBarButtonItem = returnButtonItem;
    
    [self performSegueWithIdentifier:@"segueNeedtypeToNeedsList" sender:self];
    [self performSelector:@selector(delete:) withObject:nil afterDelay:0.1f];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"segueNeedtypeToNeedsList"]) {
        [segue.destinationViewController setNeedsCategory:[self.tableView indexPathForSelectedRow].row];
    }
}

@end
