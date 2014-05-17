//
//  BidViewController.h
//  NEEDS
//
//  Created by JackYu on 5/17/14.
//  Copyright (c) 2014 Jackyu. All rights reserved.
//

@protocol BidDelegate <NSObject>

- (void)bidSuccessed;

- (void)bidFailed;

- (void)bidCancel;

@end

#import <UIKit/UIKit.h>
#import "NeedDetail.h"
#import "YUNEEDSAppDelegate.h"
#import "UIViewController+ECSlidingViewController.h"

@interface BidViewController : UIViewController<UITextViewDelegate>

// 协议委托者
@property(nonatomic, weak) id<BidDelegate> bidDelegate;

// 数据
@property(nonatomic, strong) NeedDetail *needDetail;
@property(nonatomic, readwrite) BOOL backSign;

// IBOutlet
@property (weak, nonatomic) IBOutlet UILabel *needNameLabel;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;

// IBAction
- (IBAction)backgroundTouchDown:(id)sender;
- (IBAction)submitAction:(id)sender;
- (IBAction)cancelAction:(id)sender;

@end
