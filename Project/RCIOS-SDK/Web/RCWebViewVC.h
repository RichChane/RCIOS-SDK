//
//  RCWebViewVC.h
//  RCIOS-SDK
//
//  Created by gzkp on 2019/3/29.
//  Copyright © 2019年 RC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// 待完善

@interface RCWebViewVC : UIViewController

/** 是否显示Nav */
@property (nonatomic,assign) BOOL isNavHidden;

- (void)loadWebURLSring:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
