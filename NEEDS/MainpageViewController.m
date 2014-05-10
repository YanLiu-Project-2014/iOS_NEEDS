//
//  MainpageViewController.m
//  NEEDS
//
//  Created by JackYu on 5/7/14.
//  Copyright (c) 2014 Jackyu. All rights reserved.
//

#import "MainpageViewController.h"

@interface MainpageViewController (){
    BOOL chooseSearchTypeIsShow;
}
@property (weak, nonatomic) IBOutlet UIButton *searchTypeBtn;
@property (weak, nonatomic) IBOutlet UIView *chooseSearchTypeView;
@property (weak, nonatomic) IBOutlet UIView *shadeView;
- (IBAction)chooseSearchTypeAction:(id)sender;
- (IBAction)clickChooseTypeAction:(id)sender;

- (IBAction)firstAction:(id)sender;
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
    if ([UIApplication sharedApplication].keyWindow.frame.size.height == 480) { // screen 3.5 inch or not?
        [self drawContent_3_5];
    }else{
        [self drawContent_4];
    }
    
}

/**
 *  3.5 inch windows. Main character: height(480-46-60 = 374), width(320), x(0), y(60)
 *
 *  @since 1.0
 */
- (void)drawContent_3_5{
    // draw two seprator lines. (374/3 = 124)
    UIView *firstLine = [[UIView alloc] initWithFrame:CGRectMake(0, 124+60, 320, 1)];
    [firstLine.layer setBackgroundColor:[[UIColor grayColor] CGColor]];
}

/**
 *  4 inch windows. Main character: height(568-46-60), width(320), x(0), y(60)
 *
 *  @since 1.0
 */
- (void)drawContent_4{
    
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

- (IBAction)searchField_EditingDidBegin:(id)sender {
    self.shadeView.hidden = NO;
}

- (IBAction)searchField_DidEndOnExit:(id)sender {
    self.shadeView.hidden = YES;
    [sender resignFirstResponder];
}

- (IBAction)shadeView_TouchDown:(id)sender {
    [self searchField_DidEndOnExit:self.search_TextField];
}
- (IBAction)chooseSearchTypeAction:(id)sender {
    if (chooseSearchTypeIsShow) {
        self.chooseSearchTypeView.hidden = YES;
        chooseSearchTypeIsShow = NO;
    }else{
        self.chooseSearchTypeView.hidden = NO;
        chooseSearchTypeIsShow = YES;
    }
}
- (IBAction)testActrion:(id)sender {
    self.searchTypeBtn.titleLabel.text = @"服务商";
}

- (IBAction)clickChooseTypeAction:(id)sender {
    switch (((UIButton*)sender).tag) {
        case 1: // click 需求
            NSLog(@"需求");
            //            self.searchTypeBtn.titleLabel.text = @"需求";
            [self.searchTypeBtn setTitle:@"需求" forState:UIControlStateNormal];
            break;
        case 2:
            NSLog(@"服务");
//            self.searchTypeBtn.titleLabel.text = @"";
            [self.searchTypeBtn setTitle:@"服务" forState:UIControlStateNormal];
            break;
        case 3:
            NSLog(@"服务商");
//            self.searchTypeBtn.titleLabel.text = @"";
            [self.searchTypeBtn setTitle:@"服务商" forState:UIControlStateNormal];
            break;
        default:
//            self.searchTypeBtn.titleLabel.text = @"服务商";
            NSLog(@"默认");
            break;
    }
    self.chooseSearchTypeView.hidden = YES;
    chooseSearchTypeIsShow = NO;
    NSLog(@"tag%d",[(UIButton*)sender tag]);
    
}

- (IBAction)firstAction:(id)sender {
    NSLog(@"click first...");
}
@end
