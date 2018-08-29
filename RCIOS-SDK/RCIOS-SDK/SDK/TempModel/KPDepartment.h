//
//  KPDepartment.h
//  RCIOS-SDK
//
//  Created by gzkp on 2018/8/29.
//  Copyright © 2018年 RC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KPDepartment : NSObject

@property (nonatomic,strong) NSString *name;
@property (nonatomic,assign) int64_t departmentId;


+ (NSArray *)createDepartments;

@end
