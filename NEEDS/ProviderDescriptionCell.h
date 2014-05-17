//
//  ProviderDescriptionCell.h
//  NEEDS
//
//  Created by JackYu on 5/16/14.
//  Copyright (c) 2014 Jackyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProviderDescriptionCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *rateLabel;
@property (weak, nonatomic) IBOutlet UILabel *advantageLabel;


- (void)initCellWithName:(NSString*)name rateText:(NSString*)mRateText advantageText:(NSString*)mAdvantageText;

@end
