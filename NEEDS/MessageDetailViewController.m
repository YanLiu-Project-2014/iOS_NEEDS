//
//  MessageDetailViewController.m
//  NEEDS
//
//  Created by JackYu on 5/19/14.
//  Copyright (c) 2014 Jackyu. All rights reserved.
//

#import "MessageDetailViewController.h"

@interface MessageDetailViewController (){
    NSMutableArray *data;
}

@property(strong, nonatomic) UITableView *tableView;

@end

@implementation MessageDetailViewController

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
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, [UIApplication sharedApplication].keyWindow.frame.size.width, [UIApplication sharedApplication].keyWindow.frame.size.height-64-50) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    data = [[NSMutableArray alloc] init];
    self.addMessageTextField.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
 
    // 获取数据
    [self getDataFromServerWithOffset:0];
}

- (void)getDataFromServerWithOffset:(int)mOffset{
    NSLog(@"uid:%@",self.user);
    [AppDelegate.engine getMessageDetailByUser:self.user offset:mOffset completionHandler:^(NSMutableArray *result){
        for (int i=0; i<[result count]; i++) {
            MessageFrame *mf = [[MessageFrame alloc] init];
            Message *msg = [[Message alloc] init];
            msg.content = [((MessageDetail*)[result objectAtIndex:i]) content];
            msg.time = [((MessageDetail*)[result objectAtIndex:i]) createtime];
            msg.icon = @"icon01.png";
            msg.type = MessageTypeMe;
            mf.message = msg;
            [data addObject:mf];
        }
        [self.tableView reloadData];
        NSLog(@"ok...%d,%d", (int)[data count], (int)[result count]);
    }errorHandler:^(NSError *error){
        
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"fasdfafhasdh";
    MessageCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[MessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    // 设置数据
    cell.messageFrame = [data objectAtIndex:indexPath.row];
    return cell;
}

- (IBAction)addMessageAction:(id)sender {
    [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    [AppDelegate.engine sendMessageWithReceiver:self.user content:self.addMessageTextField.text completionHandler:^(){
        [MBProgressHUD hideAllHUDsForView:self.navigationController.view animated:YES];
        [self addMessageToTableView:self.addMessageTextField.text];
    }errorHandler:^(NSError *error){
        [MBProgressHUD hideAllHUDsForView:self.navigationController.view animated:YES];
        [UIAlertView showWithError:error];
    }];
}

- (void)addMessageToTableView:(NSString *)content{
    MessageFrame *mf = [[MessageFrame alloc] init];
    Message *msg = [[Message alloc] init];
    msg.content = content;
    msg.time = @"2015 09 09 12 21";
    msg.icon = @"icon01.png";
    msg.type = MessageTypeMe;
    mf.message = msg;
    [data addObject:mf];
    [self.tableView reloadData];
}


#pragma mark - 键盘处理
#pragma mark 键盘即将显示
- (void)keyBoardWillShow:(NSNotification *)note{
    NSLog(@"tttttst");
    CGRect rect = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat ty = - rect.size.height;
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, ty);
    }];
    
}
#pragma mark 键盘即将退出
- (void)keyBoardWillHide:(NSNotification *)note{
    
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
        self.view.transform = CGAffineTransformIdentity;
    }];
}

@end
