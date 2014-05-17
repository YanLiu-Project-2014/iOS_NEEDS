//
//  ProviderDetail.h
//  NEEDS
//
//  Created by JackYu on 5/13/14.
//  Copyright (c) 2014 Jackyu. All rights reserved.
//

#import "JSONModel.h"

@interface ProviderDetail : JSONModel

@property(nonatomic, strong) NSString *pk_id;
@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *email;
@property(nonatomic, strong) NSString *good;
@property(nonatomic, strong) NSString *advantage;
@property(nonatomic, strong) NSString *rate_count;

@end
