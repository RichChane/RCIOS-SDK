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

@property (nonatomic, assign)NSInteger leastMonthNum;

@end

@implementation STPickerDate


#pragma mark - --- init 视图初始化 ---

- (void)setupUI {
    
    self.title = ML(@"请选择日期");
    
    // 代理设置提前，防止代理方法在有数据源时重复调用
    [self.pickerView setDelegate:self];
    [self.pickerView setDataSource:self];
    
    self.componentNum = 3;
    self.littleWidth = YES;
    self.leastMonthNum = 12;
    
    _heightPickerComponent = 28;
    
    _year  = [NSCalendar currentYear];
    _month = [NSCalendar currentMonth];
    _day   = [NSCalendar currentDay];
    _yearLeast = 2015;// 最小年默认2015
    _monthLeast = 1;
    _dayLeast = 1;
    _yearSum   = _year - _yearLeast + 1;// 最小年到当前年

    
}

- (void)setupData:(NSDictionary *)data
{
    

    
}

- (void)selectYear:(NSInteger)year selectMonth:(NSInteger)month selectDay:(NSInteger)day
{
    _year  = year;
    _month = month;
    _day   = day;

    self.firIndex = year - _yearLeast;
    if (self.firIndex == 0) {
        self.secIndex =  month - self.monthLeast;
    }else{
        self.secIndex = month - 1;
    }

    if (self.firIndex == 0 && self.secIndex == 0) {
        self.thdIndex = day - self.dayLeast;
    }else{
        self.thdIndex = day - 1;
    }
    
    [self.pickerView reloadAllComponents];
    [self.pickerView selectRow:self.firIndex inComponent:0 animated:NO];
    [self.pickerView selectRow:self.secIndex inComponent:1 animated:NO];
    [self.pickerView selectRow:self.thdIndex inComponent:2 animated:NO];

}

- (void)setSelectLastOne
{
    self.firIndex = _year - _yearLeast;
    self.secIndex = _month - 1;
    self.thdIndex = _day - 1;
    [self.pickerView reloadAllComponents];
    
    for (int i = 0; i < self.componentNum; i ++) {
        if (i == 0) {
            [self.pickerView selectRow:self.firIndex inComponent:0 animated:NO];
        }else if (i == 1){
            [self.pickerView selectRow:self.secIndex inComponent:1 animated:NO];
        }else if (i == 2){
            [self.pickerView selectRow:self.thdIndex inComponent:2 animated:NO];
        }
    }
    
    
    
}

- (void)setHiddenDay:(BOOL)hiddenDay
{
    if (hiddenDay) {
        self.componentNum = 2;
    }else{
        self.componentNum = 3;
    }
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
    if (component == 0) {// 年
        return self.yearSum;
    }else if(component == 1) {// 月
        if (self.firIndex == 0) {
            return self.leastMonthNum - self.monthLeast + 1;
        }else{
            return [NSCalendar getLastMonthWithSelectYear:self.firIndex + self.yearLeast];
        }

    }else {// 日
        NSInteger monthLeast = (self.firIndex == 0) ? self.monthLeast:1;
        NSInteger dayLeast = (self.firIndex == 0)&&(self.secIndex == 0) ? self.dayLeast:1;
        
        NSInteger yearSelected = self.firIndex + self.yearLeast;
        NSInteger monthSelected = self.secIndex + monthLeast;
        NSInteger days = [NSCalendar getDaysWithYear:yearSelected month:monthSelected];
        days = days - dayLeast + 1;
        return days;

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
                if (row == 0 || (row == [pickerView numberOfRowsInComponent:0] - 1)) {
                    self.secIndex = 0;
                    self.thdIndex = 0;
                    [pickerView selectRow:0 inComponent:1 animated:NO];
                    [pickerView selectRow:0 inComponent:2 animated:NO];
                }
            }

            break;
        case 1:
            if (self.secIndex != row) {
                self.secIndex = row;

                
            }
        case 2:
            if (self.thdIndex != row) {
                self.thdIndex = row;
                
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
        if (self.firIndex == 0) {
            text =  [NSString stringWithFormat:@"%ld",(long) row + self.monthLeast];
            
        }else{
            text =  [NSString stringWithFormat:@"%ld",(long) row + 1];
        }
    
    }else{
        if (self.firIndex == 0 && self.secIndex == 0) {    
            text = [NSString stringWithFormat:@"%ld", (long)row + self.dayLeast];
        }else{
            text = [NSString stringWithFormat:@"%ld", (long)row + 1];
        }
        
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
    [self reloadData];
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
    self.firIndex = [self.pickerView selectedRowInComponent:0];
    self.secIndex = [self.pickerView selectedRowInComponent:1];
    self.thdIndex = [self.pickerView selectedRowInComponent:2];
    
    self.year  = self.firIndex + self.yearLeast;
    if (self.firIndex == 0) {
        self.month = self.secIndex + self.monthLeast;
    }else{
        self.month =  self.secIndex + 1;
    }
    
    if (self.firIndex == 0 && self.secIndex == 0) {
        self.day = self.thdIndex + self.dayLeast;
    }else{
        self.day = self.thdIndex + 1;
    }
}

#pragma mark - --- setters 属性 ---

/**
 OriginTime

 @param time 日期选择器可选的最小时间，格式为 20180909
 */
- (void)setBeginTime:(NSString *)time
{
    if (time.length == 8) {
        NSInteger year = [time substringToIndex:4].integerValue;
        NSInteger month = [time substringWithRange:NSMakeRange(4, 2)].integerValue;
        NSInteger day = [time substringFromIndex:6].integerValue;
        
        [self setYearLeast:year];
        [self setMonthLeast:month];
        [self setDayLeast:day];
    }else if (time.length == 6){
        NSInteger year = [time substringToIndex:4].integerValue;
        NSInteger month = [time substringWithRange:NSMakeRange(4, 2)].integerValue;
        
        [self setYearLeast:year];
        [self setMonthLeast:month];
        
    }
    
}

- (void)setMonthLeast:(NSInteger)monthLeast
{
    _monthLeast = monthLeast;
    if (_yearLeast == _year) {
        self.leastMonthNum = [NSCalendar currentMonth];
    }else{
        self.leastMonthNum = 12;
    }
    
}

- (void)setYearLeast:(NSInteger)yearLeast
{
    _yearLeast = yearLeast;
    _yearSum   = _year - _yearLeast + 1;
    
}

- (void)setYearSum:(NSInteger)yearSum
{
    _yearSum = yearSum;
}
#pragma mark - --- getters 属性 ---


@end


