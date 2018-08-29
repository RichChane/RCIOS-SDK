//
//  KPDepartment.m
//  RCIOS-SDK
//
//  Created by gzkp on 2018/8/29.
//  Copyright © 2018年 RC. All rights reserved.
//

#import "KPDepartment.h"

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
