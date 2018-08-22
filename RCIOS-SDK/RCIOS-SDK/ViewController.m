//
//  ViewController.m
//  RCIOS-SDK
//
//  Created by gzkp on 2018/8/22.
//  Copyright © 2018年 RC. All rights reserved.
//

#import "ViewController.h"
#import "RCPopDemoVC.h"



@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>




@end

@implementation ViewController
{
    NSArray *dataSourceArray;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    dataSourceArray = @[@"PopView"];
    
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
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
    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
