//
//  NeedsListItem.m
//  NEEDS
//
//  Created by JackYu on 5/13/14.
//  Copyright (c) 2014 Jackyu. All rights reserved.
//

#import "NeedsListItem.h"

@implementation NeedsListItem

- (NSString *) getDescription{
    return [NSString stringWithFormat:@"￥ %@ %@", self.budget, self.name];
}
@end
