//
//  NSURLRequest+RCNetworkingMethods.m
//  RCIOS-SDK
//
//  Created by gzkp on 2019/3/30.
//  Copyright © 2019年 RC. All rights reserved.
//

#import "NSURLRequest+RCNetworkingMethods.h"

static void *RCNetworkingActualRequestParams = &RCNetworkingActualRequestParams;
static void *RCNetworkingOriginRequestParams = &RCNetworkingOriginRequestParams;
static void *RCNetworkingRequestService = &RCNetworkingRequestService;


@implementation NSURLRequest (RCNetworkingMethods)

- (void)setActualRequestParams:(NSDictionary *)actualRequestParams
{
    objc_setAssociatedObject(self, RCNetworkingActualRequestParams, actualRequestParams, OBJC_ASSOCIATION_COPY);
}

- (NSDictionary *)actualRequestParams
{
    return objc_getAssociatedObject(self, RCNetworkingActualRequestParams);
}

- (void)setOriginRequestParams:(NSDictionary *)originRequestParams
{
    objc_setAssociatedObject(self, RCNetworkingOriginRequestParams, originRequestParams, OBJC_ASSOCIATION_COPY);
}

- (NSDictionary *)originRequestParams
{
    return objc_getAssociatedObject(self, RCNetworkingOriginRequestParams);
}

- (void)setService:(id <RCServiceProtocol>)service
{
    objc_setAssociatedObject(self, RCNetworkingRequestService, service, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id<RCServiceProtocol>)service
{
    return objc_getAssociatedObject(self, RCNetworkingRequestService);
}


@end
