//
//  RCAPIBaseManager.m
//  RCIOS-SDK
//
//  Created by gzkp on 2019/3/30.
//  Copyright © 2019年 RC. All rights reserved.
//

#import "RCAPIBaseManager.h"
#import "RCNetworking.h"
#import "RCCacheCenter.h"
#import "RCLogger.h"
#import "RCServiceFactory.h"
#import "RCApiProxy.h"
#import "CTMediator+RCAppContext.h"
#import "RCServiceFactory.h"

NSString * const kRCUserTokenInvalidNotification = @"kRCUserTokenInvalidNotification";
NSString * const kRCUserTokenIllegalNotification = @"kRCUserTokenIllegalNotification";

NSString * const kRCUserTokenNotificationUserInfoKeyManagerToContinue = @"kRCUserTokenNotificationUserInfoKeyManagerToContinue";
NSString * const kRCAPIBaseManagerRequestID = @"kRCAPIBaseManagerRequestID";

@interface RCAPIBaseManager ()

@property (nonatomic, strong, readwrite) id fetchedRawData;
@property (nonatomic, assign, readwrite) BOOL isLoading;
@property (nonatomic, copy, readwrite) NSString *errorMessage;

@property (nonatomic, readwrite) RCAPIManagerErrorType errorType;
@property (nonatomic, strong) NSMutableArray *requestIdList;

@property (nonatomic, strong, nullable) void (^successBlock)(RCAPIBaseManager *apimanager);
@property (nonatomic, strong, nullable) void (^failBlock)(RCAPIBaseManager *apimanager);

@end


@implementation RCAPIBaseManager

#pragma mark - life cycle
- (instancetype)init
{
    self = [super init];
    if (self) {
        _delegate = nil;
        _validator = nil;
        _paramSource = nil;
        
        _fetchedRawData = nil;
        
        _errorMessage = nil;
        _errorType = RCAPIManagerErrorTypeDefault;
        
        _memoryCacheSecond = 3 * 60;
        _diskCacheSecond = 3 * 60;
        
        if ([self conformsToProtocol:@protocol(RCAPIManagerDelegate)]) {
            self.child = (id <RCAPIManagerDelegate>)self;
        } else {
            NSException *exception = [[NSException alloc] init];
            @throw exception;
        }
    }
    return self;
}

- (void)dealloc
{
    [self cancelAllRequests];
    self.requestIdList = nil;
}

#pragma mark - NSCopying
- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

#pragma mark - public methods
- (void)cancelAllRequests
{
    [[RCApiProxy sharedInstance] cancelRequestWithRequestIDList:self.requestIdList];
    [self.requestIdList removeAllObjects];
}

- (void)cancelRequestWithRequestId:(NSInteger)requestID
{
    [self removeRequestIdWithRequestID:requestID];
    [[RCApiProxy sharedInstance] cancelRequestWithRequestID:@(requestID)];
}

- (id)fetchDataWithReformer:(id<RCAPIManagerDataReformer>)reformer
{
    id resultData = nil;
    if ([reformer respondsToSelector:@selector(manager:reformData:)]) {
        resultData = [reformer manager:self reformData:self.fetchedRawData];
    } else {
        resultData = [self.fetchedRawData mutableCopy];
    }
    return resultData;
}

#pragma mark - calling api
- (NSInteger)loadData
{
    NSDictionary *params = [self.paramSource paramsForApi:self];
    NSInteger requestId = [self loadDataWithParams:params];
    return requestId;
}

+ (NSInteger)loadDataWithParams:(NSDictionary *)params success:(void (^)(RCAPIBaseManager *))successCallback fail:(void (^)(RCAPIBaseManager *))failCallback
{
    return [[[self alloc] init] loadDataWithParams:params success:successCallback fail:failCallback];
}

- (NSInteger)loadDataWithParams:(NSDictionary *)params success:(void (^)(RCAPIBaseManager *))successCallback fail:(void (^)(RCAPIBaseManager *))failCallback
{
    self.successBlock = successCallback;
    self.failBlock = failCallback;
    
    return [self loadDataWithParams:params];
}

// 有时间重新打一遍这个方法
- (NSInteger)loadDataWithParams:(NSDictionary *)params
{
    NSInteger requestId = 0;
    NSDictionary *reformedParams = [self reformParams:params];
    if (reformedParams == nil) {
        reformedParams = @{};
    }
    if ([self shouldCallAPIWithParams:reformedParams]) {
        RCAPIManagerErrorType errorType = [self.validator manager:self isCorrectWithParamsData:reformedParams];
        if (errorType == RCAPIManagerErrorTypeNoError) {
            
            RCURLResponse *response = nil;
            // 先检查一下是否有内存缓存
            if ((self.cachePolicy & RCAPIManagerCachePolicyMemory) && self.shouldIgnoreCache == NO) {
                response = [[RCCacheCenter sharedInstance] fetchMemoryCacheWithServiceIdentifier:self.child.serviceIdentifier methodName:self.child.methodName params:reformedParams];
            }
            
            // 再检查是否有磁盘缓存
            if ((self.cachePolicy & RCAPIManagerCachePolicyDisk) && self.shouldIgnoreCache == NO) {
                response = [[RCCacheCenter sharedInstance] fetchDiskCacheWithServiceIdentifier:self.child.serviceIdentifier methodName:self.child.methodName params:reformedParams];
            }
            
            if (response != nil) {
                [self successedOnCallingAPI:response];
                return 0;
            }
            
            // 实际的网络请求
            if ([self isReachable]) {
                self.isLoading = YES;
                
                id <RCServiceProtocol> service = [[RCServiceFactory sharedInstance] serviceWithIdentifier:self.child.serviceIdentifier];
                NSURLRequest *request = [service requestWithParams:reformedParams methodName:self.child.methodName requestType:self.child.requestType];
                request.service = service;
                request.originRequestParams = reformedParams;
                [RCLogger logDebugInfoWithRequest:request apiName:self.child.methodName service:service];
                
                NSNumber *requestId = [[RCApiProxy sharedInstance] callApiWithRequest:request success:^(RCURLResponse *response) {
                    [self successedOnCallingAPI:response];
                } fail:^(RCURLResponse *response) {
                    RCAPIManagerErrorType errorType = RCAPIManagerErrorTypeDefault;
                    if (response.status == RCURLResponseStatusErrorCancel) {
                        errorType = RCAPIManagerErrorTypeCanceled;
                    }
                    if (response.status == RCURLResponseStatusErrorTimeout) {
                        errorType = RCAPIManagerErrorTypeTimeout;
                    }
                    if (response.status == RCURLResponseStatusErrorNoNetwork) {
                        errorType = RCAPIManagerErrorTypeNoNetWork;
                    }
                    [self failedOnCallingAPI:response withErrorType:errorType];
                }];
                [self.requestIdList addObject:requestId];
                
                NSMutableDictionary *params = [reformedParams mutableCopy];
                params[kRCAPIBaseManagerRequestID] = requestId;
                [self afterCallingAPIWithParams:params];
                return [requestId integerValue];
                
            } else {
                [self failedOnCallingAPI:nil withErrorType:RCAPIManagerErrorTypeNoNetWork];
                return requestId;
            }
        } else {
            [self failedOnCallingAPI:nil withErrorType:errorType];
            return requestId;
        }
    }
    return requestId;
}

#pragma mark - api callbacks
- (void)successedOnCallingAPI:(RCURLResponse *)response
{
    
    self.isLoading = NO;
    self.response = response;
    
    if (response.content) {
        self.fetchedRawData = [response.content copy];
    } else {
        self.fetchedRawData = [response.responseData copy];
    }
    
    [self removeRequestIdWithRequestID:response.requestId];
    
    RCAPIManagerErrorType errorType = [self.validator manager:self isCorrectWithCallBackData:response.content];
    if (errorType == RCAPIManagerErrorTypeNoError) {
        
        if (self.cachePolicy != RCAPIManagerCachePolicyNoCache && response.isCache == NO) {
            if (self.cachePolicy & RCAPIManagerCachePolicyMemory) {
                [[RCCacheCenter sharedInstance] saveMemoryCacheWithResponse:response
                                                          serviceIdentifier:self.child.serviceIdentifier
                                                                 methodName:self.child.methodName
                                                                  cacheTime:self.memoryCacheSecond];
            }
            
            if (self.cachePolicy & RCAPIManagerCachePolicyDisk) {
                [[RCCacheCenter sharedInstance] saveDiskCacheWithResponse:response
                                                        serviceIdentifier:self.child.serviceIdentifier
                                                               methodName:self.child.methodName
                                                                cacheTime:self.diskCacheSecond];
            }
        }
        
        if ([self.interceptor respondsToSelector:@selector(manager:didReceiveResponse:)]) {
            [self.interceptor manager:self didReceiveResponse:response];
        }
        if ([self beforePerformSuccessWithResponse:response]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([self.delegate respondsToSelector:@selector(managerCallAPIDidSuccess:)]) {
                    [self.delegate managerCallAPIDidSuccess:self];
                }
                if (self.successBlock) {
                    self.successBlock(self);
                }
            });
        }
        [self afterPerformSuccessWithResponse:response];
    } else {
        [self failedOnCallingAPI:response withErrorType:errorType];
    }
}

- (void)failedOnCallingAPI:(RCURLResponse *)response withErrorType:(RCAPIManagerErrorType)errorType
{
    self.isLoading = NO;
    if (response) {
        self.response = response;
    }
    self.errorType = errorType;
    [self removeRequestIdWithRequestID:response.requestId];
    
    // 可以自动处理的错误
    // user token 无效，重新登录
    if (errorType == RCAPIManagerErrorTypeNeedLogin) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kRCUserTokenIllegalNotification
                                                            object:nil
                                                          userInfo:@{
                                                                     kRCUserTokenNotificationUserInfoKeyManagerToContinue:self
                                                                     }];
        return;
    }
    
    // 可以自动处理的错误
    // user token 过期，重新刷新
    if (errorType == RCAPIManagerErrorTypeNeedAccessToken) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kRCUserTokenInvalidNotification
                                                            object:nil
                                                          userInfo:@{
                                                                     kRCUserTokenNotificationUserInfoKeyManagerToContinue:self
                                                                     }];
        return;
    }
    
    id<RCServiceProtocol> service = [[RCServiceFactory sharedInstance] serviceWithIdentifier:self.child.serviceIdentifier];
    BOOL shouldContinue = [service handleCommonErrorWithResponse:response manager:self errorType:errorType];
    if (shouldContinue == NO) {
        return;
    }
    
    // 常规错误
    if (errorType == RCAPIManagerErrorTypeNoNetWork) {
        self.errorMessage = @"无网络连接，请检查网络";
    }
    if (errorType == RCAPIManagerErrorTypeTimeout) {
        self.errorMessage = @"请求超时";
    }
    if (errorType == RCAPIManagerErrorTypeCanceled) {
        self.errorMessage = @"您已取消";
    }
    if (errorType == RCAPIManagerErrorTypeDownGrade) {
        self.errorMessage = @"网络拥塞";
    }
    
    // 其他错误
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.interceptor respondsToSelector:@selector(manager:didReceiveResponse:)]) {
            [self.interceptor manager:self didReceiveResponse:response];
        }
        if ([self beforePerformFailWithResponse:response]) {
            [self.delegate managerCallAPIDidFailed:self];
        }
        if (self.failBlock) {
            self.failBlock(self);
        }
        [self afterPerformFailWithResponse:response];
    });
}

#pragma mark - method for interceptor

/*
 拦截器的功能可以由子类通过继承实现，也可以由其它对象实现,两种做法可以共存
 当两种情况共存的时候，子类重载的方法一定要调用一下super
 然后它们的调用顺序是BaseManager会先调用子类重载的实现，再调用外部interceptor的实现
 
 notes:
 正常情况下，拦截器是通过代理的方式实现的，因此可以不需要以下这些代码
 但是为了将来拓展方便，如果在调用拦截器之前manager又希望自己能够先做一些事情，所以这些方法还是需要能够被继承重载的
 所有重载的方法，都要调用一下super,这样才能保证外部interceptor能够被调到
 这就是decorate pattern
 */
- (BOOL)beforePerformSuccessWithResponse:(RCURLResponse *)response
{
    BOOL result = YES;
    
    self.errorType = RCAPIManagerErrorTypeSuccess;
    if ((NSInteger)self != (NSInteger)self.interceptor && [self.interceptor respondsToSelector:@selector(manager: beforePerformSuccessWithResponse:)]) {
        result = [self.interceptor manager:self beforePerformSuccessWithResponse:response];
    }
    return result;
}

- (void)afterPerformSuccessWithResponse:(RCURLResponse *)response
{
    if ((NSInteger)self != (NSInteger)self.interceptor && [self.interceptor respondsToSelector:@selector(manager:afterPerformSuccessWithResponse:)]) {
        [self.interceptor manager:self afterPerformSuccessWithResponse:response];
    }
}

- (BOOL)beforePerformFailWithResponse:(RCURLResponse *)response
{
    BOOL result = YES;
    if ((NSInteger)self != (NSInteger)self.interceptor && [self.interceptor respondsToSelector:@selector(manager:beforePerformFailWithResponse:)]) {
        result = [self.interceptor manager:self beforePerformFailWithResponse:response];
    }
    return result;
}

- (void)afterPerformFailWithResponse:(RCURLResponse *)response
{
    if ((NSInteger)self != (NSInteger)self.interceptor && [self.interceptor respondsToSelector:@selector(manager:afterPerformFailWithResponse:)]) {
        [self.interceptor manager:self afterPerformFailWithResponse:response];
    }
}

//只有返回YES才会继续调用API
- (BOOL)shouldCallAPIWithParams:(NSDictionary *)params
{
    if ((NSInteger)self != (NSInteger)self.interceptor && [self.interceptor respondsToSelector:@selector(manager:shouldCallAPIWithParams:)]) {
        return [self.interceptor manager:self shouldCallAPIWithParams:params];
    } else {
        return YES;
    }
}

- (void)afterCallingAPIWithParams:(NSDictionary *)params
{
    if ((NSInteger)self != (NSInteger)self.interceptor && [self.interceptor respondsToSelector:@selector(manager:afterCallingAPIWithParams:)]) {
        [self.interceptor manager:self afterCallingAPIWithParams:params];
    }
}

#pragma mark - method for child
- (void)cleanData
{
    self.fetchedRawData = nil;
    self.errorType = RCAPIManagerErrorTypeDefault;
}

//如果需要在调用API之前额外添加一些参数，比如pageNumber和pageSize之类的就在这里添加
//子类中覆盖这个函数的时候就不需要调用[super reformParams:params]了
- (NSDictionary *)reformParams:(NSDictionary *)params
{
    IMP childIMP = [self.child methodForSelector:@selector(reformParams:)];
    IMP selfIMP = [self methodForSelector:@selector(reformParams:)];
    
    if (childIMP == selfIMP) {
        return params;
    } else {
        // 如果child是继承得来的，那么这里就不会跑到，会直接跑子类中的IMP。
        // 如果child是另一个对象，就会跑到这里
        NSDictionary *result = nil;
        result = [self.child reformParams:params];
        if (result) {
            return result;
        } else {
            return params;
        }
    }
}

#pragma mark - private methods
- (void)removeRequestIdWithRequestID:(NSInteger)requestId
{
    NSNumber *requestIDToRemove = nil;
    for (NSNumber *storedRequestId in self.requestIdList) {
        if ([storedRequestId integerValue] == requestId) {
            requestIDToRemove = storedRequestId;
        }
    }
    if (requestIDToRemove) {
        [self.requestIdList removeObject:requestIDToRemove];
    }
}

#pragma mark - getters and setters
- (NSMutableArray *)requestIdList
{
    if (_requestIdList == nil) {
        _requestIdList = [[NSMutableArray alloc] init];
    }
    return _requestIdList;
}

- (BOOL)isReachable
{
    BOOL isReachability = [[CTMediator sharedInstance] RCNetworking_isReachable];
    if (!isReachability) {
        self.errorType = RCAPIManagerErrorTypeNoNetWork;
    }
    return isReachability;
}

- (BOOL)isLoading
{
    if (self.requestIdList.count == 0) {
        _isLoading = NO;
    }
    return _isLoading;
}



@end
