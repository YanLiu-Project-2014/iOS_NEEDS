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
#define MP_NEEDSELECTION_URL @"" // 主页-精选需求
#define MP_SERVICESELECTION_URL @"" // 主页-精选服务
#define MP_PROVIDERSELECTION_URL @"" // 主页-精选服务商

// const response type string
#define CODE @"code"
#define MESSAGE @"message"
#define RESULT @"result"

@implementation NeedsEngine

-(id) initWithDefaultSettings {
    
    if(self = [super initWithHostName:SERVER_BASE customHeaderFields:@{@"x-client-identifier" : @"iOS"}]) {
        
    }
    
    return self;
}

-(MKNetworkOperation*) doLogin:(NSString*)name password:(NSString *)pwd completionHandler:(ModelBlock)completionHandler errorHandler:(ErrorBlock)errorHandler{
    // prepare parameters.
    NSDictionary *params = @{@"user_name":name,@"pwd":pwd, @"user_type":@"publisher", @"end_type":@"ios"};
    
    // prepare operation.
    MKNetworkOperation *op = [self operationWithPath:LOGIN_URL params:params httpMethod:@"POST"];
    [op addCompletionHandler:^(MKNetworkOperation *successOperation){
        NSMutableDictionary *responseDictionary = [successOperation responseJSON];
        
        // parse json not ok?
        if (responseDictionary == NULL) {
            errorHandler((NSError*)@"响应解析错误，请联系管理员");
        }else{
            NSString *code = [responseDictionary objectForKey:CODE];
            
            // login ok?
            if ([code isEqualToString:@"11111"]) {
                NSMutableDictionary *userJson = [responseDictionary objectForKey:RESULT];
                User *user = [[User alloc] initWithDictionary:userJson];
                completionHandler(user);
            }else{
                NSString *msg = [responseDictionary objectForKey:MESSAGE];
                errorHandler((NSError *)msg);
            }
        }
    }errorHandler:^(MKNetworkOperation *errorOperation, NSError *error){
        errorHandler(nil); // hide the progress bar.
        [UIAlertView showWithError:error];
    }];
    
    // add the operation to queue to excute it.
    [self enqueueOperation:op];
    return op;
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

-(MKNetworkOperation*)getSelectionInMainpage:(NSString *)mType completionHandler:(ArrayBlock)mCompletionHandler errorHandler:(ErrorBlock)mErrorHandler{
    MKNetworkOperation *operation = [self operationWithPath:@"" params:@"" httpMethod:@""];
    return operation;
}
@end
