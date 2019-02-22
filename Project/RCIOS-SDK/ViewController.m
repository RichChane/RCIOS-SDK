//
//  ViewController.m
//  RCIOS-SDK
//
//  Created by gzkp on 2018/8/22.
//  Copyright © 2018年 RC. All rights reserved.
//

#import "ViewController.h"
#import "RCPopDemoVC.h"
#import "RCPickerDemoVC.h"
#import "RCCusKeyboardVC.h"
#import "RCRealmVC.h"
#import "RCLKDBHelperVC.h"
#import "RCTabbarController.h"
#import "ImageTextFactory.h"
#import "RCTableView.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>




@end

@implementation ViewController
{
    NSArray *dataSourceArray;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"SDK";
    
    dataSourceArray = @[@"PopView",@"PickerView",@"RCCusKeyboardVC",@"Realm",@"LKDBHelper",@"InnerTabbar"];
    
    
    RCTableView *tableView = [[RCTableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    
    
}


#pragma mark - UITableViewDelegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentify = @"SDK-Cell";
    

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];

    if (!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = dataSourceArray[indexPath.row];

    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataSourceArray.count;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        RCPopDemoVC *vc = [[RCPopDemoVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 1){
        
        RCPickerDemoVC *vc = [[RCPickerDemoVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 2){
        
        RCCusKeyboardVC *vc = [[RCCusKeyboardVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 3){
        
        RCRealmVC *vc = [[RCRealmVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 4){
        
        RCLKDBHelperVC *vc = [[RCLKDBHelperVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 5){
        
        GeneralViewController *vc1 = [[GeneralViewController alloc]init];
        vc1.title = @"1";
        vc1.view.backgroundColor = [UIColor yellowColor];
        GeneralViewController *vc2 = [[GeneralViewController alloc]init];
        vc2.title = @"2";
        vc2.view.backgroundColor = [UIColor purpleColor];
        GeneralViewController *vc3 = [[GeneralViewController alloc]init];
        vc3.title = @"3";
        vc3.view.backgroundColor = [UIColor redColor];
        
        UIImage *tabDefault1 = [ImageTextFactory createLeftImage:ImageName(@"rack_tabicon_normal") RightText:ML(@"货品") color:kUIColorFromRGB(0x7F7F7F)];
        UIImage *tabSelect1 = [ImageTextFactory createLeftImage:ImageName(@"rack_tabicon_selected") RightText:ML(@"货品") color:kUIColorFromRGB(0xFC9F06)];
        
        UIImage *tabDefault2 = [ImageTextFactory createLeftImage:ImageName(@"rack_tabicon_normal") RightText:ML(@"客户") color:kUIColorFromRGB(0x7F7F7F)];
        UIImage *tabSelect2 = [ImageTextFactory createLeftImage:ImageName(@"rack_tabicon_selected") RightText:ML(@"客户") color:kUIColorFromRGB(0xFC9F06)];
        
        UIImage *tabDefault3 = [ImageTextFactory createLeftImage:ImageName(@"rack_tabicon_normal") RightText:ML(@"业务员") color:kUIColorFromRGB(0x7F7F7F)];
        UIImage *tabSelect3 = [ImageTextFactory createLeftImage:ImageName(@"rack_tabicon_selected") RightText:ML(@"业务员") color:kUIColorFromRGB(0xFC9F06)];
        
     NSArray *imageArray=@[@{TabBarDefault:tabDefault1,TabBarSeleted:tabSelect1},@{TabBarDefault:tabDefault2,TabBarSeleted:tabSelect2},@{TabBarDefault:tabDefault3,TabBarSeleted:tabSelect3}];
        
        RCTabbarController *vc = [[RCTabbarController alloc]initWithViewControllers:@[vc1,vc2,vc3] BarImage:imageArray BarBgImage:@[@""]];
        
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
