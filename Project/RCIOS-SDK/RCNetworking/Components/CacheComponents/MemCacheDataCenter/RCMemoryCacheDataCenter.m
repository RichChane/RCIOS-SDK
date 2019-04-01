//
//  RCMemoryCacheDataCenter.m
//  RCIOS-SDK
//
//  Created by gzkp on 2019/4/1.
//  Copyright © 2019年 RC. All rights reserved.
//

#import "RCMemoryCacheDataCenter.h"
#import "RCMemoryCachedRecord.h"
#import "CTMediator+RCAppContext.h"

@interface RCMemoryCacheDataCenter ()

@property (nonatomic, strong) NSCache *cache;

@end

@implementation RCMemoryCacheDataCenter


#pragma mark - public method
- (RCURLResponse *)fetchCachedRecordWithKey:(NSString *)key
{
    RCURLResponse *result = nil;
    RCMemoryCachedRecord *cachedRecord = [self.cache objectForKey:key];
    if (cachedRecord != nil) {
        if (cachedRecord.isOutdated || cachedRecord.isEmpty) {
            [self.cache removeObjectForKey:key];
        } else {
            result = [[RCURLResponse alloc] initWithData:cachedRecord.content];
        }
    }
    return result;
}

- (void)saveCacheWithResponse:(RCURLResponse *)response key:(NSString *)key cacheTime:(NSTimeInterval)cacheTime
{
    RCMemoryCachedRecord *cachedRecord = [self.cache objectForKey:key];
    if (cachedRecord == nil) {
        cachedRecord = [[RCMemoryCachedRecord alloc] init];
    }
    cachedRecord.cacheTime = cacheTime;
    [cachedRecord updateContent:[NSJSONSerialization dataWithJSONObject:response.content options:0 error:NULL]];
    [self.cache setObject:cachedRecord forKey:key];
}

- (void)cleanAll
{
    [self.cache removeAllObjects];
}

#pragma mark - getters and setters
- (NSCache *)cache
{
    if (_cache == nil) {
        _cache = [[NSCache alloc] init];
        _cache.countLimit = [[CTMediator sharedInstance] RCNetworking_cacheResponseCountLimit];
    }
    return _cache;
}

@end
