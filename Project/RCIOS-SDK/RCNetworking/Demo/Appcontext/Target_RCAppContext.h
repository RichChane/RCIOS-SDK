//
//  Target_RCAppContext.h
//  RCIOS-SDK
//
//  Created by gzkp on 2019/4/1.
//  Copyright © 2019年 RC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Target_RCAppContext : NSObject

- (BOOL)Action_shouldPrintNetworkingLog:(NSDictionary *)params;
- (BOOL)Action_isReachable:(NSDictionary *)params;
- (NSInteger)Action_cacheResponseCountLimit:(NSDictionary *)params;

@end

NS_ASSUME_NONNULL_END
