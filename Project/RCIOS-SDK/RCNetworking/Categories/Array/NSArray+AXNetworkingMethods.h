//
//  NSArray+AXNetworkingMethods.h
//  RCIOS-SDK
//
//  Created by gzkp on 2019/4/1.
//  Copyright © 2019年 RC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (AXNetworkingMethods)

- (NSString *)RC_paramsString;
- (NSString *)RC_jsonString;

@end

NS_ASSUME_NONNULL_END
