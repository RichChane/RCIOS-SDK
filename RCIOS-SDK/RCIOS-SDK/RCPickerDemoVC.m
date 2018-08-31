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

@interface RCPickerDemoVC ()<UITableViewDelegate,UITableViewDataSource,STPickerSingleDelegate,STRCCommonPickerViewDelegate>

@end

@implementation RCPickerDemoVC
{
    NSArray *dataSourceArray;
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"PopView";
    
    dataSourceArray = @[@"STPickerView",@"STPickerSingle",@"STRCCommonPickerView-2",@"STRCCommonPickerView-3"];
    
    
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
        [pickerView selectYear:1 selectMonth:2 selectDay:3];
        [pickerView show];
        
    }else if (indexPath.row == 3){
        
        NSMutableDictionary *dict = [PickerTempModel createComponum3];
        
        STRCCommonPickerView *pickerView = [[STRCCommonPickerView alloc]init];
        pickerView.delegate = self;
        [pickerView setupData:dict];
        [pickerView show];
        
    }
    
}


#pragma mark - PickerDelegate
- (void)pickerSingle:(STPickerSingle *)pickerSingle selectedTitle:(NSString *)selectedTitle selectedRow:(NSInteger)selectedRow
{
    
    
}



@end
