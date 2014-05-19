//
//  ProviderView.h
//  NEEDS
//
//  Created by JackYu on 5/16/14.
//  Copyright (c) 2014 Jackyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProviderDetail.h"

@interface ProviderView : UIView

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextView *descriptionInfo;
@property (weak, nonatomic) IBOutlet UITextView *serviceField;
@property (weak, nonatomic) IBOutlet UILabel *rateLabel;

- (void)initWithProvider:(ProviderDetail *)provider;



@end
