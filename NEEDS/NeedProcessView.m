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
//    [self.test setBackgroundColor:[UIColor redColor]];
    [[self.nodeCollection objectAtIndex:3] setBackgroundColor:[UIColor blueColor]];
}

- (void)setState:(int)state{
    for (int i=0; i<[self.nodeCollection count]; i++) {
        NSLog(@"画图时, i:%d, state:%d",i,state);
        if (i < state) {
            [[self.nodeCollection objectAtIndex:i] setImage:[UIImage imageNamed:@"process_halfNode.png"]];
        }else if (i == state ){
            [[self.nodeCollection objectAtIndex:i] setImage:[UIImage imageNamed:@"process_fullNode.png"]];
        }else{
            [[self.nodeCollection objectAtIndex:i] setImage:[UIImage imageNamed:@"process_emptyNode.png"]];
        }
    }
    
    for (int i=0; i<[self.imgeView count]; i++) {
        if (i==state) {
            [[self.imgeView objectAtIndex:i] setImage:[UIImage imageNamed:[self getImageName:i isHighlighted:YES]]];
        }else{
            [[self.imgeView objectAtIndex:i] setImage:[UIImage imageNamed:[self getImageName:i isHighlighted:NO]]];
        }
    }
}

- (NSString*)getImageName:(int)state isHighlighted:(BOOL)mISHighlighted{
    if (mISHighlighted) { // 高亮
        switch (state) {
            case 0:
                return @"process_icon_1_h.png";
                break;
            case 1:
                return @"process_icon_2_h.png";
                break;
            case 2:
                return @"process_icon_3_h.png";
                break;
            case 3:
                return @"process_icon_4_h.png";
                break;
            case 4:
                return @"process_icon_5_h.png";
                break;
            case 5:
                return @"process_icon_6_h.png";
                break;
            default:
                return @"process_icon_7_h.png";
                break;
        }
    }else{
        switch (state) {
            case 0:
                return @"process_icon_1.png";
                break;
            case 1:
                return @"process_icon_2.png";
                break;
            case 2:
                return @"process_icon_3.png";
                break;
            case 3:
                return @"process_icon_4.png";
                break;
            case 4:
                return @"process_icon_5.png";
                break;
            case 5:
                return @"process_icon_6.png";
                break;
            default:
                return @"process_icon_7.png";
                break;
        }
    }
}

@end
