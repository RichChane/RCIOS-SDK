//
//  RCDemoReformer.h
//  RCIOS-SDK
//
//  Created by gzkp on 2019/4/1.
//  Copyright © 2019年 RC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCNetworkingDefines.h"

NS_ASSUME_NONNULL_BEGIN

// key
extern NSString * const kNameDemoReformerKey;
extern NSString * const kPhoneDemoReformerKey;
extern NSString * const kAddressDemoReformerKey;

// 待具体数据做具体Reformer
@interface RCDemoReformer : NSObject <RCAPIManagerDataReformer>

// 拆卸数据 --> Dict
- (id _Nullable)manager:(RCAPIBaseManager * _Nonnull)manager reformData:(NSDictionary * _Nullable)data;

@end

NS_ASSUME_NONNULL_END
