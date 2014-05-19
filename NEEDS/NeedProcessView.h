//
//  NeedProcessView.h
//  NEEDS
//
//  Created by JackYu on 5/16/14.
//  Copyright (c) 2014 Jackyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NeedProcessView : UIView
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *nodeCollection;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *imgeView;

- (void)testFunction;

- (void)setState:(int)state;

@end
