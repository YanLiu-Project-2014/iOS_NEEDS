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
#import "BidDetail.h"
#import "MessageDetail.h"

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
 *  登陆操作
 *
 *  @param name       用户名
 *  @param pwd        密码
 *  @param mUserType  用户类型
 *  @param completion 成功操作
 *  @param error      失败操作
 *
 *  @return 操作
 *
 *  @since 1.0
 */
-(MKNetworkOperation*)doLogin:(NSString*)name password:(NSString *)pwd userType:(int)mUserType completionHandler:(ModelBlock)completion errorHandler:(ErrorBlock)error;

/**
 *  搜索功能
 *
 *  @param type               搜索类型
 *  @param _content           搜索内容
 *  @param _completionHandler 成功操作
 *  @param _errorHandler      失败操作
 *
 *  @return 操作
 *
 *  @since 1.0
 */
-(MKNetworkOperation*)searchInMainpage:(NSString*)type content:(NSString*)_content completionHandler:(ArrayBlock)_completionHandler errorHandler:(ErrorBlock) _errorHandler;

/**
 *  获取主页精选内容（需求与服务商）
 *
 *  @param type             x 精选类型（现在已经不用了）
 *  @param _completionHandler 成功操作
 *  @param _errorHandler      失败操作
 *
 *  @return 操作
 *
 *  @since 1.0
 */
-(MKNetworkOperation*)getSelectionInMainpage:(NSString*)type completionHandler:(DictionaryBlock)_completionHandler errorHandler:(ErrorBlock)_errorHandler;

/**
 *  根据类别获取需求列表
 *
 *  @param category           需求类别（0开始，具体参见plist）
 *  @param mOffset            偏移量
 *  @param mCompletionHandler 成功操作
 *  @param mErrorHandler      失败操作
 *
 *  @return 操作
 *
 *  @since 1.0
 */
- (MKNetworkOperation *)fetchNeedsListByCategory:(NSString *)category offSet:(int)mOffset completionHandler:(ArrayBlock)mCompletionHandler errorHandler:(ErrorBlock)mErrorHandler;

/**
 *  根据需求id获取需求详情
 *
 *  @param id                 需求id
 *  @param mCompletionHandler 成功操作
 *  @param mErrorHandler      失败操作
 *
 *  @return 成功操作
 *
 *  @since 1.0
 */
- (MKNetworkOperation *)getNeedDetailById:(NSString *)id completionHandler:(ModelBlock)mCompletionHandler errorHandler:(ErrorBlock)mErrorHandler;

/**
 *  执行竞标操作
 *
 *  @param needId             需要竞标的需求
 *  @param mContent           竞标内容
 *  @param mCompletionHandler 成功操作
 *  @param mErrorhandler      失败操作
 *
 *  @return 操作
 *
 *  @since 1.0
 */
- (MKNetworkOperation *)doBidWithNeed:(NSString *)needId  content:(NSString*)mContent completionHandler:(VoidBlock)mCompletionHandler errorHandler:(ErrorBlock)mErrorhandler;

/**
 *  获取用户的订单列表（可以设置用户类型，以及订单类型）
 *
 *  @param userType           用户类型，（遵照系统设定， 1：需求发布者， 2：服务商）
 *  @param mOrderType         订单类型，（遵照界面显示， 1：xx进行中， 2：开发中， 3：已完成）
 *  @param mCompletionHandler 成功操作
 *  @param mErrorHandler      失败操作
 *
 *  @return 网络操作对象
 *
 *  @since 1.0
 */
- (MKNetworkOperation *)getOrderWithUsertype:(int)userType orderType:(int)mOrderType offset:(int)mOffset completionHandler:(ArrayBlock)mCompletionHandler errorHandler:(ErrorBlock)mErrorHandler;

/**
 *  发布需求接口
 *
 *  @param name               需求名称（简要描述）
 *  @param mCategory          需求类别（数字0开始）
 *  @param mBudget            需求预算（小数点前6位，后2位）
 *  @param mDescription       需求描述
 *  @param mCompletionHandler 成功操作
 *  @param mErrorHandler      失败操作
 *
 *  @return 操作
 *
 *  @since 1.0
 */
- (MKNetworkOperation *)releaseNeedWithName:(NSString*)name category:(int)mCategory budget:(NSString*)mBudget description:(NSString*)mDescription completionHandler:(VoidBlock)mCompletionHandler errorHandler:(ErrorBlock)mErrorHandler;

/**
 *  获取消息列表
 *
 *  @param mCompletionHandler 成功操作
 *  @param mErrorHandler      失败操作
 *
 *  @return 操作
 *
 *  @since 1.0
 */
- (MKNetworkOperation*)getMessageListWithCompletionHandler:(ArrayBlock)mCompletionHandler errorHandler:(ErrorBlock)mErrorHandler;

/**
 *  获取竞标者列表
 *
 *  @param needId             需求id
 *  @param mOffset            偏移量
 *  @param mCompletionHandler 成功操作
 *  @param mErrorHandler      失败操作
 *
 *  @return 操作
 *
 *  @since 1.0
 */
- (MKNetworkOperation*)getBidsListWithNeed:(NSString *)needId offset:(int)mOffset completionHandler:(ArrayBlock)mCompletionHandler errorHandler:(ErrorBlock)mErrorHandler;

/**
 *  获取竞标详情
 *
 *  @param bidId              竞标id
 *  @param mCompletionHandler 成功操作
 *  @param mErrorHandler      失败操作
 *
 *  @return 操作
 *
 *  @since 1.0
 */
- (MKNetworkOperation*)getBidDetailWithId:(NSString *)bidId completionHandler:(ModelBlock)mCompletionHandler errorHandler:(ErrorBlock)mErrorHandler;

/**
 *  获取用户详细信息
 *
 *  @param userType           用户类型 （1：发布商， 2：服务商）
 *  @param mUserId            用户id
 *  @param mCompletionHandler 成功操作
 *  @param mErrorHandler      失败操作
 *
 *  @return 操作
 *
 *  @since 1.0
 */
- (MKNetworkOperation*)getUserDetailInfoWithType:(NSString*)userType userId:(NSString*)mUserId completionHandler:(ModelBlock)mCompletionHandler errorHandler:(ErrorBlock)mErrorHandler;

/**
 *  选定中标服务商
 *
 *  @param providerId         服务商id
 *  @param mRequirementId     需求id
 *  @param mCompletionHandler 成功操作
 *  @param mErrorHandler      失败操作
 *
 *  @return 操作
 *
 *  @since 1.0
 */
- (MKNetworkOperation*)selectBidProviderWithProviderId:(NSString*)providerId requirementId:(NSString*)mRequirementId completionHandler:(VoidBlock)mCompletionHandler errorHandler:(ErrorBlock)mErrorHandler;

/**
 *  获取和某个人的聊天记录
 *
 *  @param user               对方的用户id
 *  @param mOffset            偏移量
 *  @param mCompletionHandler 成功操作
 *  @param mErrorHandler      失败操作
 *
 *  @return 操作
 *
 *  @since 1.0
 */
- (MKNetworkOperation*)getMessageDetailByUser:(NSString*)user offset:(int)mOffset completionHandler:(ArrayBlock)mCompletionHandler errorHandler:(ErrorBlock)mErrorHandler;

/**
 *  发送消息
 *
 *  @param user               接受用户id
 *  @param mContent           内容
 *  @param mCompletionHandler 成功操作
 *  @param mErrorHandler      失败操作
 *
 *  @return 操作
 *
 *  @since 1.0
 */
- (MKNetworkOperation*)sendMessageWithReceiver:(NSString*)user content:(NSString*)mContent completionHandler:(VoidBlock)mCompletionHandler errorHandler:(ErrorBlock)mErrorHandler;

/**
 *  支付到支付宝（托管操作）
 *
 *  @param requirement        需要托管的需求
 *  @param mCompletionHandler 成功操作
 *  @param mErrorHandler      失败操作
 *
 *  @return 操作
 *
 *  @since 1.0
 */
- (MKNetworkOperation*)payToAliPayWithRequirement:(NSString*)requirement completionHandler:(VoidBlock)mCompletionHandler errorHandler:(ErrorBlock)mErrorHandler;

/**
 *  确认动作
 *
 *  @param userType           执行确认的用户类型（1：发布方，2：服务商）
 *  @param mRequirementId     执行确认的需求
 *  @param mCompletionHandler 成功操作
 *  @param mErrorHandler      失败操作
 *
 *  @return 操作
 *
 *  @since 1.0
 */
- (MKNetworkOperation*)confirmActionWithUserType:(int)userType requirementId:(NSString*)mRequirementId completionHandler:(VoidBlock)mCompletionHandler errorHandler:(ErrorBlock)mErrorHandler;

/**
 *  评分功能
 *
 *  @param rID                需要评分的需求id
 *  @param mRate              评分（0：好评，1：中评，2：差评）
 *  @param mCompletionHandler 成功操作
 *  @param mErrorHandler      失败操作
 *
 *  @return 操作
 *
 *  @since 1.0
 */
- (MKNetworkOperation*)rateWithRequirement:(NSString*)rID rateLevel:(int)mRate completionHandler:(VoidBlock)mCompletionHandler errorHandler:(ErrorBlock)mErrorHandler;
@end
