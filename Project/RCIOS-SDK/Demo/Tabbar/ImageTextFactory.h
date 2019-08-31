//
//  ImageTextFactory.h
//  RCIOS-SDK
//
//  Created by gzkp on 2019/1/7.
//  Copyright © 2019年 RC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImageTextFactory : NSObject

+ (UIImage *)createLeftImage:(UIImage *)image RightText:(NSString *)text color:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
