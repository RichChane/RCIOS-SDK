//
//  STRCCommonPickerView.m
//  kp
//
//  Created by gzkp on 2017/6/14.
//  Copyright © 2017年 kptech. All rights reserved.
//

#import "STRCCommonPickerView.h"

@interface STRCCommonPickerView()<UIPickerViewDataSource, UIPickerViewDelegate>

/** 1.第一行 value - string */
@property (nonatomic, strong)NSString *firKey;
/** 2.第二行 value  - string */
@property (nonatomic, strong)NSString *secKey;

/** component num */
@property (nonatomic, assign)NSInteger componentNum;

/* 第一行 value */
@property (nonatomic,strong) NSArray *firstArr;
/* 第二行 key为firstArr的元素 value为数组（显示在第二行） */
@property (nonatomic,strong) NSDictionary *secondDict;
/* 第三行 key为secondDict中的value value为数组（显示在第二行） */
@property (nonatomic,strong) NSDictionary *thirdDict;

@end

@implementation STRCCommonPickerView

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
    _componentNum = self.firstArr? 1:_componentNum;
    _componentNum = self.secondDict? 2:_componentNum;
    _componentNum = self.thirdDict? 3:_componentNum;
    
    [self.pickerView setDelegate:self];
    [self.pickerView setDataSource:self];
    
}

- (void)selectFirIndex:(NSInteger)year secIndex:(NSInteger)month thdIndex:(NSInteger)day
{
    if (self.firstArr.count == 0 ) {
        return;
    }
    
    self.firIndex = year;
    self.secIndex = month;
    
    NSString *yearStr = self.firstArr[self.firIndex];
    NSArray *monthArr = [_secondDict objectForKey:yearStr];
    NSString *monthStr = monthArr[month];
    
    self.firKey = yearStr;
    self.secKey = monthStr;
    
    for (int i = 0; i < _componentNum; i ++) {
        if (i == 0) {
            [self.pickerView selectRow:year inComponent:0 animated:NO];
        }else if (i == 1){
            [self.pickerView selectRow:month inComponent:1 animated:NO];
        }else if (i == 2){
            [self.pickerView selectRow:day inComponent:2 animated:NO];
        }
    }
}

- (void)setSelectLastOne
{
    self.firIndex = _firstArr.count - 1;
    NSArray *monthArr = [_secondDict objectForKey:[_firstArr lastObject]];
    self.secIndex = monthArr.count - 1;
    NSArray *thirdArray = [_thirdDict objectForKey:[monthArr lastObject]];
    self.thdIndex = thirdArray.count - 1;
    [self selectFirIndex:_firstArr.count - 1 secIndex:self.secIndex thdIndex:self.thdIndex];
    
}

#pragma mark - --- delegate UIPickerView ---
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if (self.littleWidth) {
        return self.width/3.0;
    }else{
        return self.width/_componentNum;
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return _componentNum;
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
            
            if (self.firIndex != row) {
                self.firIndex = row;
                self.secIndex = 0;
                
                for (NSInteger i = component+1; i < _componentNum; i ++) {
                    [pickerView selectRow:0 inComponent:i animated:NO];// 滚动后刷新子行
                    [pickerView reloadComponent:i];
                }
            }

            break;
        case 1:
            if (self.secIndex != row) {
                self.secIndex = row;
                for (NSInteger i = component+1; i < _componentNum; i ++) {
                    [pickerView selectRow:0 inComponent:i animated:NO];// 滚动后刷新子行
                    [pickerView reloadComponent:i];
                    
                }
            }
            
            break;
        case 2:
            if (self.thdIndex != row) {
                self.thdIndex = row;
                
            }
            
            break;
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
        NSString *currentFirstKey = _firstArr[self.firIndex];
        NSArray *secondArray = _secondDict[currentFirstKey];
        if (row > secondArray.count - 1) {
            return nil;
        }
        text = secondArray[row];
    }else{
        NSString *firstComKey = self.firstArr[self.firIndex];
        NSArray *monthArr = self.secondDict[firstComKey];
        NSString *secondComKey = monthArr[self.secIndex];
        NSArray *thirdArray = self.thirdDict[[NSString stringWithFormat:@"%@-%@",firstComKey,secondComKey]];
        text = thirdArray[row];
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
    if (self.firstArr.count == 0) {
        return;
    }

    if ([self.delegate respondsToSelector:@selector(pickerView:valueDict:)]) {
        
        NSMutableDictionary *dict = [NSMutableDictionary new];
        NSString *firstComKey = @"";
        NSString *secondComKey = @"";
        NSString *thirdComKey = @"";
        if (_componentNum > 0) {
            firstComKey = self.firstArr[self.firIndex];
            [dict setObject:firstComKey forKey:@"1"];
        }
        if (_componentNum > 1) {
            NSArray *monthArr = self.secondDict[firstComKey];
            secondComKey = monthArr[self.secIndex];
            [dict setObject:secondComKey forKey:@"2"];
        }
        if (_componentNum > 2) {
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
    if (self.firstArr.count == 0 ) {
        return;
    }
    
    NSString *yearStr = self.firstArr[self.firIndex];
    self.firKey = yearStr;
    
    NSArray *monthArr = [_secondDict objectForKey:yearStr];
    NSInteger monthIndex = [self.pickerView selectedRowInComponent:1];
    NSString *monthStr = monthArr[monthIndex];
    self.secKey = monthStr;
    
    self.firIndex = [self.pickerView selectedRowInComponent:0];
    self.secIndex = [self.pickerView selectedRowInComponent:1];
}

#pragma mark - --- setters 属性 ---


#pragma mark - --- getters 属性 ---


@end



