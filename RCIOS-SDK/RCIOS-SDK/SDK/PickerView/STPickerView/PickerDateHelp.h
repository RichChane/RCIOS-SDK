//
//  PickerDateHelp.h
//  RCIOS-SDK
//
//  Created by gzkp on 2018/9/7.
//  Copyright © 2018年 RC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PickerDateHelp : NSObject

+ (NSInteger)getLastMonthWithSelectYear:(NSInteger)year originMonth:(NSInteger)month;

+ (NSInteger)getDaysWithYear:(NSInteger)year
                       month:(NSInteger)month
                   originDay:(NSInteger)originDay;

@end
