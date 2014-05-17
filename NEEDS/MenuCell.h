//
//  MenuCell.h
//  NEEDS
//
//  Created by JackYu on 5/15/14.
//  Copyright (c) 2014 Jackyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *menuIcon;
@property (weak, nonatomic) IBOutlet UILabel *menuLabel;

- (void)initCellWithImg:(NSString*)imageName title:(NSString*)mTitle;

- (void)setTitle:(NSString *)title;

@end
