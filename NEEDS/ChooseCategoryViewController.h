//
//  chooseCategoryViewController.h
//  NEEDS
//
//  Created by JackYu on 5/18/14.
//  Copyright (c) 2014 Jackyu. All rights reserved.
//

@protocol ChooseCategoryDelegate <NSObject>

- (void)choose:(int)category name:(NSString*)mName;

@end

#import <UIKit/UIKit.h>

@interface ChooseCategoryViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property(retain, nonatomic) id<ChooseCategoryDelegate> delegate;

@end
