//
//  CTMediator+RCAppContext.h
//  RCIOS-SDK
//
//  Created by gzkp on 2019/4/1.
//  Copyright © 2019年 RC. All rights reserved.
//

#import "CTMediator.h"
#import <AFNetworking/AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN

@interface CTMediator (RCAppContext)

- (BOOL)RCNetworking_shouldPrintNetworkingLog;
- (BOOL)RCNetworking_isReachable;
- (NSInteger)RCNetworking_cacheResponseCountLimit;

@end

NS_ASSUME_NONNULL_END
