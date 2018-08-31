//
//  STRCCommonPickerView.m
//  kp
//
//  Created by gzkp on 2017/6/14.
//  Copyright © 2017年 kptech. All rights reserved.
//

#import "STRCCommonPickerView.h"

@interface STRCCommonPickerView()<UIPickerViewDataSource, UIPickerViewDelegate,STRCCommonPickerViewDelegate>
/** 1.第一行 下标 */
@property (nonatomic, assign)NSInteger firIndex;
/** 2.第二行 下标 */
@property (nonatomic, assign)NSInteger secIndex;
/** 3.第三行 下标 */
@property (nonatomic, assign)NSInteger thirIndex;

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
{
    NSInteger _chooseFirstRow;
    NSInteger _chooseSecondRow;
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
    _componentNum = self.firstArr? 1:_componentNum;
    _componentNum = self.secondDict? 2:_componentNum;
    _componentNum = self.thirdDict? 3:_componentNum;
    
    [self.pickerView setDelegate:self];
    [self.pickerView setDataSource:self];
    
}

- (void)selectYear:(NSInteger)year selectMonth:(NSInteger)month selectDay:(NSInteger)day
{
    if (self.firstArr.count == 0 ) {
        return;
    }
    _chooseFirstRow = year;
    self.firIndex = year;
    self.secIndex = month;
    
    NSString *yearStr = self.firstArr[_chooseFirstRow];
    NSArray *monthArr = [_secondDict objectForKey:yearStr];
    NSString *monthStr = monthArr[month];
    
    self.firKey = yearStr;
    self.secKey = monthStr;
    
    [self.pickerView selectRow:year inComponent:0 animated:NO];
    [self.pickerView selectRow:month inComponent:1 animated:NO];
    //[self.pickerView selectRow:day inComponent:2 animated:NO];
    
}

- (void)setSelectLastOne
{
    _firIndex = [[_firstArr lastObject] integerValue];
    NSArray *monthArr = [_secondDict objectForKey:[_firstArr lastObject]];
    _secIndex = [[monthArr lastObject] integerValue];
    [self selectYear:_firstArr.count - 1 selectMonth:monthArr.count - 1  selectDay:0];
    
}

#pragma mark - --- delegate UIPickerView ---
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return self.width/3.0;
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
        
        NSString *firstComKey = self.firstArr[_chooseFirstRow];
        NSArray *secondArr = self.secondDict[firstComKey];
        return secondArr.count;
    }else if(component == 2) {
        NSString *firstComKey = self.firstArr[_chooseFirstRow];
        NSArray *monthArr = self.secondDict[firstComKey];
        NSString *secondComKey = monthArr[_chooseSecondRow];
        NSArray *thirdArray = self.thirdDict[secondComKey];
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
            
            if (_chooseFirstRow != row) {
                _chooseFirstRow = row;
                [pickerView selectRow:0 inComponent:1 animated:NO];// 滚动后刷新第二行
                [pickerView reloadComponent:1];
                
                [pickerView selectRow:0 inComponent:2 animated:NO];// 滚动后刷新第二行
                [pickerView reloadComponent:2];
                
            }

            break;
        case 1:
            if (_chooseSecondRow != row) {
                _chooseSecondRow = row;
                
                [pickerView selectRow:0 inComponent:2 animated:NO];// 滚动后刷新第二行
                [pickerView reloadComponent:2];
                
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
        NSString *currentFirstKey = _firstArr[_chooseFirstRow];
        NSArray *secondArray = _secondDict[currentFirstKey];
        if (row > secondArray.count - 1) {
            return nil;
        }
        text = secondArray[row];
    }else{
        NSString *firstComKey = self.firstArr[_chooseFirstRow];
        NSArray *monthArr = self.secondDict[firstComKey];
        NSString *secondComKey = monthArr[_chooseSecondRow];
        NSArray *thirdArray = self.thirdDict[secondComKey];
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
    if ([self.delegate respondsToSelector:@selector(pickerDate:year:month:day:)]) {
        [self.delegate pickerDate:self year:self.firIndex month:self.secIndex day:self.thirIndex];
    }else if ([self.delegate respondsToSelector:@selector(pickerDate:yearStr:monthStr:)]) {
        [self.delegate pickerDate:self yearStr:self.firKey monthStr:self.secKey];
        
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
    
    NSString *yearStr = self.firstArr[_chooseFirstRow];
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



