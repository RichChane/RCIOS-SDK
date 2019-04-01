//
//  RCCacheCenter.m
//  RCIOS-SDK
//
//  Created by gzkp on 2019/4/1.
//  Copyright © 2019年 RC. All rights reserved.
//

#import "RCCacheCenter.h"
#import "RCMemoryCacheDataCenter.h"
#import "RCMemoryCachedRecord.h"
#import "RCLogger.h"
#import "RCServiceFactory.h"
#import "NSDictionary+AXNetworkingMethods.h"
#import "RCDiskCacheCenter.h"
#import "RCMemoryCacheDataCenter.h"

@interface RCCacheCenter ()

@property (nonatomic, strong) RCMemoryCacheDataCenter *memoryCacheCenter;
@property (nonatomic, strong) RCDiskCacheCenter *diskCacheCenter;

@end

@implementation RCCacheCenter

+ (instancetype)sharedInstance
{
    static RCCacheCenter *cacheCenter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cacheCenter = [[RCCacheCenter alloc] init];
    });
    return cacheCenter;
}

- (RCURLResponse *)fetchDiskCacheWithServiceIdentifier:(NSString *)serviceIdentifier methodName:(NSString *)methodName params:(NSDictionary *)params
{
    RCURLResponse *response = [self.diskCacheCenter fetchCachedRecordWithKey:[self keyWithServiceIdentifier:serviceIdentifier methodName:methodName requestParams:params]];
    if (response) {
        response.logString = [RCLogger logDebugInfoWithCachedResponse:response methodName:methodName service:[[RCServiceFactory sharedInstance] serviceWithIdentifier:serviceIdentifier] params:params];
    }
    return response;
}

- (RCURLResponse *)fetchMemoryCacheWithServiceIdentifier:(NSString *)serviceIdentifier methodName:(NSString *)methodName params:(NSDictionary *)params
{
    RCURLResponse *response = [self.memoryCacheCenter fetchCachedRecordWithKey:[self keyWithServiceIdentifier:serviceIdentifier methodName:methodName requestParams:params]];
    if (response) {
        response.logString = [RCLogger logDebugInfoWithCachedResponse:response methodName:methodName service:[[RCServiceFactory sharedInstance] serviceWithIdentifier:serviceIdentifier] params:params];
    }
    return response;
}

- (void)saveDiskCacheWithResponse:(RCURLResponse *)response serviceIdentifier:(NSString *)serviceIdentifier methodName:(NSString *)methodName cacheTime:(NSTimeInterval)cacheTime
{
    if (response.originRequestParams && response.content && serviceIdentifier && methodName) {
        [self.diskCacheCenter saveCacheWithResponse:response key:[self keyWithServiceIdentifier:serviceIdentifier methodName:methodName requestParams:response.originRequestParams] cacheTime:cacheTime];
    }
}

- (void)saveMemoryCacheWithResponse:(RCURLResponse *)response serviceIdentifier:(NSString *)serviceIdentifier methodName:(NSString *)methodName cacheTime:(NSTimeInterval)cacheTime
{
    if (response.originRequestParams && response.content && serviceIdentifier && methodName) {
        [self.memoryCacheCenter saveCacheWithResponse:response key:[self keyWithServiceIdentifier:serviceIdentifier methodName:methodName requestParams:response.originRequestParams] cacheTime:cacheTime];
    }
}

- (void)cleanAllDiskCache
{
    [self.diskCacheCenter cleanAll];
}

- (void)cleanAllMemoryCache
{
    [self.memoryCacheCenter cleanAll];
}

#pragma mark - private methods
- (NSString *)keyWithServiceIdentifier:(NSString *)serviceIdentifier
                            methodName:(NSString *)methodName
                         requestParams:(NSDictionary *)requestParams
{
    NSString *key = [NSString stringWithFormat:@"%@%@%@", serviceIdentifier, methodName, [requestParams RC_transformToUrlParamString]];
    return key;
}

#pragma mark - getters and setters
- (RCDiskCacheCenter *)diskCacheCenter
{
    if (_diskCacheCenter == nil) {
        _diskCacheCenter = [[RCDiskCacheCenter alloc] init];
    }
    return _diskCacheCenter;
}

- (RCMemoryCacheDataCenter *)memoryCacheCenter
{
    if (_memoryCacheCenter == nil) {
        _memoryCacheCenter = [[RCMemoryCacheDataCenter alloc] init];
    }
    return _memoryCacheCenter;
}




@end
