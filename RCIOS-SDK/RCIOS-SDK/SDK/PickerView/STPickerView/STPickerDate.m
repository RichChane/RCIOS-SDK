//
//  STPickerDate.m
//  STPickerView
//
//  Created by https://github.com/STShenZhaoliang/STPickerView on 16/2/16.
//  Copyright © 2016年 shentian. All rights reserved.
//

#import "STPickerDate.h"
#import "NSCalendar+ST.h"
@interface STPickerDate()<UIPickerViewDataSource, UIPickerViewDelegate>
/** 1.年 */
@property (nonatomic, assign)NSInteger year;
/** 2.月 */
@property (nonatomic, assign)NSInteger month;
/** 3.日 */
@property (nonatomic, assign)NSInteger day;

@end

@implementation STPickerDate

#pragma mark - --- init 视图初始化 ---

- (void)setupUI {
    
    self.title = ML(@"请选择日期");
    
    // 代理设置提前，防止代理方法在有数据源时重复调用
    [self.pickerView setDelegate:self];
    [self.pickerView setDataSource:self];
    
    self.componentNum = 2;
    self.littleWidth = YES;
    
    _heightPickerComponent = 28;
    
    _year  = [NSCalendar currentYear];
    _month = [NSCalendar currentMonth];
    _day   = [NSCalendar currentDay];
    _yearLeast = 2015;
    _yearSum   = _year - _yearLeast + 1;

}

- (void)setupData:(NSDictionary *)data
{
    

    
}


- (void)selectYear:(NSInteger)year selectMonth:(NSInteger)month selectDay:(NSInteger)day
{
    _year  = year;
    _month = month;
    _day   = day;

    [self.pickerView selectRow:year inComponent:0 animated:NO];
    [self.pickerView selectRow:month inComponent:1 animated:NO];
    [self.pickerView selectRow:day inComponent:2 animated:NO];

}

- (void)setSelectLastOne
{
    self.firIndex = _year - _yearLeast;
    self.secIndex = _month - 1;
    self.thdIndex = _day - 1;
    
    for (int i = 0; i < self.componentNum; i ++) {
        if (i == 0) {
            [self.pickerView selectRow:self.firIndex inComponent:0 animated:NO];
        }else if (i == 1){
            [self.pickerView selectRow:self.secIndex inComponent:1 animated:NO];
        }else if (i == 2){
            [self.pickerView selectRow:self.thdIndex inComponent:2 animated:NO];
        }
    }
    [self.pickerView reloadAllComponents];
    
    
}

#pragma mark - --- delegate 视图委托 ---
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if (self.littleWidth) {
        return self.width/3.0;
    }else{
        return self.width/self.componentNum;
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return self.componentNum;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return self.yearSum;
    }else if(component == 1) {
        return [NSCalendar getLastMonthWithSelectYear:self.firIndex + self.yearLeast];
        
    }else {
        NSInteger yearSelected = self.firIndex + self.yearLeast;
        NSInteger monthSelected = self.secIndex + 1;
        return  [NSCalendar getDaysWithYear:yearSelected month:monthSelected];
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return self.heightPickerComponent;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            if (self.firIndex != row) {
                self.firIndex = row;
                
//                [pickerView reloadComponent:1];
//                [pickerView reloadComponent:2];
            }

            break;
        case 1:
            if (self.secIndex != row) {
                self.secIndex = row;
                
                //[pickerView reloadComponent:2];
            }
            
        default:
            break;
    }
    
    [pickerView reloadAllComponents];
    [self reloadData];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view
{
    
    NSString *text;
    if (component == 0) {
        text =  [NSString stringWithFormat:@"%ld", (long)row + _yearLeast];
    }else if (component == 1){
        text =  [NSString stringWithFormat:@"%ld",(long) row + 1];
    }else{
        text = [NSString stringWithFormat:@"%ld", (long)row + 1];
    }

    UILabel *label = [[UILabel alloc]init];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setFont:[UIFont systemFontOfSize:17]];
    [label setText:text];
    return label;
}
#pragma mark - --- event response 事件相应 ---

- (void)selectedOk
{
    if ([self.delegate respondsToSelector:@selector(pickerDate:year:month:day:)]) {
         [self.delegate pickerDate:self year:self.year month:self.month day:self.day];
    }
   
    [super selectedOk];
}

- (void)remove
{
    [super remove];
    if ([self.delegate respondsToSelector:@selector(pickerViewSelectCancel:)])
    {
        [self.delegate pickerViewSelectCancel:self];
    }
    
}

#pragma mark - --- private methods 私有方法 ---

- (void)reloadData
{
    self.year  = self.firIndex + self.yearLeast;
    NSInteger selectYearLastMonth = [NSCalendar getLastMonthWithSelectYear:self.year];
    self.month = self.secIndex + 12 - selectYearLastMonth + 1;
    self.day   = self.thdIndex + 1;
}

#pragma mark - --- setters 属性 ---

- (void)setYearLeast:(NSInteger)yearLeast
{
    _yearLeast = yearLeast;
}

- (void)setYearSum:(NSInteger)yearSum
{
    _yearSum = yearSum;
}
#pragma mark - --- getters 属性 ---


@end


