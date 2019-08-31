//
//  RCPickerDemoVC.m
//  RCIOS-SDK
//
//  Created by gzkp on 2018/8/30.
//  Copyright © 2018年 RC. All rights reserved.
//

#import "RCPickerDemoVC.h"

#import "STPickerView.h"
#import "STPickerSingle.h"
#import "STRCCommonPickerView.h"
#import "STPickerDate.h"
//#import "DoubleDatePickerView.h"
#import <RCIOS-SDK/DoubleDatePickerView.h>

@interface RCPickerDemoVC ()<UITableViewDelegate,UITableViewDataSource,STPickerSingleDelegate,STRCCommonPickerViewDelegate,STPickerDateDelegate>
@property (nonatomic,strong) NSDictionary *dateSpace;
@property (nonatomic,strong) DoubleDatePickerView * datepicker;


@end

@implementation RCPickerDemoVC
{
    NSArray *dataSourceArray;
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"PopView";
    
    dataSourceArray = @[@"STPickerView",@"STPickerSingle",@"STRCCommonPickerView-2",@"STRCCommonPickerView-3",@"STPickerDate-4",@"DoubleDatePickerView-5"];
    
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    
}


#pragma mark - UITableViewDelegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentify = @"SDK-POP";
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", dataSourceArray[indexPath.row]];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataSourceArray.count;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        STPickerView *pickerView = [[STPickerView alloc]init];
        [pickerView show];
        
    }else if (indexPath.row == 1){
        
        NSDictionary *dict = [PickerTempModel createComponum2];
        STPickerSingle *pickerView = [[STPickerSingle alloc]init];
        pickerView.delegate = self;
        [pickerView setupData:dict];
        [pickerView show];
        
    }else if (indexPath.row == 2){
        
        NSMutableDictionary *dict = [PickerTempModel createComponum2];
        
        STRCCommonPickerView *pickerView = [[STRCCommonPickerView alloc]init];
        pickerView.delegate = self;
        [pickerView setupData:dict];
        pickerView.littleWidth = YES;
        [pickerView show];
        [pickerView selectFirIndex:1 secIndex:2 thdIndex:3];
    }else if (indexPath.row == 3){
        
        NSMutableDictionary *dict = [PickerTempModel createComponum3];
        
        STRCCommonPickerView *pickerView = [[STRCCommonPickerView alloc]init];
        pickerView.delegate = self;
        [pickerView setupData:dict];
        pickerView.title = @"选择地区";
        [pickerView show];
        
    }else if(indexPath.row == 4){
        STPickerDate *pickerView = [[STPickerDate alloc]init];
        pickerView.delegate = self;
        pickerView.topY = 64;
        pickerView.contentMode = STPickerContentModeTop;
        //[pickerView setBeginTime:@"20180905"];
        //pickerView.hiddenDay = YES;
        [pickerView show];
        //[pickerView setSelectLastOne];
        //[pickerView selectYear:2017 selectMonth:9 selectDay:14];
    }else if (indexPath.row == 5){
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:@[ML(@"今日"),ML(@"昨日"),ML(@"本月"),ML(@"上月"),ML(@"近三月"),ML(@"本年")] forKey:BottomBtnKey];
        DoubleDatePickerView *pickerView = [[DoubleDatePickerView alloc] initWithDateSpace:dict block:^(NSDictionary *dateSpace) {
        
            self.dateSpace = dateSpace;
            NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy/MM/dd"];
            
            NSString *startTimeInt = [dateSpace objectForKey:BeginTimer];
            NSDate * startDate = [NSDate dateWithTimeIntervalSince1970:[startTimeInt doubleValue]/1000];
            NSString * startString = [formatter stringFromDate:startDate];
            
            NSString *endTimeInt = [dateSpace objectForKey:EndTimer];
            NSDate * endDate = [NSDate dateWithTimeIntervalSince1970:[endTimeInt doubleValue]/1000];
            NSString * endString = [formatter stringFromDate:endDate];
            
            
            
            
        }];
        pickerView.distanceOrigin = 150;
        pickerView.popDirection = PopDirectionTop;
        _datepicker = pickerView;
        [pickerView show];
    }
}


#pragma mark - PickerDelegate
- (void)pickerSingle:(STPickerSingle *)pickerSingle selectedTitle:(NSString *)selectedTitle selectedRow:(NSInteger)selectedRow
{
    
    
}

- (void)pickerDate:(STPickerDate *)pickerDate year:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
{
    
    
}


@end
