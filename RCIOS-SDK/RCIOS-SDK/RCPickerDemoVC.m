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


@interface RCPickerDemoVC ()<UITableViewDelegate,UITableViewDataSource,STPickerViewDelegate>

@end

@implementation RCPickerDemoVC
{
    NSArray *dataSourceArray;
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"PopView";
    
    dataSourceArray = @[@"STPickerView",@"STPickerSingle"];
    
    
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
        STPickerSingle *pickerView = [[STPickerSingle alloc]init];
        pickerView.delegate = self;
        [pickerView setupData:@{FirstDataKey:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8"]}];
        [pickerView show];
        
    }else if (indexPath.row == 1){
        
        
        
    }else if (indexPath.row == 1){
        
        
        
    }
    
}


#pragma mark - PickerDelegate
- (void)pickerSingle:(STPickerSingle *)pickerSingle selectedTitle:(NSString *)selectedTitle selectedRow:(NSInteger)selectedRow
{
    
    
}



@end
