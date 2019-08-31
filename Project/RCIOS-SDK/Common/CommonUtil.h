//
//  CommonUtil.h
//  RCIOS-SDK
//
//  Created by gzkp on 2018/10/22.
//  Copyright © 2018年 RC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommonUtil : NSObject

+ (void )testQuickArray;
+ (void)quickSort:(NSMutableArray *)array left:(NSNumber *)left right:(NSNumber *)right;

@end

NS_ASSUME_NONNULL_END
