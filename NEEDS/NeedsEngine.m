//
//  NeedsEngine.m
//  NEEDS
//
//  Created by JackYu on 5/3/14.
//  Copyright (c) 2014 Jackyu. All rights reserved.
//

#import "NeedsEngine.h"

// web interface
#define SERVER_BASE @"fishcat.wicp.net"

#define LOGIN_URL @"data_controller/usercontroller/login_control"

#define MP_SEARCH_URL @"" // 主页-搜索

#define MP_NEEDSELECTION_URL @"data_controller/iosController/get_main_page_content" // 主页-精选数据（需求和服务商）

#define MP_FETCH_NEEDS_BY_CATEGORY @"data_controller/requirementcontroller/get_requirement_by_category"// 按类别获取需求列表

#define NSD_FETCH_NEEDS_DETAIL_BY_ID @"data_controller/iosController/get_requirement_ditail"// 根据id获取需求详情

#define MP_NEED_BID @"data_controller/iosController/make_bid"

#define FETCH_USER_ORDER @"data_controller/iosController/get_user_order"

#define RELEASE_NEED @"data_controller/iosController/publish_requirement"

#define GET_MESSAGES_LIST @"data_controller/iosController/get_message_list"

#define GET_BIDS_LIST @"data_controller/iosController/get_requirement_bid"

#define GET_BID_DETAIL @"data_controller/iosController/get_requirement_bid_ditail"

#define GET_USER_DETAIL @"data_controller/iosController/get_user_info"

// 选择中标服务商
#define SELECT_BID_PROVIDER @"data_controller/iosController/select_provider"

#define GET_MESSAGE_DETAIL_BY_USER @"data_controller/iosController/get_user_message"

#define SEND_MESSAGE @"data_controller/iosController/send_message"

#define PAY_TO_ALIPAY @"data_controller/iosController/pay"

#define CONFIRM_PUBLISHER_USER @"data_controller/iosController/confirm_deliver"

#define CONFIRM_PROVIDER_USE @"data_controller/iosController/confirm_payment"

#define RATE_API @"data_controller/iosController/rate"

#define FETCH_ITEMS_NUMBER_PER_TIME 15 // 每次请求15条数据

// const response type string
#define CODE @"code"
#define MESSAGE @"message"
#define RESULT @"result"
@interface NeedsEngine(NEEDS_Engine_Private)

// 私有函数（辅助函数）
/**
 *  讲字符串格式化为nserror
 *
 *  @param errorString 错误描述字符串
 *
 *  @return 错误对应nserror
 *
 *  @since 1.0
 */
- (NSError *) formatNSErrorFromString:(NSString *)errorString;

/**
 *  格式化变量列表（添加sid）
 *
 *  @param params 原有参数列表
 *
 *  @return 新的参数列表·
 *
 *  @since 1.0
 */
- (NSDictionary*)formatParameters:(NSDictionary *)params;

/**
 *  执行网络任务（不用返回对象）
 *
 *  @param path               接口（不含sid）
 *  @param mParams            参数列表
 *  @param mCompletionHandler 成功操作
 *  @param mErrorHandler      失败操作
 *
 *  @return 操作
 *
 *  @since 1.0
 */
- (MKNetworkOperation*)fetchVoidFromNet:(NSString*)path params:(NSMutableDictionary*)mParams completionHandler:(VoidBlock)mCompletionHandler errorHandler:(ErrorBlock)mErrorHandler;

/**
 *  执行网络操作（返回一个对象模型）
 *
 *  @param path               接口
 *  @param mParams            参数列表（不含sid）
 *  @param mItemName          对象模型的名称
 *  @param mEmptyMessage      结果为空时返回消息
 *  @param mCompletionHandler 成功操作
 *  @param mErrorHandler      失败操作
 *
 *  @return 操作
 *
 *  @since 1.0
 */
- (MKNetworkOperation *)fetchItemFromNet:(NSString *)path params:(NSDictionary *)mParams itemName:(NSString *)mItemName emptyMessage:(NSString *)mEmptyMessage completinoHandler:(ModelBlock)mCompletionHandler errorHandler:(ErrorBlock)mErrorHandler;

/**
 *  执行网络操作（返回一组对象实例）
 *
 *  @param path               接口
 *  @param mParams            参数列表（不含sid）
 *  @param mItemName          实例对象的类名
 *  @param mEmptyMessage      结果为空时返回消息
 *  @param mCompletionHandler 成功操作
 *  @param mErrorHandler      失败操作
 *
 *  @return 操作
 *
 *  @since 1.0
 */
- (MKNetworkOperation *) fetchItemsFromNet:(NSString *)path parms:(NSDictionary *)mParams itemName:(NSString *)mItemName emptyMessage:(NSString *)mEmptyMessage completionHandler:(ArrayBlock)mCompletionHandler errorHandler:(ErrorBlock)mErrorHandler;



@end


@implementation NeedsEngine

-(id) initWithDefaultSettings {
    
    if(self = [super initWithHostName:SERVER_BASE customHeaderFields:@{@"x-client-identifier" : @"iOS"}]) {
        
    }
    
    return self;
}

///////////////////////////////////************辅助操作·开始************///////////////////////////////////
// 格式化错误提示
- (NSError *) formatNSErrorFromString:(NSString *)errorString{
    NSError *resultError;
    NSDictionary *details = [NSMutableDictionary dictionary];
    [details setValue:errorString forKey:NSLocalizedDescriptionKey];
    resultError = [NSError errorWithDomain:@"word" code:111 userInfo:details];
    return resultError;
}

// 格式化字符串（自动添加sid）
- (NSDictionary*)formatParameters:(NSDictionary *)params{
    NSMutableDictionary *mParams = [params mutableCopy];
    [mParams setObject:[[YUNEEDSConfig getSharedConfig] getSid] forKey:@"sid"];
    return mParams;
}

// 获取单个实例的网络任务
- (MKNetworkOperation *)fetchItemFromNet:(NSString *)path params:(NSMutableDictionary *)mParams itemName:(NSString *)mItemName emptyMessage:(NSString *)mEmptyMessage completinoHandler:(ModelBlock)mCompletionHandler errorHandler:(ErrorBlock)mErrorHandler{
    MKNetworkOperation *op = [self operationWithPath:path params:[self formatParameters:mParams] httpMethod:@"POST"];
    [op addCompletionHandler:^(MKNetworkOperation *successOperation){
        NSMutableDictionary *responseDictionary = [successOperation responseJSON];
        NSLog(@"获取单条数据:%@",[successOperation responseString]);
        // parse json not ok?
        if (responseDictionary == NULL) {
            mErrorHandler([self formatNSErrorFromString:mEmptyMessage]);
        }else{
            NSString *code = [responseDictionary objectForKey:CODE];
            if ([code isEqualToString:@"11111"]) {
                NSMutableDictionary *userJson = [responseDictionary objectForKey:RESULT];
                Class ObjectClass = NSClassFromString(mItemName);
                id object = [[ObjectClass alloc] initWithDictionary:userJson];
//                NSLog(@"收到string数据:%@",[successOperation responseString]);
//                NSLog(@"收到json  数据:%@",userJson);
//                NSLog(@"收到class 数据:%@;;;%@",mItemName,ObjectClass);
                mCompletionHandler(object);
            }else{
                NSString *msg = [responseDictionary objectForKey:MESSAGE];
                mErrorHandler([self formatNSErrorFromString:msg]);
            }
        }
    }errorHandler:^(MKNetworkOperation *errorOperation, NSError *error){
        mErrorHandler(error); // hide the progress bar.
    }];
    
    // add the operation to queue to excute it.
    [self enqueueOperation:op];
    return op;

}

// 获取一组实例的网络任务
- (MKNetworkOperation *) fetchItemsFromNet:(NSString *)path parms:(NSMutableDictionary *)mParams itemName:(NSString *)mItemName emptyMessage:(NSString *)mEmptyMessage completionHandler:(ArrayBlock)mCompletionHandler errorHandler:(ErrorBlock)mErrorHandler{
    MKNetworkOperation *operation;
    operation = [self operationWithPath:path params:[self formatParameters:mParams] httpMethod:@"POST"];
    [operation addCompletionHandler:^(MKNetworkOperation *successOperation){
        NSMutableDictionary *responseDictionary = [successOperation responseJSON];
        NSLog(@"获取多条记录结果:%@",[successOperation responseString]);
        if ([responseDictionary isMemberOfClass:[NSArray class]]) {
            mErrorHandler([self formatNSErrorFromString:mEmptyMessage]);
        }else{
            NSString *code = [responseDictionary objectForKey:@"code"];
            if ([code isEqualToString:@"11111"] ) {
                NSMutableArray *responseArray = [responseDictionary objectForKey:@"result"];
                NSMutableArray *resultsList = [NSMutableArray array];
                [responseArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    [resultsList addObject:[[NSClassFromString(mItemName) alloc] initWithDictionary:obj]];
                }];
                mCompletionHandler(resultsList);
            }else{
                // 没有更多结果
                mErrorHandler([self formatNSErrorFromString:[responseDictionary objectForKey:@"message"]]);
            }
            
        }
    }errorHandler:^(MKNetworkOperation *failedOperation, NSError *error){
        NSLog(@"error%@",error);
        mErrorHandler(error);
    }];
    
    [self enqueueOperation:operation];
    return operation;
}

// 不获取实例的网络任务
- (MKNetworkOperation*)fetchVoidFromNet:(NSString*)path params:(NSMutableDictionary*)mParams completionHandler:(VoidBlock)mCompletionHandler errorHandler:(ErrorBlock)mErrorHandler{
    
    MKNetworkOperation *operation = [self operationWithPath:path params:[self formatParameters:mParams] httpMethod:@"POST"];
    [operation addCompletionHandler:^(MKNetworkOperation *successOperation){
        NSLog(@"获取空数据，结果：%@",[successOperation responseString]);
        NSMutableDictionary *responseDictionary = [successOperation responseJSON];
        // parse json not ok?
        if (responseDictionary == NULL) {
            mErrorHandler([self formatNSErrorFromString:@"没有收到"]);
        }else{
            NSString *code = [responseDictionary objectForKey:CODE];
            // ok?
            if ([code isEqualToString:@"11111"]) {
                mCompletionHandler();
            }else{
                NSString *msg = [responseDictionary objectForKey:MESSAGE];
                mErrorHandler([self formatNSErrorFromString:msg]);
            }
        }
        
    }errorHandler:^(MKNetworkOperation *failedOperation, NSError *error){
        
    }];
    [self enqueueOperation:operation];
    return operation;
}


///////////////////////////////////************开放接口·开始************///////////////////////////////////
// 登陆
-(MKNetworkOperation*) doLogin:(NSString*)name password:(NSString *)pwd userType:(int)mUserType completionHandler:(ModelBlock)completionHandler errorHandler:(ErrorBlock)errorHandler{
    // prepare parameters.
    NSDictionary *params;
    if (mUserType == 1) {
        params = @{@"user_name":name,@"pwd":pwd, @"user_type":@"publisher", @"end_type":@"ios"};
    }else{
        params = @{@"user_name":name,@"pwd":pwd, @"user_type":@"provider", @"end_type":@"ios"};
    }
    return [self fetchItemFromNet:LOGIN_URL params:params itemName:@"User" emptyMessage:@"登陆结果出错" completinoHandler:completionHandler errorHandler:errorHandler];
}

// 搜索
-(MKNetworkOperation*)searchInMainpage:(NSString *)mType content:(NSString *)mCcontent completionHandler:(ArrayBlock)mCcompletionHandler errorHandler:(ErrorBlock)mErrorHandler{
    NSDictionary *params = @{@"type":mType,@"content":mCcontent};
    
    // prepare operation
    MKNetworkOperation *operatoin = [self operationWithPath:MP_SEARCH_URL params:params httpMethod:@"POST"];
    [operatoin addCompletionHandler:^(MKNetworkOperation *completedOperation){
        
    }errorHandler:^(MKNetworkOperation *completedOperation, NSError *error){
        
    }];
    
    [self enqueueOperation:operatoin];
    return operatoin;
}

// 获取精选内容
-(MKNetworkOperation*)getSelectionInMainpage:(NSString *)mType completionHandler:(DictionaryBlock)mCompletionHandler errorHandler:(ErrorBlock)mErrorHandler{
    NSDictionary *params = @{@"end_type":@"ios"};
    
    MKNetworkOperation *operation;
        operation = [self operationWithPath:MP_NEEDSELECTION_URL params:params httpMethod:@"POST"];
    [operation addCompletionHandler:^(MKNetworkOperation *successOperation){
        NSMutableDictionary *responseDictionary = [successOperation responseJSON];
        NSLog(@"精选项目：%@",[successOperation responseString]);
        if (responseDictionary == NULL) {
            NSError *emptyResultError;
            NSDictionary *details = [NSMutableDictionary dictionary];
                [details setValue:@"没有收到精选信息" forKey:NSLocalizedDescriptionKey];
            emptyResultError = [NSError errorWithDomain:@"word" code:111 userInfo:details];
            mErrorHandler(emptyResultError);
        }else{
            NSMutableDictionary *responseArray = [responseDictionary objectForKey:@"result"];
            NSMutableArray *needsList = [NSMutableArray array];
            NSMutableArray *providersList = [NSMutableArray array];
            
            // 需求
            NSArray *responseNeeds = [responseArray objectForKey:@"requirement"];
            NSArray *responseProviders = [responseArray objectForKey:@"provider"];
            
            // 遍历需求数组
            [responseNeeds enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                [needsList addObject:[[NeedDetail alloc] initWithDictionary:obj]];
            }];
            
            // 遍历服务商数组
            [responseProviders enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                [providersList addObject:[[ProviderDetail alloc] initWithDictionary:obj]];
            }];
            
            NSDictionary *resultDictionary = @{@"NeedDetail":needsList, @"ProviderDetail":providersList};
            
            mCompletionHandler(resultDictionary);
        }
    }errorHandler:^(MKNetworkOperation *failedOperation, NSError *error){
        NSLog(@"error%@",error);
        mErrorHandler(error);
    }];
    [self enqueueOperation:operation forceReload:YES];
    return operation;
}

// 按类别获取需求列表
- (MKNetworkOperation *)fetchNeedsListByCategory:(NSString *)category offSet:(int)mOffset completionHandler:(ArrayBlock)mCompletionHandler errorHandler:(ErrorBlock)mErrorHandler{
    NSDictionary *params = @{@"end_type":@"ios", @"category":category, @"num":[NSString stringWithFormat:@"%d", FETCH_ITEMS_NUMBER_PER_TIME], @"offset":[NSString stringWithFormat:@"%d", mOffset]};
    return [self fetchItemsFromNet:MP_FETCH_NEEDS_BY_CATEGORY parms:params itemName:@"NeedDetail" emptyMessage:@"没有需求列表" completionHandler:mCompletionHandler errorHandler:mErrorHandler];
}

// 按id获取需求详情
- (MKNetworkOperation *)getNeedDetailById:(NSString *)mId completionHandler:(ModelBlock)mCompletionHandler errorHandler:(ErrorBlock)mErrorHandler{
    NSDictionary *mParams = @{@"requirement_id":mId};
    
    return [self fetchItemFromNet:NSD_FETCH_NEEDS_DETAIL_BY_ID params:mParams itemName:@"NeedDetail" emptyMessage:@"获取结果出错" completinoHandler:mCompletionHandler errorHandler:mErrorHandler];
}

// 竞标
- (MKNetworkOperation *)doBidWithNeed:(NSString *)needId content:(NSString*)mContent completionHandler:(VoidBlock)mCompletionHandler errorHandler:(ErrorBlock)mErrorHandler{
    NSDictionary *params = @{@"sid":[[YUNEEDSConfig getSharedConfig] getSid], @"requirement_id":needId, @"content":mContent};
    MKNetworkOperation *operation = [self operationWithPath:MP_NEED_BID params:params httpMethod:@"POST"];
    [operation addCompletionHandler:^(MKNetworkOperation *successOperation){
        NSMutableDictionary *responseDictionary = [successOperation responseJSON];
        NSLog(@"收到:%@",[successOperation responseString]);
        // parse json not ok?
//        if (responseDictionary == NULL) {
//            mErrorHandler([self formatNSErrorFromString:@"没有收到"]);
//        }else{
            NSString *code = [responseDictionary objectForKey:CODE];
            // ok?
            if ([code isEqualToString:@"11111"]) {
                NSLog(@"t1%@",code);
                mCompletionHandler();
            }else{
                NSString *msg = [responseDictionary objectForKey:MESSAGE];
                mErrorHandler([self formatNSErrorFromString:msg]);
                NSLog(@"t2%@",msg);
            }
//        }

    }errorHandler:^(MKNetworkOperation *failedOperation, NSError *error){
        
    }];
    [self enqueueOperation:operation];
    return operation;
}

// 获取用户订单列表
- (MKNetworkOperation *)getOrderWithUsertype:(int)userType orderType:(int)mOrderType offset:(int)mOffset completionHandler:(ArrayBlock)mCompletionHandler errorHandler:(ErrorBlock)mErrorHandler{
    NSDictionary *params = @{@"userType":[NSString stringWithFormat:@"%d", userType], @"orderType":[NSString stringWithFormat:@"%d", mOrderType], @"num":[NSString stringWithFormat:@"%d",FETCH_ITEMS_NUMBER_PER_TIME], @"offset":[NSString stringWithFormat:@"%d",mOffset]};
        return [self fetchItemsFromNet:FETCH_USER_ORDER parms:params itemName:@"MyOrderDetail" emptyMessage:@"没有获取到您的订单信息" completionHandler:mCompletionHandler errorHandler:mErrorHandler];
}

// 发布需求
- (MKNetworkOperation*)releaseNeedWithName:(NSString *)name category:(int)mCategory budget:(NSString *)mBudget description:(NSString *)mDescription completionHandler:(VoidBlock)mCompletionHandler errorHandler:(ErrorBlock)mErrorHandler{
    NSDictionary *params = @{@"brief":name, @"ditail":mDescription, @"category":[NSString stringWithFormat:@"%d", mCategory], @"budget":mBudget};
    
    MKNetworkOperation *operation = [self operationWithPath:RELEASE_NEED params:[self formatParameters:params] httpMethod:@"POST"];
    [operation addCompletionHandler:^(MKNetworkOperation *successOperation){
        NSMutableDictionary *responseDictionary = [successOperation responseJSON];
        // parse json not ok?
        if (responseDictionary == NULL) {
            mErrorHandler([self formatNSErrorFromString:@"没有收到"]);
        }else{
            NSString *code = [responseDictionary objectForKey:CODE];
            // ok?
            if ([code isEqualToString:@"11111"]) {
                mCompletionHandler();
            }else{
                NSString *msg = [responseDictionary objectForKey:MESSAGE];
                mErrorHandler([self formatNSErrorFromString:msg]);
            }
        }
        
    }errorHandler:^(MKNetworkOperation *failedOperation, NSError *error){
        
    }];
    [self enqueueOperation:operation];
    return operation;
}

// 获取消息列表
- (MKNetworkOperation*)getMessageListWithCompletionHandler:(ArrayBlock)mCompletionHandler errorHandler:(ErrorBlock)mErrorHandler{
    NSDictionary *params = @{};
    return [self fetchItemsFromNet:GET_MESSAGES_LIST parms:params itemName:@"User" emptyMessage:@"没有获取到消息" completionHandler:mCompletionHandler errorHandler:mErrorHandler];
}

// 获取竞标者列表
- (MKNetworkOperation *)getBidsListWithNeed:(NSString *)needId offset:(int)mOffset completionHandler:(ArrayBlock)mCompletionHandler errorHandler:(ErrorBlock)mErrorHandler{
    NSDictionary *params = @{@"requirement_id":needId, @"num":[NSString stringWithFormat:@"%d",FETCH_ITEMS_NUMBER_PER_TIME], @"offset":[NSString stringWithFormat:@"%d", mOffset]};
    
    return [self fetchItemsFromNet:GET_BIDS_LIST parms:params itemName:@"BidDetail" emptyMessage:@"没有收到需求竞标者列表" completionHandler:mCompletionHandler errorHandler:mErrorHandler];
}

// 按竞标id获取竞标详情
- (MKNetworkOperation*)getBidDetailWithId:(NSString *)bidId completionHandler:(ModelBlock)mCompletionHandler errorHandler:(ErrorBlock)mErrorHandler{
    NSDictionary *params = @{@"pk_id":bidId};
    return [self fetchItemFromNet:GET_BID_DETAIL params:params itemName:@"BidDetail" emptyMessage:@"没有搜索到详情" completinoHandler:mCompletionHandler errorHandler:mErrorHandler];
}

// 按用户id获取用户详细信息
- (MKNetworkOperation*)getUserDetailInfoWithType:(NSString *)userType userId:(NSString *)mUserId completionHandler:(ModelBlock)mCompletionHandler errorHandler:(ErrorBlock)mErrorHandler{
    NSDictionary *params = @{@"userType":userType, @"userId":mUserId};
    if ([userType isEqualToString:@"1"]) { // 需求发布者
        return [self fetchItemFromNet:GET_USER_DETAIL params:params itemName:@"PublisherDetail" emptyMessage:@"没有搜索到需求发布者信息" completinoHandler:mCompletionHandler errorHandler:mErrorHandler];
    }else{
        return [self fetchItemFromNet:GET_USER_DETAIL params:params itemName:@"ProviderDetail" emptyMessage:@"没有获取到服务商详情" completinoHandler:mCompletionHandler errorHandler:mErrorHandler];
    }
}

// 选择中标服务商
- (MKNetworkOperation *)selectBidProviderWithProviderId:(NSString *)providerId requirementId:(NSString *)mRequirementId completionHandler:(VoidBlock)mCompletionHandler errorHandler:(ErrorBlock)mErrorHandler{
    NSDictionary *params = @{@"provider_id":providerId, @"requirement_id":mRequirementId};
    NSLog(@"ttttt");
    return [self fetchVoidFromNet:SELECT_BID_PROVIDER params:[params mutableCopy] completionHandler:mCompletionHandler errorHandler:mErrorHandler];
}

// 按用户id获取消息记录
- (MKNetworkOperation*)getMessageDetailByUser:(NSString *)user offset:(int)mOffset completionHandler:(ArrayBlock)mCompletionHandler errorHandler:(ErrorBlock)mErrorHandler{
    NSDictionary *params = @{@"user":user, @"offset":[NSString stringWithFormat:@"%d", mOffset] ,@"num":[NSString stringWithFormat:@"%d",FETCH_ITEMS_NUMBER_PER_TIME]};
    NSLog(@"params%@",params);
    return [self fetchItemsFromNet:GET_MESSAGE_DETAIL_BY_USER parms:params itemName:@"MessageDetail" emptyMessage:@"没有搜索到聊天消息" completionHandler:mCompletionHandler errorHandler:mErrorHandler];
}

// 发送消息
- (MKNetworkOperation*)sendMessageWithReceiver:(id)user content:(NSString *)mContent completionHandler:(VoidBlock)mCompletionHandler errorHandler:(ErrorBlock)mErrorHandler{
    NSDictionary *params = @{@"receiver":user, @"content":mContent};////receiver content sid
    return [self fetchVoidFromNet:SEND_MESSAGE params:[params mutableCopy] completionHandler:mCompletionHandler errorHandler:mErrorHandler];
}

// 付款到支付宝（托管）
- (MKNetworkOperation*)payToAliPayWithRequirement:(NSString *)requirement completionHandler:(VoidBlock)mCompletionHandler errorHandler:(ErrorBlock)mErrorHandler{
    NSDictionary *params = @{@"requirement_id":requirement};
    return [self fetchVoidFromNet:PAY_TO_ALIPAY params:[params mutableCopy] completionHandler:mCompletionHandler errorHandler:mErrorHandler];
}

// 确认动作
- (MKNetworkOperation*)confirmActionWithUserType:(int)userType requirementId:(NSString *)mRequirementId completionHandler:(VoidBlock)mCompletionHandler errorHandler:(ErrorBlock)mErrorHandler{
    NSDictionary *params = @{@"requirement_id":mRequirementId};
    if (userType == 1) {// 需求发布者
        return [self fetchVoidFromNet:CONFIRM_PUBLISHER_USER params:[params mutableCopy] completionHandler:mCompletionHandler errorHandler:mErrorHandler];
    }else{
        return [self fetchVoidFromNet:CONFIRM_PROVIDER_USE params:[params mutableCopy] completionHandler:mCompletionHandler errorHandler:mErrorHandler];
    }
}

// 评价动作
- (MKNetworkOperation*)rateWithRequirement:(NSString *)rID rateLevel:(int)mRate completionHandler:(VoidBlock)mCompletionHandler errorHandler:(ErrorBlock)mErrorHandler{
    NSDictionary *params = @{@"requirement_id":rID, @"rate":[NSString stringWithFormat:@"%d",mRate]};
    NSLog(@"params:%@",params);
    return [self fetchVoidFromNet:RATE_API params:[params mutableCopy] completionHandler:mCompletionHandler errorHandler:mErrorHandler];
}
@end
