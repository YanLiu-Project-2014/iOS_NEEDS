//
//  MainpageViewController.m
//  NEEDS
//
//  Created by JackYu on 5/7/14.
//  Copyright (c) 2014 Jackyu. All rights reserved.
//

#import "MainpageViewController.h"

@interface MainpageViewController ()

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

- (IBAction)searchField_DidEndOnExit:(id)sender {
    [sender resignFirstResponder];
}
@end
