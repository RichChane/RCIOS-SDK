//
//  RCMemoryCacheDataCenter.h
//  RCIOS-SDK
//
//  Created by gzkp on 2019/4/1.
//  Copyright © 2019年 RC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCURLResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface RCMemoryCacheDataCenter : NSObject

- (RCURLResponse *)fetchCachedRecordWithKey:(NSString *)key;
- (void)saveCacheWithResponse:(RCURLResponse *)response key:(NSString *)key cacheTime:(NSTimeInterval)cacheTime;
- (void)cleanAll;

@end

NS_ASSUME_NONNULL_END
