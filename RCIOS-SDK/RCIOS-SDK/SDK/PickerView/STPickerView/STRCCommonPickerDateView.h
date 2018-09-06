//
//  STRCCommonPickerDateView.h
//  kp
//
//  Created by gzkp on 2017/7/1.
//  Copyright © 2017年 kptech. All rights reserved.
//

#import "STPickerView.h"

@class STRCCommonPickerDateView;
/*  思来想去 由于datepickerView展示上需要个位补零与普通字符串的pickerView有些区别 为了解除耦合性 把datePickerView抽离出commomPicker  */

@protocol  STRCCommonPickerDateViewDelegate<STPickerViewDelegate>

/**
 选择器确定回调
 
 @param pickerView 选择器视图本身，公开的属性 firIndex、secIndex、thirIndex 分别是 一、二、三行的下标
 @param valueDict @{@"1":key,@"2":key,@"3":key} 分别为 一、二、三行所选的下标
 */
- (void)pickerView:(STRCCommonPickerDateView *)pickerView valueDict:(NSDictionary *)valueDict;

@end


/**
 
 专门用于date的PikerVew
 
 */
@interface STRCCommonPickerDateView : STPickerView

/** 3.中间选择框的高度，default is 28*/
@property (nonatomic, assign)CGFloat heightPickerComponent;

/** component num */
@property (nonatomic, assign)NSInteger componentNum;

@property(nonatomic, weak)id <STRCCommonPickerDateViewDelegate>delegate ;

/** 1.第一行 下标 */
@property (nonatomic, assign)NSInteger firIndex;
/** 2.第二行 下标 */
@property (nonatomic, assign)NSInteger secIndex;
/** 3.第三行 下标 */
@property (nonatomic, assign)NSInteger thdIndex;

@end
