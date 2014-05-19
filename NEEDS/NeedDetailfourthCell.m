//
//  NeedDetailfourthCell.m
//  NEEDS
//
//  Created by JackYu on 5/18/14.
//  Copyright (c) 2014 Jackyu. All rights reserved.
//

#import "NeedDetailfourthCell.h"

@implementation NeedDetailfourthCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)initCell{
    
}

- (void)drawRect:(CGRect)rect{
    
}

- (void)setFrame:(CGRect)frame{
    frame.origin.x += 20;
    frame.size.width -= 40;
    [super setFrame:frame];
}

@end
