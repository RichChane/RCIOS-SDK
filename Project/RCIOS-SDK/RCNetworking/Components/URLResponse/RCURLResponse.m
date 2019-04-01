//
//  RCURLResponse.m
//  RCIOS-SDK
//
//  Created by gzkp on 2019/3/30.
//  Copyright © 2019年 RC. All rights reserved.
//

#import "RCURLResponse.h"
#import "NSObject+AXNetworkingMethods.h"
#import "NSURLRequest+RCNetworkingMethods.h"

@interface RCURLResponse ()

@property (nonatomic, assign, readwrite) RCURLResponseStatus status;
@property (nonatomic, copy, readwrite) NSString *contentString;
@property (nonatomic, copy, readwrite) id content;
@property (nonatomic, copy, readwrite) NSURLRequest *request;
@property (nonatomic, assign, readwrite) NSInteger requestId;
@property (nonatomic, copy, readwrite) NSData *responseData;
@property (nonatomic, assign, readwrite) BOOL isCache;
@property (nonatomic, strong, readwrite) NSString *errorMessage;

@end


@implementation RCURLResponse

#pragma mark - life cycle
- (instancetype)initWithResponseString:(NSString *)responseString requestId:(NSNumber *)requestId request:(NSURLRequest *)request responseObject:(NSDictionary *)responseObject error:(NSError *)error
{
    self = [super init];
    if (self) {
        self.contentString = [responseString RC_defaultValue:@""];
        self.requestId = [requestId integerValue];
        self.request = request;
        self.acturlRequestParams = request.actualRequestParams;
        self.originRequestParams = request.originRequestParams;
        self.isCache = NO;
        self.status = [self responseStatusWithError:error];
        self.content = responseObject ? responseObject : @{};
        self.errorMessage = [NSString stringWithFormat:@"%@", error];
    }
    return self;
}

- (instancetype)initWithData:(NSData *)data
{
    self = [super init];
    if (self) {
        self.contentString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        self.status = [self responseStatusWithError:nil];
        self.requestId = 0;
        self.request = nil;
        self.responseData = data;
        self.content = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:NULL];
        self.isCache = YES;
    }
    return self;
}

#pragma mark - private methods
- (RCURLResponseStatus)responseStatusWithError:(NSError *)error
{
    if (error) {
        RCURLResponseStatus result = RCURLResponseStatusErrorNoNetwork;
        
        // 除了超时以外，所有错误都当成是无网络
        if (error.code == NSURLErrorTimedOut) {
            result = RCURLResponseStatusErrorTimeout;
        }
        if (error.code == NSURLErrorCancelled) {
            result = RCURLResponseStatusErrorCancel;
        }
        if (error.code == NSURLErrorNotConnectedToInternet) {
            result = RCURLResponseStatusErrorNoNetwork;
        }
        return result;
    } else {
        return RCURLResponseStatusSuccess;
    }
}

#pragma mark - getters and setters
- (NSData *)responseData
{
    if (_responseData == nil) {
        NSError *error = nil;
        _responseData = [NSJSONSerialization dataWithJSONObject:self.content options:0 error:&error];
        if (error) {
            _responseData = [@"" dataUsingEncoding:NSUTF8StringEncoding];
        }
    }
    return _responseData;
}



@end
