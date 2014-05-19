//
//  NeedDetailSecondeCell.m
//  NEEDS
//
//  Created by JackYu on 5/18/14.
//  Copyright (c) 2014 Jackyu. All rights reserved.
//

#import "NeedDetailSecondeCell.h"

@implementation NeedDetailSecondeCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)initCellWithNeed:(NeedDetail *)need{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"NeedProcessView" owner:self options:nil];
    NeedProcessView *processView = [nib objectAtIndex:0];
    [processView setFrame:CGRectMake(8,0,280,105)];
    [processView setState:[self transferStateFromServerToLocal:[[need state] intValue]]];
    [self.processContentView addSubview:processView];
    [self.processContentView setBackgroundColor:[UIColor clearColor]];
    
    self.label.text = [NSString stringWithFormat:@"目前共有 %@ 人参与竞标",[need bid_count]];
}

- (int)transferStateFromServerToLocal:(int)serverState{
    if (serverState >0 && serverState<=5) {
        return serverState;
    }else if (serverState >=6 && serverState <= 8){
        return serverState-1;
    }else{
        return -1;
    }
}

@end
