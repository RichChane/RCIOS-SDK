//
//  RCTabbarController.h
//  RCIOS-SDK
//
//  Created by gzkp on 2019/1/4.
//  Copyright © 2019年 RC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RCTabBar.h"
#import "MetaBallCanvas.h"

NS_ASSUME_NONNULL_BEGIN

@interface RCTabbarController : GeneralViewController
{
    MetaBallCanvas *ballView;
    
    NSMutableArray *viewControllers;     // 导航对应 Controller
    
    NSInteger lastIndex;
    
    NSInteger animateDriect;        // 底部重复按下次数
    
    UIButton *hidSideBtn;
    
}

@property(nonatomic) NSUInteger selectIndex;  // 当前选中 Index

@property(nonatomic, readonly) UIViewController *selectedNowController;    // 当前选中 Controller
@property (nonatomic, readonly) RCTabBar *myTabBar;      // 自定义底部导航条

@property (assign, nonatomic) SEL side_Bar;

/**
 初始化 （vcs数量 = b_arr数量）
 
 @param vcs GeneralViewController 数组
 @param bArr图片数组
 @param img TabBar背景图
 @return 是否成功
 */
- (id)initWithViewControllers:(NSArray *)vcs BarImage:(NSArray *)bArr BarBgImage:(UIImage *)img;

/**
 是否隐藏导航条
 
 @param yesOrNO 是否隐藏
 @param animated 是否需要动画
 */
- (void)hidesTabBar:(BOOL)yesOrNO animated:(BOOL)animated;

/**
 删除一项导航（待测）
 
 @param index 要删除的一项
 */
- (void)removeViewControllerAtIndex:(NSUInteger)index;

- (void)removeAllController;

/**
 返回上个tabBar界面
 */
- (void)backLastIndex;

/**
 创建红点基试图
 */
- (void)bulidBallView;

@end

NS_ASSUME_NONNULL_END
