//
//  STRCCommonPickerView.h
//  kp
//
//  Created by gzkp on 2017/6/14.
//  Copyright © 2017年 kptech. All rights reserved.
//

#import "STPickerView.h"

@protocol  STRCCommonPickerViewDelegate<STPickerViewDelegate>
- (void)pickerDate:(STPickerView *)pickerDate year:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;
- (void)pickerDate:(STPickerView *)pickerDate yearStr:(NSString *)yearStr monthStr:(NSString *)monthStr;

@end

/**
 通用 PickerView 通过传入数据源展示
 */
@interface STRCCommonPickerView : STPickerView

/** 中间选择框的高度，default is 28*/
@property (nonatomic, assign)CGFloat heightPickerComponent;

@property(nonatomic, weak)id <STRCCommonPickerViewDelegate>delegate;


- (void)reloadPickerView;

- (void)selectYear:(NSInteger)year selectMonth:(NSInteger)month selectDay:(NSInteger)day;

- (void)setSelectLastOne;

/*
 data 格式
 FirstDataKey:firstArr
 secondDict key为firstArr的元素 value为数组（显示在第二行）
 thirdDict key为secondDict中的value value为数组（显示在第二行）
 */
- (void)setupData:(NSDictionary *)data;

@end
