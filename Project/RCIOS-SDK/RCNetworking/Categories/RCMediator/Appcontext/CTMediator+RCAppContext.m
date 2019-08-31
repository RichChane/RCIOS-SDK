//
//  CTMediator+RCAppContext.m
//  RCIOS-SDK
//
//  Created by gzkp on 2019/4/1.
//  Copyright © 2019年 RC. All rights reserved.
//

#import "CTMediator+RCAppContext.h"

@implementation CTMediator (RCAppContext)

- (BOOL)RCNetworking_shouldPrintNetworkingLog
{
    return [[[CTMediator sharedInstance] performTarget:@"RCAppContext" action:@"shouldPrintNetworkingLog" params:nil shouldCacheTarget:YES] boolValue];
}

- (BOOL)RCNetworking_isReachable
{
    return [[[CTMediator sharedInstance] performTarget:@"RCAppContext" action:@"isReachable" params:nil shouldCacheTarget:YES] boolValue];
}

- (NSInteger)RCNetworking_cacheResponseCountLimit
{
    return [[[CTMediator sharedInstance] performTarget:@"RCAppContext" action:@"cacheResponseCountLimit" params:nil shouldCacheTarget:YES] integerValue];
}

@end
