//
//  RCLogger.h
//  RCIOS-SDK
//
//  Created by gzkp on 2019/3/30.
//  Copyright © 2019年 RC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCServiceProtocol.h"
#import "RCURLResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface RCLogger : NSObject

+ (NSString *)logDebugInfoWithRequest:(NSURLRequest *)request apiName:(NSString *)apiName service:(id <RCServiceProtocol>)service;
+ (NSString *)logDebugInfoWithResponse:(NSHTTPURLResponse *)response responseObject:(id)responseObject responseString:(NSString *)responseString request:(NSURLRequest *)request error:(NSError *)error;
+ (NSString *)logDebugInfoWithCachedResponse:(RCURLResponse *)response methodName:(NSString *)methodName service:(id <RCServiceProtocol>)service params:(NSDictionary *)params;


@end

NS_ASSUME_NONNULL_END
