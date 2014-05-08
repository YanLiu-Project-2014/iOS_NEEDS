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

@end
