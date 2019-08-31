//
//  RCApiProxy.m
//  RCIOS-SDK
//
//  Created by gzkp on 2019/3/30.
//  Copyright © 2019年 RC. All rights reserved.
//

#import "RCApiProxy.h"
#import "RCApiProxy.h"
#import "RCServiceFactory.h"
#import "RCLogger.h"
#import "NSURLRequest+RCNetworkingMethods.h"
#import "NSString+AXNetworkingMethods.h"
#import "NSObject+AXNetworkingMethods.h"
#import "CTMediator+RCAppContext.h"

static NSString * const kAXApiProxyDispatchItemKeyCallbackSuccess = @"kAXApiProxyDispatchItemCallbackSuccess";
static NSString * const kAXApiProxyDispatchItemKeyCallbackFail = @"kAXApiProxyDispatchItemCallbackFail";

NSString * const kRCApiProxyValidateResultKeyResponseObject = @"kRCApiProxyValidateResultKeyResponseObject";
NSString * const kRCApiProxyValidateResultKeyResponseString = @"kRCApiProxyValidateResultKeyResponseString";

@interface RCApiProxy ()

@property (nonatomic, strong) NSMutableDictionary *dispatchTable;
@property (nonatomic, strong) NSNumber *recordedRequestId;

@end

@implementation RCApiProxy

#pragma mark - getters and setters
- (NSMutableDictionary *)dispatchTable
{
    if (_dispatchTable == nil) {
        _dispatchTable = [[NSMutableDictionary alloc] init];
    }
    return _dispatchTable;
}

- (AFHTTPSessionManager *)sessionManagerWithService:(id<RCServiceProtocol>)service
{
    AFHTTPSessionManager *sessionManager = nil;
    if ([service respondsToSelector:@selector(sessionManager)]) {
        sessionManager = service.sessionManager;
    }
    if (sessionManager == nil) {
        sessionManager = [AFHTTPSessionManager manager];
    }
    return sessionManager;
}

#pragma mark - life cycle
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static RCApiProxy *sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[RCApiProxy alloc] init];
    });
    return sharedInstance;
}

#pragma mark - public methods
- (void)cancelRequestWithRequestID:(NSNumber *)requestID
{
    NSURLSessionDataTask *requestOperation = self.dispatchTable[requestID];
    [requestOperation cancel];
    [self.dispatchTable removeObjectForKey:requestID];
}

- (void)cancelRequestWithRequestIDList:(NSArray *)requestIDList
{
    for (NSNumber *requestId in requestIDList) {
        [self cancelRequestWithRequestID:requestId];
    }
}

/** 这个函数存在的意义在于，如果将来要把AFNetworking换掉，只要修改这个函数的实现即可。 */
- (NSNumber *)callApiWithRequest:(NSURLRequest *)request success:(RCCallback)success fail:(RCCallback)fail
{
    // 跑到这里的block的时候，就已经是主线程了。
    __block NSURLSessionDataTask *dataTask = nil;
    dataTask = [[self sessionManagerWithService:request.service] dataTaskWithRequest:request
                                                                      uploadProgress:nil
                                                                    downloadProgress:nil
                                                                   completionHandler:^(NSURLResponse * _Nonnull response, id _Nullable responseObject, NSError * _Nullable error) {
                                                                       NSNumber *requestID = @([dataTask taskIdentifier]);
                                                                       [self.dispatchTable removeObjectForKey:requestID];
                                                                       
                                                                       NSDictionary *result = [request.service resultWithResponseObject:responseObject response:response request:request error:&error];
                                                                       // 输出返回数据
                                                                       RCURLResponse *RCResponse = [[RCURLResponse alloc] initWithResponseString:result[kRCApiProxyValidateResultKeyResponseString]
                                                                                                                                       requestId:requestID
                                                                                                                                         request:request
                                                                                                                                  responseObject:result[kRCApiProxyValidateResultKeyResponseObject]
                                                                                                                                           error:error];
                                                                       
                                                                       RCResponse.logString = [RCLogger logDebugInfoWithResponse:(NSHTTPURLResponse *)response
                                                                                                                  responseObject:responseObject
                                                                                                                  responseString:result[kRCApiProxyValidateResultKeyResponseString]
                                                                                                                         request:request
                                                                                                                           error:error];
                                                                       
                                                                       if (error) {
                                                                           fail?fail(RCResponse):nil;
                                                                       } else {
                                                                           success?success(RCResponse):nil;
                                                                       }
                                                                   }];
    
    NSNumber *requestId = @([dataTask taskIdentifier]);
    
    self.dispatchTable[requestId] = dataTask;
    [dataTask resume];
    
    return requestId;
}

@end
