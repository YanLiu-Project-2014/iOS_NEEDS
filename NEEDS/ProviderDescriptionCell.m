//
//  ProviderDescriptionCell.m
//  NEEDS
//
//  Created by JackYu on 5/16/14.
//  Copyright (c) 2014 Jackyu. All rights reserved.
//

#import "ProviderDescriptionCell.h"

@implementation ProviderDescriptionCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)initCellWithName:(NSString *)name rateText:(NSString *)mRateText advantageText:(NSString *)mAdvantageText{
    self.nameLabel.text = name;
    self.rateLabel.text = [NSString stringWithFormat:@"好评率:%@",mRateText];
    self.advantageLabel.text = mAdvantageText;
}

@end
