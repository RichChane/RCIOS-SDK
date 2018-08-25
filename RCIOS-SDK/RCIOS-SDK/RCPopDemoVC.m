//
//  RCPopDemoVC.m
//  RCIOS-SDK
//
//  Created by gzkp on 2018/8/22.
//  Copyright © 2018年 RC. All rights reserved.
//

#import "RCPopDemoVC.h"
#import "WPNormalPopView.h"
#import "KPUpdatePopView.h"

@interface RCPopDemoVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation RCPopDemoVC
{
    NSArray *dataSourceArray;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    dataSourceArray = @[@"WPNormalPopView-0",@"WPNormalPopView-1",@"WPNormalPopView-2",@"WPNormalPopView-3",@"WPNormalPopView-4",@"KPUpdatePopView-1",@"KPEditTextPopView-1"];
    
    
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
        WPNormalPopView *popView = [[WPNormalPopView alloc]initWithTitle:@"普通弹框" content:@"普通弹框的内容不是很多也就一两行。。。。是的就一两行吧好像还差几个字？再加点吧。。。。" cancelBtnTitle:@"取消" okBtnTitle:@"确认" makeSure:^{
            
        } cancel:^{
            
        }];
        [popView showPopView];
    }else if (indexPath.row == 1){
        WPNormalPopView *popView = [[WPNormalPopView alloc]initWithTitle:@"普通弹框" content:nil cancelBtnTitle:@"取消" okBtnTitle:@"确认" makeSure:^{
            
        } cancel:^{
            
        }];
        [popView showPopView];
        
    }else if (indexPath.row == 2){
        WPNormalPopView *popView = [[WPNormalPopView alloc]initWithTitle:nil content:@"普通弹框的内容不是很多也就一两行。。。。是的就一两行吧好像还差几个字？再加点吧。。。。" cancelBtnTitle:@"取消" okBtnTitle:@"确认" makeSure:^{
            
        } cancel:^{
            
        }];
        [popView showPopView];
        
    }else if (indexPath.row == 3){
        WPNormalPopView *popView = [[WPNormalPopView alloc]initWithTitle:@"普通弹框" content:@"普通弹框的内容不是很多也就一两行。。。。是的就一两行吧好像还差几个字？再加点吧。。。。" alertTitle:@"警告内容！" cancelBtnTitle:@"取消" okBtnTitle:@"确认" makeSure:^{
            
        } cancel:^{
            
        }];
        [popView showPopView];
        
    }else if (indexPath.row == 4){
        WPNormalPopView *popView = [[WPNormalPopView alloc]initAttriWithTitle:@"多属性字符弹框" contents:@[@"普通弹框的内容不是很多也就一两行",@"。。。。",@"是的就一两行吧",@"好像还差几个字？",@"再加点吧。。。。"] colors:@[kUIColorFromRGB(0x000000),[UIColor redColor],kUIColorFromRGB(0x939395),kUIColorFromRGB(0x112233),kUIColorFromRGB(0x831829)] cancelBtnTitle:@"取消" okBtnTitle:@"确认" makeSure:^{
            
        } cancel:^{
            
        }];
        [popView showPopView];
        
    }else if (indexPath.row == 5){
        KPUpdatePopView *popView = [[KPUpdatePopView alloc]initWithTitle:nil subTitle:nil topImage:ImageName(@"boss_update_notic") content:@"【优化需求】iOS-PopView 1.0\n1，重构PopView弹窗控件\n2，目前项目中有多种PopView，继承和重用机制都不太完美\n3，本次重构目的将PopView基类做得更易于拓展，细分多种弹窗控件的模块，简化初始化接口\n4，做一个弹窗视图的文档便于开发者理解和使用" cancelBtnTitle:@"取消" okBtnTitle:@"确认" makeSure:^{
            
        } cancel:^{
            
        }];
        [popView showPopView];
        
    }else{
        WPNormalPopView *popView = [[WPNormalPopView alloc]initWithTitle:nil content:nil cancelBtnTitle:@"取消" okBtnTitle:@"确认" makeSure:^{
            
        } cancel:^{
            
        }];
        [popView showPopView];
        
    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
