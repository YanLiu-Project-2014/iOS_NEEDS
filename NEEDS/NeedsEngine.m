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
#define FETCH_ITEMS_NUMBER_PER_TIME 15 // 每次请求15条数据

// const response type string
#define CODE @"code"
#define MESSAGE @"message"
#define RESULT @"result"
@interface NeedsEngine(NEEDS_Engine_Private)

- (NSError *) formatNSErrorFromString:(NSString *)errorString;

- (MKNetworkOperation *)fetchItemFromNet:(NSString *)path params:(NSDictionary *)mParams itemName:(NSString *)mItemName emptyMessage:(NSString *)mEmptyMessage completinoHandler:(ModelBlock)mCompletionHandler errorHandler:(ErrorBlock)mErrorHandler;

- (MKNetworkOperation *) fetchItemsFromNet:(NSString *)path parms:(NSDictionary *)mParams itemName:(NSString *)mItemName emptyMessage:(NSString *)mEmptyMessage completionHandler:(ArrayBlock)mCompletionHandler errorHandler:(ErrorBlock)mErrorHandler;

@end


@implementation NeedsEngine

-(id) initWithDefaultSettings {
    
    if(self = [super initWithHostName:SERVER_BASE customHeaderFields:@{@"x-client-identifier" : @"iOS"}]) {
        
    }
    
    return self;
}

/**
 *  将字符串格式化为NSError格式，并返回
 *
 *  @param errorString 错误的内容（字符串描述形式）
 *
 *  @return 错误（NSERROR格式）
 *
 *  @since 1.0
 */
- (NSError *) formatNSErrorFromString:(NSString *)errorString{
    NSError *resultError;
    NSDictionary *details = [NSMutableDictionary dictionary];
    [details setValue:errorString forKey:NSLocalizedDescriptionKey];
    resultError = [NSError errorWithDomain:@"word" code:111 userInfo:details];
    return resultError;
}

- (NSDictionary*)formatParameters:(NSDictionary *)params{
    NSMutableDictionary *mParams = [params mutableCopy];
    [mParams setObject:[[YUNEEDSConfig getSharedConfig] getSid] forKey:@"sid"];
    return mParams;
}

/**
 *  （公共）网络操作方法（获得单个模型）
 *
 *  @param path               接口路径
 *  @param mParams            接口参数
 *  @param mItemName          解析对象的名称（模型类的名称）
 *  @param mEmptyMessage      结果为空时的提示信息
 *  @param mCompletionHandler 成功处理方法
 *  @param mErrorHandler      错误处理方法
 *
 *  @return 网络请求操作
 *
 *  @since 1.0
 */
- (MKNetworkOperation *)fetchItemFromNet:(NSString *)path params:(NSMutableDictionary *)mParams itemName:(NSString *)mItemName emptyMessage:(NSString *)mEmptyMessage completinoHandler:(ModelBlock)mCompletionHandler errorHandler:(ErrorBlock)mErrorHandler{
    MKNetworkOperation *op = [self operationWithPath:path params:[self formatParameters:mParams] httpMethod:@"POST"];
    [op addCompletionHandler:^(MKNetworkOperation *successOperation){
        NSMutableDictionary *responseDictionary = [successOperation responseJSON];
        
        // parse json not ok?
        if (responseDictionary == NULL) {
            NSLog(@"引擎收到结果：%@",[successOperation responseString]);
            mErrorHandler([self formatNSErrorFromString:mEmptyMessage]);
        }else{
            NSString *code = [responseDictionary objectForKey:CODE];
            if ([code isEqualToString:@"11111"]) {
                NSMutableDictionary *userJson = [responseDictionary objectForKey:RESULT];
                Class ObjectClass = NSClassFromString(mItemName);
                id object = [[ObjectClass alloc] initWithDictionary:userJson];
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

- (MKNetworkOperation *) fetchItemsFromNet:(NSString *)path parms:(NSMutableDictionary *)mParams itemName:(NSString *)mItemName emptyMessage:(NSString *)mEmptyMessage completionHandler:(ArrayBlock)mCompletionHandler errorHandler:(ErrorBlock)mErrorHandler{
    MKNetworkOperation *operation;
    operation = [self operationWithPath:path params:[self formatParameters:mParams] httpMethod:@"POST"];
    [operation addCompletionHandler:^(MKNetworkOperation *successOperation){
        NSMutableDictionary *responseDictionary = [successOperation responseJSON];
        
        if ([responseDictionary isMemberOfClass:[NSArray class]]) {
            mErrorHandler([self formatNSErrorFromString:mEmptyMessage]);
//            NSLog(@"null results:%@",[successOperation responseString]);
        }else{
            NSString *code = [responseDictionary objectForKey:@"code"];
            if ([code isEqualToString:@"11111"] ) {
                NSMutableArray *responseArray = [responseDictionary objectForKey:@"result"];
                NSMutableArray *resultsList = [NSMutableArray array];
                NSLog(@"引擎收到结果：%@",[successOperation responseString]);
                [responseArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    [resultsList addObject:[[NSClassFromString(mItemName) alloc] initWithDictionary:obj]];
                }];
                NSLog(@"result num:%d", [resultsList count]);
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

-(MKNetworkOperation*)getSelectionInMainpage:(NSString *)mType completionHandler:(DictionaryBlock)mCompletionHandler errorHandler:(ErrorBlock)mErrorHandler{
    NSDictionary *params = @{@"end_type":@"ios"};
    
    MKNetworkOperation *operation;
        operation = [self operationWithPath:MP_NEEDSELECTION_URL params:params httpMethod:@"POST"];
    [operation addCompletionHandler:^(MKNetworkOperation *successOperation){
        NSMutableDictionary *responseDictionary = [successOperation responseJSON];
        
        if (responseDictionary == NULL) {
            NSError *emptyResultError;
            NSDictionary *details = [NSMutableDictionary dictionary];
                [details setValue:@"没有收到精选信息" forKey:NSLocalizedDescriptionKey];
            emptyResultError = [NSError errorWithDomain:@"word" code:111 userInfo:details];
            mErrorHandler(emptyResultError);
            NSLog(@"null result in engine:%@",[successOperation responseString]);
        }else{
            NSMutableDictionary *responseArray = [responseDictionary objectForKey:@"result"];
            NSMutableArray *needsList = [NSMutableArray array];
            NSMutableArray *providersList = [NSMutableArray array];
            
            NSLog(@"receive in engine:%@",[successOperation responseString]);
            // 需求
            NSArray *responseNeeds = [responseArray objectForKey:@"requirement"];
            NSArray *responseProviders = [responseArray objectForKey:@"provider"];
//            NSLog(@"receive in engineneeds:%@, provider:%@",responseNeeds, responseProviders);
            
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

- (MKNetworkOperation *)fetchNeedsListByCategory:(NSString *)category offSet:(int)mOffset completionHandler:(ArrayBlock)mCompletionHandler errorHandler:(ErrorBlock)mErrorHandler{
    NSLog(@"test sign1");
    NSDictionary *params = @{@"end_type":@"ios", @"category":category, @"num":[NSString stringWithFormat:@"%d", FETCH_ITEMS_NUMBER_PER_TIME], @"offset":[NSString stringWithFormat:@"%d", mOffset]};
    NSLog(@"test sign2");
    return [self fetchItemsFromNet:MP_FETCH_NEEDS_BY_CATEGORY parms:params itemName:@"NeedDetail" emptyMessage:@"没有需求列表" completionHandler:mCompletionHandler errorHandler:mErrorHandler];
}

- (MKNetworkOperation *)getNeedDetailById:(NSString *)mId completionHandler:(ModelBlock)mCompletionHandler errorHandler:(ErrorBlock)mErrorHandler{
    NSDictionary *mParams = @{@"requirement_id":mId};
    NSLog(@"参数%@",mParams);
    NSLog(@"接口%@",NSD_FETCH_NEEDS_DETAIL_BY_ID);
    
    return [self fetchItemFromNet:NSD_FETCH_NEEDS_DETAIL_BY_ID params:mParams itemName:@"NeedDetail" emptyMessage:@"获取结果出错" completinoHandler:mCompletionHandler errorHandler:mErrorHandler];
}

- (MKNetworkOperation *)doBidWithNeed:(NSString *)needId content:(NSString*)mContent completionHandler:(VoidBlock)mCompletionHandler errorHandler:(ErrorBlock)mErrorHandler{
    NSDictionary *params = @{@"sid":[[YUNEEDSConfig getSharedConfig] getSid], @"requirement_id":needId, @"content":mContent};
    MKNetworkOperation *operation = [self operationWithPath:MP_NEED_BID params:params httpMethod:@"POST"];
    [operation addCompletionHandler:^(MKNetworkOperation *successOperation){
        NSMutableDictionary *responseDictionary = [successOperation responseJSON];
        NSLog(@"receive bid :%@",[successOperation responseString]);
        // parse json not ok?
        if (responseDictionary == NULL) {
            NSLog(@"引擎收到结果：%@",[successOperation responseString]);
            mErrorHandler([self formatNSErrorFromString:@"没有收到"]);
        }else{
            NSString *code = [responseDictionary objectForKey:CODE];
            // login ok?
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
@end
