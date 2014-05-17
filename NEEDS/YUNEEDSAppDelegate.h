//
//  YUNEEDSAppDelegate.h
//  NEEDS
//
//  Created by JackYu on 5/2/14.
//  Copyright (c) 2014 Jackyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NeedsEngine.h"
#import "YUNEEDSConfig.h"

#define AppDelegate ((YUNEEDSAppDelegate *)[UIApplication sharedApplication].delegate)

@interface YUNEEDSAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

/**
 *  This is the network engine of our whole system.
 *
 *  @since              1.0
 */
@property (strong, nonatomic) NeedsEngine *engine;

@end