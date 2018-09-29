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

@property(nonatomic, weak)id <STRCCommonPickerViewDelegate>delegate;
/** 1.第一行 下标 */
@property (nonatomic, assign)NSInteger firIndex;
/** 2.第二行 下标 */
@property (nonatomic, assign)NSInteger secIndex;
/** 3.第三行 下标 */
@property (nonatomic, assign)NSInteger thdIndex;

/**
 选择器选择下标
 
 @param year 第一行Index
 @param month 第二行Index
 @param day 第三行Index
 */
- (void)selectFirIndex:(NSInteger)year secIndex:(NSInteger)month thdIndex:(NSInteger)day;

@end
