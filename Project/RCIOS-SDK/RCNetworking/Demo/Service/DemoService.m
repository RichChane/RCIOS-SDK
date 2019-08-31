//
//  DemoService.m
//  RCIOS-SDK
//
//  Created by gzkp on 2019/4/1.
//  Copyright © 2019年 RC. All rights reserved.
//

#import "DemoService.h"
#import <AFNetworking/AFNetworking.h>
#import "RCNetworking.h"

@interface DemoService ()

@property (nonatomic, strong) NSString *publicKey;
@property (nonatomic, strong) NSString *privateKey;
@property (nonatomic, strong) NSString *baseURL;

@property (nonatomic, strong) AFHTTPRequestSerializer *httpRequestSerializer;

@end

@implementation DemoService

#pragma mark - public methods
- (NSURLRequest *)requestWithParams:(NSDictionary *)params methodName:(NSString *)methodName requestType:(RCAPIManagerRequestType)requestType
{
    if (requestType == RCAPIManagerRequestTypeGet) {
        NSString *urlString = [NSString stringWithFormat:@"%@/%@", self.baseURL, methodName];
        NSString *tsString = [NSUUID UUID].UUIDString;
        NSString *md5Hash = [[NSString stringWithFormat:@"%@%@%@", tsString, self.privateKey, self.publicKey] RC_MD5];
        NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"GET"
                                                                           URLString:urlString
                                                                          parameters:@{
                                                                                       @"apikey":self.publicKey,
                                                                                       @"ts":tsString,
                                                                                       @"hash":md5Hash
                                                                                       }
                                                                               error:nil];
        return request;
    }
    
    return nil;
}

- (NSDictionary *)resultWithResponseObject:(id)responseObject response:(NSURLResponse *)response request:(NSURLRequest *)request error:(NSError **)error
{
    NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
    if (error || !responseObject) {
        return result;
    }
    
    if ([responseObject isKindOfClass:[NSData class]]) {
        result[kRCApiProxyValidateResultKeyResponseString] = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        result[kRCApiProxyValidateResultKeyResponseObject] = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:NULL];
    } else {
        //这里的kRCApiProxyValidateResultKeyResponseString是用作打印日志用的，实际使用时可以把实际类型的对象转换成string用于日志打印
        //        result[kRCApiProxyValidateResultKeyResponseString] = responseObject;
        result[kRCApiProxyValidateResultKeyResponseObject] = responseObject;
    }
    
    return result;
}

- (BOOL)handleCommonErrorWithResponse:(RCURLResponse *)response manager:(RCAPIBaseManager *)manager errorType:(RCAPIManagerErrorType)errorType
{
    // 业务上这些错误码表示需要重新登录
    NSString *resCode = [NSString stringWithFormat:@"%@", response.content[@"resCode"]];
    if ([resCode isEqualToString:@"00100009"]
        || [resCode isEqualToString:@"05111001"]
        || [resCode isEqualToString:@"05111002"]
        || [resCode isEqualToString:@"1080002"]
        ) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kRCUserTokenIllegalNotification
                                                            object:nil
                                                          userInfo:@{
                                                                     kRCUserTokenNotificationUserInfoKeyManagerToContinue:self
                                                                     }];
        return NO;
    }
    
    // 业务上这些错误码表示需要刷新token
    NSString *errorCode = [NSString stringWithFormat:@"%@", response.content[@"errorCode"]];
    if ([response.content[@"errorMsg"] isEqualToString:@"invalid token"]
        || [response.content[@"errorMsg"] isEqualToString:@"access_token is required"]
        || [errorCode isEqualToString:@"BL10015"]
        ) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kRCUserTokenInvalidNotification
                                                            object:nil
                                                          userInfo:@{
                                                                     kRCUserTokenNotificationUserInfoKeyManagerToContinue:self
                                                                     }];
        return NO;
    }
    
    return YES;
}

#pragma mark - getters and setters
- (NSString *)publicKey
{
    return @"d97bab99fa506c7cdf209261ffd06652";
}

- (NSString *)privateKey
{
    return @"31bb736a11cbc10271517816540e626c4ff2279a";
}

- (NSString *)baseURL
{
    if (self.apiEnvironment == RCServiceAPIEnvironmentRelease) {
        return @"https://gateway.marvel.com:443/v1";
    }
    if (self.apiEnvironment == RCServiceAPIEnvironmentDevelop) {
        return @"https://gateway.marvel.com:443/v1";
    }
    if (self.apiEnvironment == RCServiceAPIEnvironmentReleaseCandidate) {
        return @"https://gateway.marvel.com:443/v1";
    }
    return @"https://gateway.marvel.com:443/v1";
}

- (RCServiceAPIEnvironment)apiEnvironment
{
    return RCServiceAPIEnvironmentRelease;
}

- (AFHTTPRequestSerializer *)httpRequestSerializer
{
    if (_httpRequestSerializer == nil) {
        _httpRequestSerializer = [AFHTTPRequestSerializer serializer];
        [_httpRequestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    }
    return _httpRequestSerializer;
}

@end
