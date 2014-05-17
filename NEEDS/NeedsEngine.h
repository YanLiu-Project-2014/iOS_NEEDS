//
//  NeedsEngine.h
//  NEEDS
//
//  Created by JackYu on 5/3/14.
//  Copyright (c) 2014 Jackyu. All rights reserved.
//

#import "MKNetworkEngine.h"
#import "YUNEEDSConfig.h"
#import "JSONModel.h"
#import "User.h"
#import "NeedDetail.h"
#import "ProviderDetail.h"
#import "NeedsListItem.h"

#define kAccessTokenDefaultsKey @"ACCESS_TOKEN"

typedef void (^VoidBlock)(void);
typedef void (^ModelBlock)(JSONModel* aModelBaseObject);
typedef void (^ArrayBlock)(NSMutableArray* listOfModelBaseObjects);
typedef void (^DictionaryBlock)(NSDictionary* dictionaryOfModelBaseObjects);
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
-(MKNetworkOperation*)doLogin:(NSString*)name password:(NSString *)pwd userType:(int)mUserType completionHandler:(ModelBlock)completion errorHandler:(ErrorBlock)error;

/**
 *  Search results in mainpage.
 *
 *  @param tyep               search type
 *  @param _content           search content
 *  @param _completionHandler completion handler
 *  @param _errorHandler      error handler
 *
 *  @return network operation
 *
 *  @since 1.0
 */
-(MKNetworkOperation*)searchInMainpage:(NSString*)type content:(NSString*)_content completionHandler:(ArrayBlock)_completionHandler errorHandler:(ErrorBlock) _errorHandler;

/**
 *  Get selection objects in mainpage. Here selection could be needs selection, service selcetion and
 *  provider selection.
 *
 *  @param type               selection type (0:needs, 1:services, 2:providers)
 *  @param _completionHandler competion handler
 *  @param _errorHandler      error handler
 *
 *  @return network operation
 *
 *  @since 1.0
 */
-(MKNetworkOperation*)getSelectionInMainpage:(NSString*)type completionHandler:(DictionaryBlock)_completionHandler errorHandler:(ErrorBlock)_errorHandler;


- (MKNetworkOperation *)fetchNeedsListByCategory:(NSString *)category offSet:(int)mOffset completionHandler:(ArrayBlock)mCompletionHandler errorHandler:(ErrorBlock)mErrorHandler;

- (MKNetworkOperation *)getNeedDetailById:(NSString *)id completionHandler:(ModelBlock)mCompletionHandler errorHandler:(ErrorBlock)mErrorHandler;

- (MKNetworkOperation *)doBidWithNeed:(NSString *)needId  content:(NSString*)mContent completionHandler:(VoidBlock)mCompletionHandler errorHandler:(ErrorBlock)mErrorhandler;
@end
