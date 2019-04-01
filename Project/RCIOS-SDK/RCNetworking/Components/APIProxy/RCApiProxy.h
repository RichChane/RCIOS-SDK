//
//  RCApiProxy.h
//  RCIOS-SDK
//
//  Created by gzkp on 2019/3/30.
//  Copyright © 2019年 RC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCURLResponse.h"


NS_ASSUME_NONNULL_BEGIN

typedef void(^RCCallback)(RCURLResponse *response);

@interface RCApiProxy : NSObject

+ (instancetype)sharedInstance;

- (NSNumber *)callApiWithRequest:(NSURLRequest *)request success:(RCCallback)success fail:(RCCallback)fail;
- (void)cancelRequestWithRequestID:(NSNumber *)requestID;
- (void)cancelRequestWithRequestIDList:(NSArray *)requestIDList;


@end

NS_ASSUME_NONNULL_END
