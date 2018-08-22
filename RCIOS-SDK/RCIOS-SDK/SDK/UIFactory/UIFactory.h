//
//  UIFactory.h
//  kpkd
//
//  Created by Kevin on 2018/1/11.
//  Copyright © 2018年 kptech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFactory : NSObject
+ (UILabel *)createLabelWithText:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font;

+ (UILabel *)createLabelWithText:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font maxWidth:(CGFloat)width;
+ (UILabel *)createLabelWithText:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font maxWidth:(CGFloat)width maxHeight:(CGFloat)height;

+ (UILabel *)createLabelWithText:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font lineSpace:(CGFloat)lineSpace;
+ (UILabel *)createLabelWithText:(NSString *)text textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)alignment font:(UIFont *)font lineSpace:(CGFloat)lineSpace maxWidth:(CGFloat)width;

+ (CGSize)sizeFromString:(NSString *)string maxWidth:(CGFloat)width maxHeight:(CGFloat)height font:(UIFont *)font;
+ (CGSize)sizeFromString:(NSString *)string maxWidth:(CGFloat)width maxHeight:(CGFloat)height font:(UIFont *)font lineSpace:(CGFloat)lineSpace;

+ (UIButton *)createBtnWithTitle:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(UIFont*)titleFont target:(id)target select:(SEL)function;

+ (UIButton *)createbtnWithRect:(CGRect)frame target:(id)target select:(SEL)function;
+ (UIButton *)createbtnWithImage:(UIImage *)image target:(id)target select:(SEL)function;

+ (UIView *)guideViewWith:(NSInteger)count;//小红点  count为0时 是小红点

+ (UIImageView *)createImageViewWithImageName:(NSString *)imageName;

+ (UIImageView *)createImageViewWithImageName:(NSString *)imageName tinColor:(UIColor *)color;

+ (NSString *)showMoney:(NSString *)moneyNum FloatingNumber:(int64_t)fillZero;

// 图片和数字

+ (UIView *)createViewWithImageName:(NSString *)imageName andGuideCount:(NSInteger)count;

/// 带圆角的label  可传入更多参数 borderColor 可为nil，其他的不能为nil  frame可为zero
+ (UILabel *)createLabelWithText:(NSString *)text Frame:(CGRect)frame textColor:(UIColor *)textColor font:(UIFont *)font BackGroundColor:(UIColor *)backgroundColor borderColor:(UIColor *)borderColor;
@end
