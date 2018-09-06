//
//  STRCCommonPickerView.h
//  kp
//
//  Created by gzkp on 2017/6/14.
//  Copyright © 2017年 kptech. All rights reserved.
//

#import "STPickerView.h"

@class STRCCommonPickerView;
@protocol  STRCCommonPickerViewDelegate<STPickerViewDelegate>

/**
 选择器确定回调
 
 @param pickerView 选择器视图本身，公开的属性 firIndex、secIndex、thirIndex 分别是 一、二、三行的下标
 @param valueDict @{@"1":key,@"2":key,@"3":key} 分别为 一、二、三行所选的下标
 */
- (void)pickerView:(STRCCommonPickerView *)pickerView valueDict:(NSDictionary *)valueDict;


@end

/**
 通用 PickerView 通过传入数据源展示
 */
@interface STRCCommonPickerView : STPickerView

/** 中间选择框的高度，default is 28*/
@property (nonatomic, assign)CGFloat heightPickerComponent;
/* 行宽大小 */
@property (nonatomic,assign) BOOL littleWidth;
@property(nonatomic, weak)id <STRCCommonPickerViewDelegate>delegate;
/** 1.第一行 下标 */
@property (nonatomic, assign)NSInteger firIndex;
/** 2.第二行 下标 */
@property (nonatomic, assign)NSInteger secIndex;
/** 3.第三行 下标 */
@property (nonatomic, assign)NSInteger thdIndex;

- (void)reloadPickerView;

- (void)selectFirIndex:(NSInteger)year secIndex:(NSInteger)month thdIndex:(NSInteger)day;

- (void)setSelectLastOne;

/*
 data 格式
 FirstDataKey:firstArr
 secondDict key为firstArr的元素 value为数组（显示在第二行）
 thirdDict key为secondDict中的value+firstArr中的元素（格式为：value-firstArr[i]） value为数组（显示在第二行）
 */
- (void)setupData:(NSDictionary *)data;

@end
