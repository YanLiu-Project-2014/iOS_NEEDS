//
//  NeedDetailSecondeCell.h
//  NEEDS
//
//  Created by JackYu on 5/18/14.
//  Copyright (c) 2014 Jackyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NeedProcessView.h"
#import "NeedDetail.h"

@interface NeedDetailSecondeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *processContentView;
@property (weak, nonatomic) IBOutlet UILabel *label;

- (void)initCellWithNeed:(NeedDetail*)need;

@end
