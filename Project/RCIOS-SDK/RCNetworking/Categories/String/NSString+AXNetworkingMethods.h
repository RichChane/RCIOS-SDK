//
//  NSString+AXNetworkingMethods.h
//  RCIOS-SDK
//
//  Created by gzkp on 2019/3/30.
//  Copyright © 2019年 RC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (AXNetworkingMethods)

- (NSString *)RC_MD5;
- (NSString *)RC_SHA1;
- (NSString *)RC_Base64Encode;

@end

NS_ASSUME_NONNULL_END
