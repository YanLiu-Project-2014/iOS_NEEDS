//
//  ProviderView.m
//  NEEDS
//
//  Created by JackYu on 5/16/14.
//  Copyright (c) 2014 Jackyu. All rights reserved.
//

#import "ProviderView.h"

@implementation ProviderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)initWithProvider:(ProviderDetail *)provider{
    self.nameLabel.text = [provider name];
    self.descriptionInfo.text = [provider introduce];
    self.serviceField.text = [provider advantage];
    self.rateLabel.text = [provider rate_count];
    
}

@end
