//
//  MessageDetail.h
//  NEEDS
//
//  Created by JackYu on 5/19/14.
//  Copyright (c) 2014 Jackyu. All rights reserved.
//

#import "JSONModel.h"

@interface MessageDetail : JSONModel

@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *content;
@property(nonatomic, strong) NSString *createtime;

@end
