//
//  STPickerView.h
//  STPickerView
//
//  Created by https://github.com/STShenZhaoliang/STPickerView on 16/2/17.
//  Copyright © 2016年 shentian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STConfig.h"
#import <RCIOS-SDK/BaseData.h>
#import <RCIOS-SDK/GeneralCore.h>
#import "NSString+Size.h"


@class STPickerView;
@protocol  STPickerViewDelegate<NSObject>
@optional
- (void)pickerViewSelectCancel:(STPickerView * __nullable)pickerView;
@end

NS_ASSUME_NONNULL_BEGIN

#define FirstDataKey @"FirstDataKey"
#define SecondDataKey @"SecondDataKey"
#define ThirdDataKey @"ThirdDataKey"

typedef NS_ENUM(NSInteger, STPickerContentMode) {
    STPickerContentModeBottom, // 1.选择器在视图的下方
    STPickerContentModeCenter,  // 2.选择器在视图的中间
    STPickerContentModeTop  // 2.选择器在视图的顶部
};

@interface STPickerView : UIButton

/** 内容视图背景*/
@property (nonatomic,strong) UIView *contentBgView;
/** 1.内部视图 */
@property (nonatomic, strong) UIView *contentView;
/** 2.边线,选择器和上方tool之间的边线 */
@property (nonatomic, strong)UIView *lineView;
/** 3.选择器 */
@property (nonatomic, strong)UIPickerView *pickerView;
/** 4.左边的按钮 */
@property (nonatomic, strong)UIButton *buttonLeft;
/** 5.右边的按钮 */
@property (nonatomic, strong)UIButton *buttonRight;
/** 6.标题label */
@property (nonatomic, strong)UILabel *labelTitle;
/** 7.下边线,在显示模式是STPickerContentModeCenter的时候显示 */
@property (nonatomic, strong)UIView *lineViewDown;

/** 1.标题，default is nil */
@property(nullable, nonatomic,copy) NSString          *title;
/** 2.字体，default is nil (system font 17 plain) */
@property(null_resettable, nonatomic,strong) UIFont   *font;
/** 3.字体颜色，default is nil (text draws black) */
@property(null_resettable, nonatomic,strong) UIColor  *titleColor;
/** 4.按钮边框颜色颜色，default is RGB(205, 205, 205) */
@property(null_resettable, nonatomic,strong) UIColor  *borderButtonColor;
/** 5.选择器的高度，default is 240 */
@property (nonatomic, assign)CGFloat heightPicker;
/** 6.视图的显示模式 */
@property (nonatomic, assign)STPickerContentMode contentMode;

@property (nonatomic, assign)CGFloat topY;
/* 行宽大小 */
@property (nonatomic,assign) BOOL littleWidth;
/** component num, default is 3*/
@property (nonatomic, assign)NSInteger componentNum;

/**
 *  5.创建视图,初始化视图时初始数据
 */
- (void)setupUI;

/*
 data 格式
 FirstDataKey:firstArr
 secondDict key为firstArr的元素 value为数组（显示在第二行）
 thirdDict key为secondDict中的value+firstArr中的元素（格式为：value-firstArr[i]） value为数组（显示在第二行）
 */
- (void)setupData:(NSDictionary *)data;

/**
 *  6.确认按钮的点击事件
 */
- (void)selectedOk;

/**
 *  7.显示
 */
- (void)show;

- (void)showInView:(UIView *)superView;

/**
 *  8.移除
 */
- (void)remove;

/**
 选择最后一行
 */
- (void)setSelectLastOne;

@end
NS_ASSUME_NONNULL_END


