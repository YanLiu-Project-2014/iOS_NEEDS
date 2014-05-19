//
//  NeedDetailFirstCell.m
//  NEEDS
//
//  Created by JackYu on 5/18/14.
//  Copyright (c) 2014 Jackyu. All rights reserved.
//

#import "NeedDetailFirstCell.h"

@implementation NeedDetailFirstCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)initCellWithNeed:(NeedDetail*)need{
    self.nameLabel.text = [need name];
    if ([[need good] isEqualToString:@"1"]) {
        self.imageView.hidden = NO;
    }else{
        self.imageView.hidden =YES;
    }
    self.stateLabel.text = [NSString stringWithFormat:@"状态：%@", [need state]];
    self.budgetLabel.text = [NSString stringWithFormat:@"预算：%@",[need budget]];
    self.createdateLabel.text = [NSString stringWithFormat:@"创建日期：%@",[need createtime]];
    self.deadlineLabel.text = [NSString stringWithFormat:@"截止日期：%@",[need deadline]];
    self.creatorLabel.text = [NSString stringWithFormat:@"创建者：%@",[need user_name]];
    self.categoryLabel.text = [NSString stringWithFormat:@"类别：%@", [need category]];
}

@end
