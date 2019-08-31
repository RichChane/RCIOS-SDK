//
//  RCURLResponse.h
//  RCIOS-SDK
//
//  Created by gzkp on 2019/3/30.
//  Copyright © 2019年 RC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, RCURLResponseStatus)
{
    RCURLResponseStatusSuccess, //作为底层，请求是否成功只考虑是否成功收到服务器反馈。至于签名是否正确，返回的数据是否完整，由上层的RCAPIBaseManager来决定。
    RCURLResponseStatusErrorTimeout,
    RCURLResponseStatusErrorCancel,
    RCURLResponseStatusErrorNoNetwork // 默认除了超时以外的错误都是无网络错误。
};

@interface RCURLResponse : NSObject

@property (nonatomic, assign, readonly) RCURLResponseStatus status;
@property (nonatomic, copy, readonly) NSString *contentString;
@property (nonatomic, copy, readonly) id content;
@property (nonatomic, assign, readonly) NSInteger requestId;
@property (nonatomic, copy, readonly) NSURLRequest *request;
@property (nonatomic, copy, readonly) NSData *responseData;
@property (nonatomic, strong, readonly) NSString *errorMessage;

@property (nonatomic, copy) NSDictionary *acturlRequestParams;
@property (nonatomic, copy) NSDictionary *originRequestParams;
@property (nonatomic, strong) NSString *logString;

@property (nonatomic, assign, readonly) BOOL isCache;

- (instancetype)initWithResponseString:(NSString *)responseString requestId:(NSNumber *)requestId request:(NSURLRequest *)request responseObject:(id)responseObject error:(NSError *)error;

// 使用initWithData的response，它的isCache是YES，上面两个函数生成的response的isCache是NO
- (instancetype)initWithData:(NSData *)data;


@end

NS_ASSUME_NONNULL_END
