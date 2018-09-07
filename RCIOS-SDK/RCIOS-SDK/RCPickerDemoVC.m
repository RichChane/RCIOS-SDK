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
#import "STRCCommonPickerDateView.h"
#import "STPickerDate.h"

@interface RCPickerDemoVC ()<UITableViewDelegate,UITableViewDataSource,STPickerSingleDelegate,STRCCommonPickerViewDelegate,STPickerDateDelegate>

@end

@implementation RCPickerDemoVC
{
    NSArray *dataSourceArray;
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"PopView";
    
    dataSourceArray = @[@"STPickerView",@"STPickerSingle",@"STRCCommonPickerView-2",@"STRCCommonPickerView-3",@"STPickerDate-4"];
    
    
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
        pickerView.yearLeast = 2016;
        //pickerView.hiddenDay = YES;
        [pickerView show];
        [pickerView setSelectLastOne];
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
