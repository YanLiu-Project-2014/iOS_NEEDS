//
//  NeedProcessView.m
//  NEEDS
//
//  Created by JackYu on 5/16/14.
//  Copyright (c) 2014 Jackyu. All rights reserved.
//

#import "NeedProcessView.h"

@implementation NeedProcessView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)testFunction{
    [self.test setBackgroundColor:[UIColor redColor]];
    [[self.nodeCollection objectAtIndex:3] setBackgroundColor:[UIColor blueColor]];
}

- (void)setState:(int)state{
    for (int i=0; i<[self.nodeCollection count]; i++) {
        if (i < state) {
            [[self.nodeCollection objectAtIndex:i] setImage:[UIImage imageNamed:@"process_halfNode.png"]];
        }else if (i == state ){
            [[self.nodeCollection objectAtIndex:i] setImage:[UIImage imageNamed:@"process_fullNode.png"]];
        }else{
            [[self.nodeCollection objectAtIndex:i] setImage:[UIImage imageNamed:@"process_emptyNode.png"]];
        }
    }
}

@end
