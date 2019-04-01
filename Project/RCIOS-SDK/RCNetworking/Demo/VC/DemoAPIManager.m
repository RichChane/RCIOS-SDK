//
//  DemoAPIManager.m
//  RCIOS-SDK
//
//  Created by gzkp on 2019/3/30.
//  Copyright © 2019年 RC. All rights reserved.
//

#import "DemoAPIManager.h"
#import "Target_DemoService.h"


@interface DemoAPIManager () <RCAPIManagerValidator, RCAPIManagerParamSource>
@end

@implementation DemoAPIManager

#pragma mark - life cycle
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.paramSource = self;
        self.validator = self;
        self.cachePolicy = self.cachePolicy | RCAPIManagerCachePolicyDisk;
    }
    return self;
}

#pragma mark - RCAPIManager
- (NSString *_Nonnull)methodName
{
    return @"public/characters";
}

- (NSString *_Nonnull)serviceIdentifier
{
    return RCNetworkingDemoServiceIdentifier;
}

- (RCAPIManagerRequestType)requestType
{
    return RCAPIManagerRequestTypeGet;
}

#pragma mark - RCAPIManagerParamSource
- (NSDictionary *)paramsForApi:(RCAPIBaseManager *)manager
{
    return @{};
    return nil;
}

#pragma mark - RCAPIManagerValidator
- (RCAPIManagerErrorType)manager:(RCAPIBaseManager *)manager isCorrectWithParamsData:(NSDictionary *)data
{
    return RCAPIManagerErrorTypeNoError;
}

- (RCAPIManagerErrorType)manager:(RCAPIBaseManager *)manager isCorrectWithCallBackData:(NSDictionary *)data
{
    return RCAPIManagerErrorTypeNoError;
}



@end
