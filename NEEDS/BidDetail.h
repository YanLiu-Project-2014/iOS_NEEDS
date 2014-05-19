//
//  BidDetail.h
//  NEEDS
//
//  Created by JackYu on 5/18/14.
//  Copyright (c) 2014 Jackyu. All rights reserved.
//

#import "JSONModel.h"

@interface BidDetail : JSONModel

@property(nonatomic, strong) NSString *pk_id;
@property(nonatomic, strong) NSString *provider_id;
@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *content;
@property(nonatomic, strong) NSString *time;
@property(nonatomic, strong) NSString *requirement_id; // 需求id

//@property(nonatomic, strong) NSString *user_name;
//@property(nonatomic, strong) NSString *date;

@end
