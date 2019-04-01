//
//  Target_RCAppContext.m
//  RCIOS-SDK
//
//  Created by gzkp on 2019/4/1.
//  Copyright © 2019年 RC. All rights reserved.
//

#import "Target_RCAppContext.h"

@implementation Target_RCAppContext

- (BOOL)Action_isReachable:(NSDictionary *)params
{
    return YES;
}

- (BOOL)Action_shouldPrintNetworkingLog:(NSDictionary *)params
{
    return YES;
}

- (NSInteger)Action_cacheResponseCountLimit:(NSDictionary *)params
{
    return 2;
}

@end
