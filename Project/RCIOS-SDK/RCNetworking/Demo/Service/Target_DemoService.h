//
//  Target_DemoService.h
//  RCIOS-SDK
//
//  Created by gzkp on 2019/4/1.
//  Copyright © 2019年 RC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DemoService.h"

NS_ASSUME_NONNULL_BEGIN

extern NSString * const RCNetworkingDemoServiceIdentifier;

@interface Target_DemoService : NSObject

- (DemoService *)Action_DemoService:(NSDictionary *)params;

@end

NS_ASSUME_NONNULL_END
