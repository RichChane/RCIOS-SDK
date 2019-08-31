//
//  NSMutableString+AXNetworkingMethods.h
//  RCIOS-SDK
//
//  Created by gzkp on 2019/3/30.
//  Copyright © 2019年 RC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableString (AXNetworkingMethods)

- (void)appendURLRequest:(NSURLRequest *)request;

@end

NS_ASSUME_NONNULL_END
