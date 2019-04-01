//
//  RCCacheCenter.h
//  RCIOS-SDK
//
//  Created by gzkp on 2019/4/1.
//  Copyright © 2019年 RC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCURLResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface RCCacheCenter : NSObject

+ (instancetype)sharedInstance;

- (RCURLResponse *)fetchDiskCacheWithServiceIdentifier:(NSString *)serviceIdentifier methodName:(NSString *)methodName params:(NSDictionary *)params;
- (RCURLResponse *)fetchMemoryCacheWithServiceIdentifier:(NSString *)serviceIdentifier methodName:(NSString *)methodName params:(NSDictionary *)params;

- (void)saveDiskCacheWithResponse:(RCURLResponse *)response serviceIdentifier:(NSString *)serviceIdentifier methodName:(NSString *)methodName cacheTime:(NSTimeInterval)cacheTime;
- (void)saveMemoryCacheWithResponse:(RCURLResponse *)response serviceIdentifier:(NSString *)serviceIdentifier methodName:(NSString *)methodName cacheTime:(NSTimeInterval)cacheTime;

- (void)cleanAllMemoryCache;
- (void)cleanAllDiskCache;

@end

NS_ASSUME_NONNULL_END
