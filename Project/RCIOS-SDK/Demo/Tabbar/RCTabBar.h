//
//  RCTabBar.h
//  RCIOS-SDK
//
//  Created by gzkp on 2018/12/30.
//  Copyright © 2018年 RC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


#define MAXNEWPOINT     10

#define TabBarDefault     @"TabBar_Default"
#define TabBarSeleted     @"Seleted_Default"
#define TabBarName        @"Item_Name"
@protocol TabBarDelegate;

@interface RCTabBar : UIView
{
    UIImageView *backgroundView;
    NSMutableArray *_buttons;
    UIView *newPoint[MAXNEWPOINT];
    
    CGFloat showHeight;
    
}

@property (nonatomic, assign) id<TabBarDelegate> delegate;
@property (nonatomic, retain) NSMutableArray *buttons;

@property(strong, nonatomic) UIColor *TC;         // 目前用于默认底部bar字体颜色

- (id)initWithFrame:(CGRect)frame buttonImages:(NSArray *)imageArray ShowHeight:(CGFloat)sHeight;
- (void)selectTabAtIndex:(NSInteger)index;
- (void)removeTabAtIndex:(NSInteger)index;
- (void)insertTabWithImageDic:(NSDictionary *)dict atIndex:(NSUInteger)index MaxTag:(NSUInteger)maxTag;
- (void)setBackgroundImage:(UIImage *)img;

- (void)setToNewPoint:(NSInteger)which IsHid:(BOOL)toHid;
- (void)setToNew:(NSInteger)which Numb:(NSString *)numbStr CleanAll:(BOOL)isCleanAll;

@end

@protocol TabBarDelegate <NSObject>

- (void)tabBar:(UIView *)tabBar didSelectIndex:(NSInteger)index;

- (void)addBallTag:(UIView *)item;      // 添加红的监控(移除功能)
- (void)cleanAllBall;      // 清除所有红的

@end

NS_ASSUME_NONNULL_END
