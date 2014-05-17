//
//  NeedDetail.m
//  NEEDS
//
//  Created by JackYu on 5/12/14.
//  Copyright (c) 2014 Jackyu. All rights reserved.
//

#import "NeedDetail.h"

@implementation NeedDetail

- (NSString *) getStateDescription{
    switch ([self.state intValue]) {
        case 0:
            return @"";
            break;
        case 1:
            return @"竞标中";
            break;
        default:
            return @"";
            break;
    }
}

@end
