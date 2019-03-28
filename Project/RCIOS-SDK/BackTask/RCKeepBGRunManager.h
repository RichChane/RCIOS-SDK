//
//  RCKeepBGRunManager.h
//  RCIOS-SDK
//
//  Created by gzkp on 2019/3/28.
//  Copyright © 2019年 RC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


/*
 1、Not Running  未运行  程序没启动
 2、Inactive      未激活 程序在前台运行，不过没有接收到事件。在没有事件处理情况下程序通常停留在这个状态
 3、Active        激活  程序在前台运行而且接收到了事件。这也是前台的一个正常的模式
 4、Backgroud 后台  程序在后台而且能执行代码，大多数程序进入这个状态后会在在这个状态上停留一会。时间到之后会进入挂起状态(Suspended)。有的程序经过特殊的请求后可以长期处于Backgroud状态
 5、Suspended 挂起  程序在后台不能执行代码。系统会自动把程序变成这个状态而且不会发出通知。当挂起时，程序还是停留在内存中的，当系统内存低时，系统就把挂起的程序清除掉，为前台程序提供更多的内存。
 
 */

@interface RCKeepBGRunManager : NSObject

+ (RCKeepBGRunManager *)shareManager;

/**
 开启后台运行
 */
- (void)startBGRun;

/**
 关闭后台运行
 */
- (void)stopBGRun;

@end

NS_ASSUME_NONNULL_END
