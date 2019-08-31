//
//  RCNetworkingDefines.h
//  RCIOS-SDK
//
//  Created by gzkp on 2019/3/30.
//  Copyright © 2019年 RC. All rights reserved.
//

#ifndef RCNetworkingDefines_h
#define RCNetworkingDefines_h

@class RCAPIBaseManager;
@class RCURLResponse;

typedef NS_ENUM (NSUInteger, RCServiceAPIEnvironment){
    RCServiceAPIEnvironmentDevelop,
    RCServiceAPIEnvironmentReleaseCandidate,
    RCServiceAPIEnvironmentRelease
};

typedef NS_ENUM (NSUInteger, RCAPIManagerRequestType){
    RCAPIManagerRequestTypePost,
    RCAPIManagerRequestTypeGet,
    RCAPIManagerRequestTypePut,
    RCAPIManagerRequestTypeDelete,
};

typedef NS_ENUM (NSUInteger, RCAPIManagerErrorType){
    RCAPIManagerErrorTypeNeedAccessToken, // 需要重新刷新accessToken
    RCAPIManagerErrorTypeNeedLogin,       // 需要登陆
    RCAPIManagerErrorTypeDefault,         // 没有产生过API请求，这个是manager的默认状态。
    RCAPIManagerErrorTypeLoginCanceled,   // 调用API需要登陆态，弹出登陆页面之后用户取消登陆了
    RCAPIManagerErrorTypeSuccess,         // API请求成功且返回数据正确，此时manager的数据是可以直接拿来使用的。
    RCAPIManagerErrorTypeNoContent,       // API请求成功但返回数据不正确。如果回调数据验证函数返回值为NO，manager的状态就会是这个。
    RCAPIManagerErrorTypeParamsError,     // 参数错误，此时manager不会调用API，因为参数验证是在调用API之前做的。
    RCAPIManagerErrorTypeTimeout,         // 请求超时。RCAPIProxy设置的是20秒超时，具体超时时间的设置请自己去看RCAPIProxy的相关代码。
    RCAPIManagerErrorTypeNoNetWork,       // 网络不通。在调用API之前会判断一下当前网络是否通畅，这个也是在调用API之前验证的，和上面超时的状态是有区别的。
    RCAPIManagerErrorTypeCanceled,        // 取消请求
    RCAPIManagerErrorTypeNoError,         // 无错误
    RCAPIManagerErrorTypeDownGrade,       // APIManager被降级了
};

typedef NS_OPTIONS(NSUInteger, RCAPIManagerCachePolicy) {
    RCAPIManagerCachePolicyNoCache = 0,
    RCAPIManagerCachePolicyMemory = 1 << 0,
    RCAPIManagerCachePolicyDisk = 1 << 1,
};

extern NSString * _Nonnull const kRCAPIBaseManagerRequestID;

// notification name
extern NSString * _Nonnull const kRCUserTokenInvalidNotification;
extern NSString * _Nonnull const kRCUserTokenIllegalNotification;
extern NSString * _Nonnull const kRCUserTokenNotificationUserInfoKeyManagerToContinue;

// result
extern NSString * _Nonnull const kRCApiProxyValidateResultKeyResponseObject;
extern NSString * _Nonnull const kRCApiProxyValidateResultKeyResponseString;
//extern NSString * _Nonnull const kRCApiProxyValidateResultKeyResponseData;

/*************************************************************************************/
@protocol RCAPIManagerDelegate <NSObject>

@required
- (NSString *_Nonnull)methodName;
- (NSString *_Nonnull)serviceIdentifier;
- (RCAPIManagerRequestType)requestType;

@optional
- (void)cleanData;
- (NSDictionary *_Nullable)reformParams:(NSDictionary *_Nullable)params;
- (NSInteger)loadDataWithParams:(NSDictionary *_Nullable)params;

@end


/*************************************************************************************/
@protocol RCAPIManagerInterceptor <NSObject>

@optional
- (BOOL)manager:(RCAPIBaseManager *_Nonnull)manager beforePerformSuccessWithResponse:(RCURLResponse *_Nonnull)response;
- (void)manager:(RCAPIBaseManager *_Nonnull)manager afterPerformSuccessWithResponse:(RCURLResponse *_Nonnull)response;

- (BOOL)manager:(RCAPIBaseManager *_Nonnull)manager beforePerformFailWithResponse:(RCURLResponse *_Nonnull)response;
- (void)manager:(RCAPIBaseManager *_Nonnull)manager afterPerformFailWithResponse:(RCURLResponse *_Nonnull)response;

- (BOOL)manager:(RCAPIBaseManager *_Nonnull)manager shouldCallAPIWithParams:(NSDictionary *_Nullable)params;
- (void)manager:(RCAPIBaseManager *_Nonnull)manager afterCallingAPIWithParams:(NSDictionary *_Nullable)params;
- (void)manager:(RCAPIBaseManager *_Nonnull)manager didReceiveResponse:(RCURLResponse *_Nullable)response;

@end

/*************************************************************************************/
@protocol RCAPIManagerCallBackDelegate <NSObject>
@required
- (void)managerCallAPIDidSuccess:(RCAPIBaseManager * _Nonnull)manager;
- (void)managerCallAPIDidFailed:(RCAPIBaseManager * _Nonnull)manager;
@end

@protocol RCPagableAPIManager <NSObject>

@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, assign, readonly) NSUInteger currentPageNumber;
@property (nonatomic, assign, readonly) BOOL isFirstPage;
@property (nonatomic, assign, readonly) BOOL isLastPage;

- (void)loadNextPage;

@end

/*************************************************************************************/

@protocol RCAPIManagerDataReformer <NSObject>
@required
- (id _Nullable)manager:(RCAPIBaseManager * _Nonnull)manager reformData:(NSDictionary * _Nullable)data;
@end

/*************************************************************************************/

@protocol RCAPIManagerValidator <NSObject>
@required
- (RCAPIManagerErrorType)manager:(RCAPIBaseManager *_Nonnull)manager isCorrectWithCallBackData:(NSDictionary *_Nullable)data;
- (RCAPIManagerErrorType)manager:(RCAPIBaseManager *_Nonnull)manager isCorrectWithParamsData:(NSDictionary *_Nullable)data;
@end

/*************************************************************************************/

@protocol RCAPIManagerParamSource <NSObject>
@required
- (NSDictionary *_Nullable)paramsForApi:(RCAPIBaseManager *_Nonnull)manager;
@end


#endif /* RCNetworkingDefines_h */
