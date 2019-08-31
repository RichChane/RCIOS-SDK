//
//  RCServiceFactory.h
//  RCIOS-SDK
//
//  Created by gzkp on 2019/3/30.
//  Copyright © 2019年 RC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCServiceProtocol.h"


NS_ASSUME_NONNULL_BEGIN

@interface RCServiceFactory : NSObject

+ (instancetype)sharedInstance;

- (id <RCServiceProtocol>)serviceWithIdentifier:(NSString *)identifier;


@end

NS_ASSUME_NONNULL_END
