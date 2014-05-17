//
//  ProviderDetailViewController.m
//  NEEDS
//
//  Created by JackYu on 5/16/14.
//  Copyright (c) 2014 Jackyu. All rights reserved.
//

#import "ProviderDetailViewController.h"

@interface ProviderDetailViewController ()

@property(nonatomic, strong) UIScrollView *scrollView;

@end

@implementation ProviderDetailViewController

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
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height + [UIApplication sharedApplication].statusBarFrame.size.height, self.view.frame.size.width, self.view.frame.size.height-self.navigationController.navigationBar.frame.size.height-[UIApplication sharedApplication].statusBarFrame.size.height)];
    
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ProviderView" owner:self options:nil];
    ProviderView *contentView = [nib objectAtIndex:0];
    
    [self.scrollView setContentSize:CGSizeMake(contentView.frame.size.width, contentView.frame.size.height)];
    [self.scrollView addSubview:contentView];
    [self.view addSubview:self.scrollView];
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

@end
