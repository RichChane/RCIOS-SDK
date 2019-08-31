//
//  NumbTagView.h
//  ZYYObjcLib
//
//  Created by zyyuann on 16/7/14.
//  Copyright © 2016年 ZYY. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NumbTagView;


@interface NumbTagView : UILabel

- (instancetype)initWithFrame:(CGRect)frame BackgroundColor:(UIColor *)bColor TextColor:(UIColor *)tColor;

- (void)takeNumb:(NSString *)numbStr Font:(UIFont *)font;

@end
