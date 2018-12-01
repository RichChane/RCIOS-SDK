//
//  PickerPopBaseView.h
//  FMDB
//
//  Created by gzkp on 2018/12/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    PopDirectionMid,
    PopDirectionTop,
    PopDirectionBottom,
    PopDirectionLeft,
    PopDirectionRight,
} PopDirection;


@interface PickerPopBaseView : UIView


@property (nonatomic ,strong) UIView       * contentView;
@property (nonatomic ,assign) CGFloat distanceOrigin;// 设置起始弹出位置
@property (nonatomic ,assign) PopDirection popDirection;// 设置弹出方向

- (void)showInView:(UIView *)superView; // 自定义父视图
- (void)show;// 默认window为父视图


@end

NS_ASSUME_NONNULL_END
