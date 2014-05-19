//
//  NeedDetailThirdCell.h
//  NEEDS
//
//  Created by JackYu on 5/18/14.
//  Copyright (c) 2014 Jackyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NeedDetail.h"

@interface NeedDetailThirdCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextView *descriptionLabel;

- (void)initCell:(NeedDetail*)need;

@end
