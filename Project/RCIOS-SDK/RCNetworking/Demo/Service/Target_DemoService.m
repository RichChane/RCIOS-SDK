//
//  Target_DemoService.m
//  RCIOS-SDK
//
//  Created by gzkp on 2019/4/1.
//  Copyright © 2019年 RC. All rights reserved.
//

#import "Target_DemoService.h"

NSString * const RCNetworkingDemoServiceIdentifier = @"DemoService";

@implementation Target_DemoService

- (DemoService *)Action_DemoService:(NSDictionary *)params
{
    return [[DemoService alloc] init];
}

@end
