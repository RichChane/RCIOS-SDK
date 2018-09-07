//
//  STRCCommonPickerDateView.m
//  kp
//
//  Created by gzkp on 2017/7/1.
//  Copyright © 2017年 kptech. All rights reserved.
//


#import "STRCCommonPickerDateView.h"

@interface STRCCommonPickerDateView()<UIPickerViewDataSource, UIPickerViewDelegate>
/** 1.年 */
@property (nonatomic, assign)NSInteger year;
/** 2.月 */
@property (nonatomic, assign)NSInteger month;
/** 3.日 */
@property (nonatomic, assign)NSInteger day;
/* 第一行 value */
@property (nonatomic,strong) NSArray *firstArr;
/* 第二行 key为firstArr的元素 value为数组（显示在第二行） */
@property (nonatomic,strong) NSDictionary *secondDict;
/* 第三行 key为secondDict中的value value为数组（显示在第二行） */
@property (nonatomic,strong) NSDictionary *thirdDict;

@end

@implementation STRCCommonPickerDateView
{
    NSInteger _chooseYearRow;
    NSInteger _chooseMonthRow;
}

#pragma mark - --- init 视图初始化 ---
- (void)setupUI {
}

- (void)setupData:(NSDictionary *)data
{
    //self.title = ML(@"请选择行业");
    
    _heightPickerComponent = 28;
    
    self.firstArr = [data objectForKey:FirstDataKey];
    self.secondDict = [data objectForKey:SecondDataKey];
    self.thirdDict = [data objectForKey:ThirdDataKey];
    
    // 通过数据源计算行数
    self.componentNum = self.firstArr? 1:self.componentNum;
    self.componentNum = self.secondDict? 2:self.componentNum;
    self.componentNum = self.thirdDict? 3:self.componentNum;
    
    [self.pickerView setDelegate:self];
    [self.pickerView setDataSource:self];
    
}

- (void)selectFirIndex:(NSInteger)year secIndex:(NSInteger)month thdIndex:(NSInteger)day
{
    
    NSInteger yearRow = 0;
    if([_firstArr containsObject:[NSString stringWithFormat:@"%ld",(long)year]]){
        yearRow = [_firstArr indexOfObject:[NSString stringWithFormat:@"%ld",(long)year]];
    }
    _year = [[_firstArr objectAtIndex:yearRow] integerValue];
    _chooseYearRow = yearRow;
    NSArray *monthArr = _secondDict[[NSString stringWithFormat:@"%ld",(long)year]];
    
    NSInteger monthRow = 0;
    
    if([monthArr containsObject:[NSString stringWithFormat:@"%ld",(long)month]]){
        monthRow = [monthArr indexOfObject:[NSString stringWithFormat:@"%ld",(long)month]];
    }
    _month = [[monthArr objectAtIndex:monthRow] integerValue];
    _chooseMonthRow = monthRow;
    
    _day = day;
    if (self.componentNum == 3) {
        NSString * dayKey = [NSString stringWithFormat:@"%ld-%ld",year,month];
        NSArray * dayArray = _thirdDict[dayKey];
        NSInteger dayRow = [dayArray indexOfObject:[NSString stringWithFormat:@"%ld",(long)day]];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.pickerView selectRow:yearRow inComponent:0 animated:NO];
            [self.pickerView selectRow:monthRow inComponent:1 animated:NO];
            [self.pickerView selectRow:dayRow inComponent:2 animated:NO];
        });
    }else {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.pickerView selectRow:yearRow inComponent:0 animated:NO];
            [self.pickerView selectRow:monthRow inComponent:1 animated:NO];
        });
    }
    
}

- (void)setSelectLastOne
{
    _year = [[_firstArr lastObject] integerValue];
    NSArray *monthArr = [_secondDict objectForKey:[_firstArr lastObject]];
    _month = [[monthArr lastObject] integerValue];
    [self selectFirIndex:_year secIndex:_month thdIndex:0];
    
}

#pragma mark - --- delegate 视图委托 ---

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return self.componentNum;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if (self.littleWidth) {
        return self.width/3.0;
    }else{
        return self.width/self.componentNum;
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return _firstArr.count;
    }else if(component == 1) {
        if (self.firstArr.count == 0 ) {
            return 0;
        }
        
        NSString *firstComKey = self.firstArr[self.firIndex];
        NSArray *secondArr = self.secondDict[firstComKey];
        return secondArr.count;
    }else if(component == 2) {
        NSString *firstComKey = self.firstArr[self.firIndex];
        NSArray *monthArr = self.secondDict[firstComKey];
        NSString *secondComKey = monthArr[self.secIndex];
        NSArray *thirdArray = self.thirdDict[[NSString stringWithFormat:@"%@-%@",firstComKey,secondComKey]];
        return thirdArray.count;
    }else{
        return 0;
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
            _chooseYearRow = row;
            [pickerView reloadComponent:1];
            [pickerView reloadComponent:2];
            
            break;
        case 1:
            _chooseMonthRow = row;
            [pickerView reloadComponent:2];
        default:
            break;
    }
    
    [self reloadData];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view
{

    NSString *text;
    if (component == 0) {
        text =  _firstArr[row];
    }else if (component == 1){
        NSString *currentYear = _firstArr[_chooseYearRow];
        NSArray *monthArr = _secondDict[currentYear];
        if (monthArr.count <= row ) {
            text = @"";
        }else{
            text = monthArr[row];
        }

    }else if (component == 2){
        NSString *currentYear = _firstArr[_chooseYearRow];
        NSArray *monthArr = _secondDict[currentYear];
        NSString *currentMonth = monthArr[_chooseMonthRow];
        NSString *dayKey = [NSString stringWithFormat:@"%@-%@",currentYear,currentMonth];
        NSArray * dayArray =_thirdDict[dayKey];
        if (dayArray.count <= row) {
            text = @"";
        }else {
            text = dayArray[row];
        }
        
    }else{
        text = [NSString stringWithFormat:@"%ld", (long)row + 1];
    }

    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH/3, _heightPickerComponent)];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setFont:[UIFont systemFontOfSize:20]];
    [label setText:text];
    return label;
}

#pragma mark - --- event response 事件相应 ---
- (void)selectedOk
{
    if (self.firstArr.count == 0) {
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(pickerView:valueDict:)]) {
        
        NSMutableDictionary *dict = [NSMutableDictionary new];
        NSString *firstComKey = @"";
        NSString *secondComKey = @"";
        NSString *thirdComKey = @"";
        if (self.componentNum > 0) {
            firstComKey = self.firstArr[self.firIndex];
            [dict setObject:firstComKey forKey:@"1"];
        }
        if (self.componentNum > 1) {
            NSArray *monthArr = self.secondDict[firstComKey];
            secondComKey = monthArr[self.secIndex];
            [dict setObject:secondComKey forKey:@"2"];
        }
        if (self.componentNum > 2) {
            NSArray *thirdArray = self.thirdDict[[NSString stringWithFormat:@"%@-%@",firstComKey,secondComKey]];
            thirdComKey = thirdArray[self.thdIndex];
            [dict setObject:thirdComKey forKey:@"3"];
        }
        
        [self.delegate pickerView:self valueDict:dict];
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

- (void)reloadPickerView
{
    [self.pickerView reloadAllComponents];
}

#pragma mark - --- private methods 私有方法 ---

- (void)reloadData
{

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSString *yearStr = self.firstArr[_chooseYearRow];
        self.year = [yearStr integerValue];
        NSArray *monthArr = [_secondDict objectForKey:yearStr];
        NSInteger monthIndex = [self.pickerView selectedRowInComponent:1];
        if (monthIndex < monthArr.count) {
            NSString *monthStr = monthArr[monthIndex];
            self.month = [monthStr integerValue];
            
            if (self.componentNum == 3 && _thirdDict) {
                NSInteger dayIndex = [self.pickerView selectedRowInComponent:2];
                NSString * dayKey = [NSString stringWithFormat:@"%ld-%ld",self.year,self.month];
                NSArray * dayArray = [_thirdDict objectForKey:dayKey];
                if (dayIndex < dayArray.count) {
                    self.day = [dayArray[dayIndex] integerValue];
                }
            }
        }
    });
}

#pragma mark - --- setters 属性 ---


#pragma mark - --- getters 属性 ---


@end

