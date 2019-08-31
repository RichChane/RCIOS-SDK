//
//  NSURLRequest+RCNetworkingMethods.h
//  RCIOS-SDK
//
//  Created by gzkp on 2019/3/30.
//  Copyright © 2019年 RC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCServiceProtocol.h"


NS_ASSUME_NONNULL_BEGIN

@interface NSURLRequest (RCNetworkingMethods)

@property (nonatomic, copy) NSDictionary *actualRequestParams;
@property (nonatomic, copy) NSDictionary *originRequestParams;
@property (nonatomic, strong) id <RCServiceProtocol> service;

@end

NS_ASSUME_NONNULL_END
