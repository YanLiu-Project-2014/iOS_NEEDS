//
//  MainTabbarView.m
//  NEEDS
//
//  Created by JackYu on 5/7/14.
//  Copyright (c) 2014 Jackyu. All rights reserved.
//

#import "MainTabbarView.h"

@implementation MainTabbarView

enum barsize{
    tabitem_width=64,//80,
    tabitem_hight=44,//44,
    tab_hight=46,//56,//46,
    tab_width=320,
    other_offtop=2,
    
    img_hight=30,//38,
    img_width=23,
    img_x=17,//27,
    img_y=7
};

- (id)initWithFrame:(CGRect)frame
{
    
    CGRect frame1=CGRectMake(frame.origin.x, frame.size.height-tab_hight, tab_width, tab_hight);
    
    self = [super initWithFrame:frame1];
    if (self) {
        
        
        [self setBackgroundColor:[UIColor whiteColor]];
        self.backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.backBtn setFrame:CGRectMake(0, 0, tab_width, tab_hight)];
        [self.backBtn setBackgroundImage:[UIImage imageNamed:@"mainpage_tabbg"] forState:UIControlStateNormal];
        [self.backBtn setBackgroundImage:[UIImage imageNamed:@"mainpage_tabbg"] forState:UIControlStateSelected];
        
//        [self.backBtn setUserInteractionEnabled:NO];
        
        
        
//        self.shadeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//        [self.shadeBtn setFrame:CGRectMake(0, other_offtop, tabitem_width, tabitem_hight)];
//        [self.shadeBtn setBackgroundImage:[UIImage imageNamed:@"mainpage_tabimg_shade"] forState:UIControlStateNormal];
//        [self.shadeBtn setBackgroundImage:[UIImage imageNamed:@"mainpage_tabimg_shade"] forState:UIControlStateSelected];
        
        
        
        
        UIImageView *btnImgView;
        
        //first
        btnImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainpage_tabicon_mainpage"] highlightedImage:[UIImage imageNamed:@"mainpage_tabicon_mainpage_h"]];
        btnImgView.frame = CGRectMake(img_x, img_y, img_width, img_hight);
        self.firstBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.firstBtn setFrame:CGRectMake(0, other_offtop, tabitem_width, tabitem_hight)];
        [self.firstBtn setTag:1];
        [self.firstBtn addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.firstBtn addSubview:btnImgView];
        ((UIImageView*)self.firstBtn.subviews[0]).highlighted = YES;
        
        //second
        btnImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainpage_tabicon_delivery"] highlightedImage:[UIImage imageNamed:@"mainpage_tabicon_delivery_h"]];
        btnImgView.frame = CGRectMake(img_x, img_y, img_width, img_hight);
        self.secondBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.secondBtn setFrame:CGRectMake(tabitem_width, other_offtop, tabitem_width, tabitem_hight)];
        [self.secondBtn setTag:2];
        [self.secondBtn addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.secondBtn addSubview:btnImgView];
        
        //third
        btnImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainpage_tabicon_requirement"] highlightedImage:[UIImage imageNamed:@"mainpage_tabicon_requirement_h"]];
        btnImgView.frame = CGRectMake(img_x, img_y, img_width, img_hight);
        self.thirdBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.thirdBtn setFrame:CGRectMake(tabitem_width*2, other_offtop, tabitem_width, tabitem_hight)];
        [self.thirdBtn setTag:3];
        [self.thirdBtn addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.thirdBtn addSubview:btnImgView];
        
        //fourth
        btnImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainpage_tabicon_myorder"] highlightedImage:[UIImage imageNamed:@"mainpage_tabicon_myorder_h"]];
        btnImgView.frame = CGRectMake(img_x, img_y, img_width, img_hight);
        self.fourthBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.fourthBtn setFrame:CGRectMake(tabitem_width*3, other_offtop, tabitem_width, tabitem_hight)];
        [self.fourthBtn setTag:4];
        [self.fourthBtn addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.fourthBtn addSubview:btnImgView];
        
        //fifth
        btnImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainpage_tabicon_usercenter"] highlightedImage:[UIImage imageNamed:@"mainpage_tabicon_usercenter_h"]];
        btnImgView.frame = CGRectMake(img_x, img_y, img_width, img_hight);
        self.fifthBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.fifthBtn setFrame:CGRectMake(tabitem_width*4, other_offtop, tabitem_width, tabitem_hight)];
        [self.fifthBtn setTag:5];
        [self.fifthBtn addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.fifthBtn addSubview:btnImgView];
        
        
//        [self.backBtn addSubview:self.shadeBtn];
        
        [self.backBtn addSubview:self.firstBtn];
        [self.backBtn addSubview:self.secondBtn];
        [self.backBtn addSubview:self.thirdBtn];
        [self.backBtn addSubview:self.fourthBtn];
        [self.backBtn addSubview:self.fifthBtn];
        
        
        
        [self addSubview:self.backBtn];
    }
    return self;
}


-(void)callButtonAction:(UIButton *)sender{
    int value=sender.tag;
    if (value==1) {
        [self.delegate firstBtnClick];
    }
    if (value==2) {
        [self.delegate secondBtnClick];
    }
    if (value==3) {
        [self.delegate thirdBtnClick];
    }
    if (value==4) {
        [self.delegate fourthBtnClick];
    }
    if (value==5) {
        [self.delegate fifthBtnClick];
    }
    
}

int g_selectedTag=1;
-(void)buttonClickAction:(id)sender{
    UIButton *btn=(UIButton *)sender;
    // UIImageView *view=btn1.subviews[0];
    if(g_selectedTag==btn.tag)
        return;
    else
        g_selectedTag=btn.tag;
    
    
    if (self.firstBtn.tag!=btn.tag) {
        ((UIImageView *)self.firstBtn.subviews[0]).highlighted=NO;
    }
    
    if (self.secondBtn.tag!=btn.tag) {
        ((UIImageView *)self.secondBtn.subviews[0]).highlighted=NO;
    }
    
    if (self.thirdBtn.tag!=btn.tag) {
        
        ((UIImageView *)self.thirdBtn.subviews[0]).highlighted=NO;
    }
    
    if (self.fourthBtn.tag!=btn.tag) {
        
        ((UIImageView *)self.fourthBtn.subviews[0]).highlighted=NO;
    }
    
    if (self.fifthBtn.tag!=btn.tag) {
        
        ((UIImageView *)self.fifthBtn.subviews[0]).highlighted=NO;
    }
    
    
    [self moveShadeBtn:btn];
    [self imgAnimate:btn];
    
    ((UIImageView *)btn.subviews[0]).highlighted=YES;
    
    [self callButtonAction:btn];
    
    return;
    
    
    
    
}


- (void)moveShadeBtn:(UIButton*)btn{
    
    [UIView animateWithDuration:0.3 animations:
     ^(void){
         
         CGRect frame = self.shadeBtn.frame;
         frame.origin.x = btn.frame.origin.x;
         self.shadeBtn.frame = frame;
         
         
     } completion:^(BOOL finished){//do other thing
     }];
    
    
}

- (void)imgAnimate:(UIButton*)btn{
    
    UIView *view=btn.subviews[0];
    
    [UIView animateWithDuration:0.1 animations:
     ^(void){
         
         view.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.5, 0.5);
         
         
     } completion:^(BOOL finished){//do other thing
         [UIView animateWithDuration:0.2 animations:
          ^(void){
              
              view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.2, 1.2);
              
          } completion:^(BOOL finished){//do other thing
              [UIView animateWithDuration:0.1 animations:
               ^(void){
                   
                   view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1,1);
                   
                   
               } completion:^(BOOL finished){//do other thing
               }];
          }];
     }];
    
    
}

@end
