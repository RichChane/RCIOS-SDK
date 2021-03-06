//
//  GeneralCore.h
//  RCIOS-SDK
//
//  Created by gzkp on 2018/8/23.
//  Copyright © 2018年 RC. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "BaseData.h>
#import "BaseData.h"

// GeneralCore
#define GC          [GeneralCore getInstance]


@interface GeneralCore : NSObject

// color 通用颜色
@property(strong, nonatomic) UIColor *BG;           // 默认背景色
@property(strong, nonatomic) UIColor *LINE;         // 线条默认颜色
@property(strong, nonatomic) UIColor *MC;         // 主色调
@property(strong, nonatomic) UIColor *CWhite;         // 白色
@property(strong, nonatomic) UIColor *CBlack;         // 黑色
@property(assign, nonatomic) CGFloat tabBarHeight;
@property(assign, nonatomic) CGFloat topBarNowHeight;
@property(assign, nonatomic) CGFloat topBarNormalHeight;
@property(assign, nonatomic) CGFloat tabBarOriginalHeight;


+ (GeneralCore *)getInstance;

@end
