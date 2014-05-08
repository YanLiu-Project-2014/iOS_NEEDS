//
//  MainTabbarView.h
//  NEEDS
//
//  Created by JackYu on 5/7/14.
//  Copyright (c) 2014 Jackyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MainTabbarViewDelegate <NSObject>

@required
-(void)firstBtnClick;
-(void)secondBtnClick;
-(void)thirdBtnClick;
-(void)fourthBtnClick;
-(void)fifthBtnClick;

@end

@interface MainTabbarView : UIView

@property(nonatomic,strong)id <MainTabbarViewDelegate> delegate;
@property(nonatomic,strong) UIButton *firstBtn;
@property(nonatomic,strong) UIButton *secondBtn;
@property(nonatomic,strong) UIButton *thirdBtn;
@property(nonatomic,strong) UIButton *fourthBtn;
@property(nonatomic,strong) UIButton *fifthBtn;

@property(nonatomic,strong) UIButton *backBtn;
@property(nonatomic,strong) UIButton *shadeBtn;

-(void)buttonClickAction:(id)sender;
@end
