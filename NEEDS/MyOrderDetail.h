//
//  MyOrderDetail.h
//  NEEDS
//
//  Created by JackYu on 5/17/14.
//  Copyright (c) 2014 Jackyu. All rights reserved.
//

#import "JSONModel.h"

@interface MyOrderDetail : JSONModel

@property(nonatomic, strong) NSString *pk_id;

@property(nonatomic, strong) NSString *name;

@property(nonatomic, strong) NSString *budget;

@property(nonatomic, strong) NSString *createtime;

@end
