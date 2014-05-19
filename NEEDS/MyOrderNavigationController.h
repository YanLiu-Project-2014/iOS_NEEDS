//
//  MyOrderNavigationController.h
//  NEEDS
//
//  Created by JackYu on 5/17/14.
//  Copyright (c) 2014 Jackyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyOrderNavigationController : UINavigationController

@property (nonatomic, readwrite) int userType; // 要显示“我的订单”的用户类型 需要再跳转前设置好， 默认需求发布者.(1:需求发布者， 2：服务商)

@end
