//
//  RCAPIBaseManager.h
//  RCIOS-SDK
//
//  Created by gzkp on 2019/3/30.
//  Copyright © 2019年 RC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCURLResponse.h"
#import "RCNetworkingDefines.h"

/*
* 管理所有请求
 请求发起
 请求返回
 请求缓存
 请求日志
 
 */

NS_ASSUME_NONNULL_BEGIN

@interface RCAPIBaseManager : NSObject <NSCopying>

// outter functions
@property (nonatomic, weak) id <RCAPIManagerCallBackDelegate> _Nullable delegate;
@property (nonatomic, weak) id <RCAPIManagerParamSource> _Nullable paramSource;
@property (nonatomic, weak) id <RCAPIManagerValidator> _Nullable validator;
@property (nonatomic, weak) NSObject<RCAPIManagerDelegate> * _Nullable child; //里面会调用到NSObject的方法，所以这里不用id
@property (nonatomic, weak) id <RCAPIManagerInterceptor> _Nullable interceptor;

// cache
@property (nonatomic, assign) RCAPIManagerCachePolicy cachePolicy;
@property (nonatomic, assign) NSTimeInterval memoryCacheSecond; // 默认 3 * 60
@property (nonatomic, assign) NSTimeInterval diskCacheSecond; // 默认 3 * 60
@property (nonatomic, assign) BOOL shouldIgnoreCache;  //默认NO

// response
@property (nonatomic, strong) RCURLResponse * _Nonnull response;
@property (nonatomic, readonly) RCAPIManagerErrorType errorType;
@property (nonatomic, copy, readonly) NSString * _Nullable errorMessage;

// before loading
@property (nonatomic, assign, readonly) BOOL isReachable;
@property (nonatomic, assign, readonly) BOOL isLoading;

// start
- (NSInteger)loadData;
+ (NSInteger)loadDataWithParams:(NSDictionary * _Nullable)params success:(void (^ _Nullable)(RCAPIBaseManager * _Nonnull apiManager))successCallback fail:(void (^ _Nullable)(RCAPIBaseManager * _Nonnull apiManager))failCallback;

// cancel
- (void)cancelAllRequests;
- (void)cancelRequestWithRequestId:(NSInteger)requestID;

// finish (reformer)
- (id _Nullable )fetchDataWithReformer:(id <RCAPIManagerDataReformer> _Nullable)reformer;
- (void)cleanData;


@end

@interface RCAPIBaseManager (InnerInterceptor)

- (BOOL)beforePerformSuccessWithResponse:(RCURLResponse *_Nullable)response;
- (void)afterPerformSuccessWithResponse:(RCURLResponse *_Nullable)response;

- (BOOL)beforePerformFailWithResponse:(RCURLResponse *_Nullable)response;
- (void)afterPerformFailWithResponse:(RCURLResponse *_Nullable)response;

- (BOOL)shouldCallAPIWithParams:(NSDictionary *_Nullable)params;
- (void)afterCallingAPIWithParams:(NSDictionary *_Nullable)params;

@end



NS_ASSUME_NONNULL_END

