//
//  NeedDetailThirdCell.m
//  NEEDS
//
//  Created by JackYu on 5/18/14.
//  Copyright (c) 2014 Jackyu. All rights reserved.
//

#import "NeedDetailThirdCell.h"

@implementation NeedDetailThirdCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)initCell:(NeedDetail *)need{
    self.descriptionLabel.text = [need description];
}

@end
