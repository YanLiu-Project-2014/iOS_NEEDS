//
//  MenuCell.m
//  NEEDS
//
//  Created by JackYu on 5/15/14.
//  Copyright (c) 2014 Jackyu. All rights reserved.
//

#import "MenuCell.h"

@implementation MenuCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)initCellWithImg:(NSString *)imageName title:(NSString *)mTitle{
    [self.menuIcon setImage:[UIImage imageNamed:imageName]];
    self.menuLabel.text = mTitle;
}

- (void)setTitle:(NSString *)title{
    self.menuLabel.text = title;
}

@end
