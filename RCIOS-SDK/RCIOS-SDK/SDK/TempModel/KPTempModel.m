//
//  KPDepartment.m
//  RCIOS-SDK
//
//  Created by gzkp on 2018/8/29.
//  Copyright © 2018年 RC. All rights reserved.
//

#import "KPTempModel.h"

@implementation KPDepartment

+ (NSArray *)createDepartments
{
    NSMutableArray *array = [NSMutableArray new];
    
    for (int i = 0; i < 5; i ++) {
        KPDepartment *model = [KPDepartment new];
        model.name = [NSString stringWithFormat:@"仓库%d",i];
        model.departmentId = i;
        
        [array addObject:model];
    }
    return array;
    
}


@end


@implementation PickerTempModel

+ (NSMutableDictionary *)createComponum2
{
    NSArray *firstKeyArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8"];
    NSMutableDictionary *secondDict = [NSMutableDictionary new];
    for (NSString *key in firstKeyArray) {
        [secondDict setObject:@[@"A",@"B",@"C",@"D",@"E"] forKey:key];
    }
    
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:firstKeyArray forKey:@"FirstDataKey"];
    [dict setObject:secondDict forKey:@"SecondDataKey"];
    
    return dict;
}

+ (NSMutableDictionary *)createComponum3
{
    NSArray *firstKeyArray = @[@"广东",@"北京",@"上海",@"广西"];
    NSMutableDictionary *secondDict = @{@"广东":@[@"广州",@"深圳",@"惠州",@"东莞",@"佛山"],@"广西":@[@"桂林",@"南宁",@"贺州",@"梧州",@"柳州"],@"北京":@[@"东城区",@"西城区",@"海淀区",@"朝阳区",@"天安区"],@"上海":@[@"长宁区",@"静安区",@"黄浦区",@"普陀区",@"宝山区"]}.mutableCopy;
    NSMutableDictionary *thirdDict = @{@"广东-广州":@[@"天河区",@"海珠区",@"越秀区",@"白云区",@"荔湾区",@"番禺区",@"南沙区",@"增城区",@"从化区",@"花都区"],@"广东-深圳":@[@"南山区",@"福田区",@"宝安区",@"龙岗区",@"罗湖区"],@"上海":@[@"静安区",@"黄浦区",@"尖沙咀区",@"陆家嘴区",@"外滩区",@"爱情公寓"],@"广西-桂林":@[@"相山区",@"漓江区"],@"广西-南宁":@[@"西乡塘",@"五象区",@"西大区",@"老区"]}.mutableCopy;
    
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:firstKeyArray forKey:@"FirstDataKey"];
    [dict setObject:secondDict forKey:@"SecondDataKey"];
    [dict setObject:thirdDict forKey:@"ThirdDataKey"];
    
    return dict;
    
}


@end
