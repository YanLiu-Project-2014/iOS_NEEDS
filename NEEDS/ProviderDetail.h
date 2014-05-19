//
//  ProviderDetail.h
//  NEEDS
//
//  Created by JackYu on 5/13/14.
//  Copyright (c) 2014 Jackyu. All rights reserved.
//

#import "JSONModel.h"

@interface ProviderDetail : JSONModel

@property(nonatomic, strong) NSString *pk_id;           // id
@property(nonatomic, strong) NSString *name;            // 名字
@property(nonatomic, strong) NSString *email;           // Email
@property(nonatomic, strong) NSString *good;            // 是否是精品
@property(nonatomic, strong) NSString *advantage;       // 服务范围
@property(nonatomic, strong) NSString *rate_count;      // 好评率

// 服务商详情
//@property(nonatomic, strong) NSString *pk_id;
//@property(nonatomic, strong) NSString *name;
//@property(nonatomic, strong) NSString *email;
//@property(nonatomic, strong) NSString *good;
//@property(nonatomic, strong) NSString *advantage;
//@property(nonatomic, strong) NSString *rate_count;
@property(nonatomic, strong) NSString *introduce;       // 介绍
//@property(nonatomic, strong) NSString *latest_order;    // 最近三笔交易
//@property(nonatomic, strong) NSString *current_order;   // 当前交易

@end
