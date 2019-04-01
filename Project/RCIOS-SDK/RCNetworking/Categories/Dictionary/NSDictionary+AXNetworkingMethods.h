//
//  NSDictionary+AXNetworkingMethods.h
//  RCIOS-SDK
//
//  Created by gzkp on 2019/4/1.
//  Copyright © 2019年 RC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (AXNetworkingMethods)

- (NSString *)RC_jsonString;
- (NSString *)RC_transformToUrlParamString;

@end

NS_ASSUME_NONNULL_END
