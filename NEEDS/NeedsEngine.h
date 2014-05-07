//
//  NeedsEngine.h
//  NEEDS
//
//  Created by JackYu on 5/3/14.
//  Copyright (c) 2014 Jackyu. All rights reserved.
//

#import "MKNetworkEngine.h"
#import "JSONModel.h"
#import "User.h"

#define kAccessTokenDefaultsKey @"ACCESS_TOKEN"

typedef void (^VoidBlock)(void);
typedef void (^ModelBlock)(JSONModel* aModelBaseObject);
typedef void (^ArrayBlock)(NSMutableArray* listOfModelBaseObjects);
typedef void (^ErrorBlock)(NSError* engineError);

@interface NeedsEngine : MKNetworkEngine

/**
 *  Initial engine with default settings.
 *
 *  @return Engine itself.
 *
 *  @since 1.0
 */
-(id) initWithDefaultSettings;

/**
 *  Log in method.
 *
 *  @param name         user name
 *  @param pwd          user password
 *  @param completion   completion handler, when task ok, it will be called.
 *  @param error        error handler, when task error, it will be called.
 *
 *  @return the network operation, which user could use to cancel this operation.
 *
 *  @since 1.0
 */
-(MKNetworkOperation*) doLogin:(NSString*)name password:(NSString *)pwd completionHandler:(ModelBlock)completion errorHandler:(ErrorBlock)error;

@end
