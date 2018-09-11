//
//  STPickerDate.h
//  STPickerView
//
//  Created by https://github.com/STShenZhaoliang/STPickerView on 16/2/16.
//  Copyright © 2016年 shentian. All rights reserved.
//


/** 本 DatePicker 展示起始日期至今的日期，起始日期可自定义*/

#import "STPickerView.h"
NS_ASSUME_NONNULL_BEGIN
@class STPickerDate;
@protocol  STPickerDateDelegate<STPickerViewDelegate>
- (void)pickerDate:(STPickerDate *)pickerDate year:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;

@end
@interface STPickerDate : STPickerView

/** 1.最小的年份，default is 1900 */
@property (nonatomic, assign)NSInteger yearLeast;
/** 2.显示年份数量，default is 200 */
@property (nonatomic, assign)NSInteger yearSum;
/** 1.最小年份的月份，default is 1 */
@property (nonatomic, assign)NSInteger monthLeast;
/** 1.最小年份的日，default is 1 */
@property (nonatomic, assign)NSInteger dayLeast;



/** 3.中间选择框的高度，default is 28*/
@property (nonatomic, assign)CGFloat heightPickerComponent;

@property(nonatomic, weak)id <STPickerDateDelegate>delegate ;
/** 1.第一行 下标 */
@property (nonatomic, assign)NSInteger firIndex;
/** 2.第二行 下标 */
@property (nonatomic, assign)NSInteger secIndex;
/** 3.第三行 下标 */
@property (nonatomic, assign)NSInteger thdIndex;
/** 第三行是否显示 */
@property (nonatomic, assign)BOOL hiddenDay;


/**
 OriginTime
 
 @param time 日期选择器可选的最小时间，格式为 20180909
 */
- (void)setBeginTime:(NSString *)time;

- (void)selectYear:(NSInteger)year selectMonth:(NSInteger)month selectDay:(NSInteger)day;


@end
NS_ASSUME_NONNULL_END
