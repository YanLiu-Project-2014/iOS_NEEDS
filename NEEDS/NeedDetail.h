//
//  NeedDetail.h
//  NEEDS
//
//  Created by JackYu on 5/12/14.
//  Copyright (c) 2014 Jackyu. All rights reserved.
//

#import "JSONModel.h"

@interface NeedDetail : JSONModel

@property(nonatomic, strong) NSString *budget;          //预算
@property(nonatomic, strong) NSString *category;        //需求类别
@property(nonatomic, strong) NSString *deadline;        //截止日期
@property(nonatomic, strong) NSString *description;     //需求描述
@property(nonatomic, strong) NSString *good;            //是否是精品需求 （1：表示是精品需求）
@property(nonatomic, strong) NSString *name;            //需求名称
@property(nonatomic, strong) NSString *pk_id;           //需求id
@property(nonatomic, strong) NSString *createtime;      //发布时间
@property(nonatomic, strong) NSString *state;           //状态
@property(nonatomic, strong) NSString *user_name;       //发布者的名字
@property(nonatomic, strong) NSString *bid_count;       //竞标数

// added by jackyu
@property(nonatomic, strong) NSString *fk_publisher;    //发布者
@property(nonatomic, strong) NSString *fk_provider;     //服务商


- (NSString *) getStateDescription;

@end
