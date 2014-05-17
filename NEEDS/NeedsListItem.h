//
//  NeedsListItem.h
//  NEEDS
//
//  Created by JackYu on 5/13/14.
//  Copyright (c) 2014 Jackyu. All rights reserved.
//

#import "JSONModel.h"

@interface NeedsListItem : JSONModel

@property(nonatomic, strong) NSString *id;
@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *budget;

- (NSString *) getDescription;

@end
