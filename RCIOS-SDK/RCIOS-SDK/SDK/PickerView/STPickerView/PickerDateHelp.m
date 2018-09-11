//
//  PickerDateHelp.m
//  RCIOS-SDK
//
//  Created by gzkp on 2018/9/7.
//  Copyright © 2018年 RC. All rights reserved.
//

#import "PickerDateHelp.h"
#import "NSCalendar+ST.h"


@implementation PickerDateHelp


+ (NSInteger)getLastMonthWithSelectYear:(NSInteger)year originMonth:(NSInteger)month
{
    if (year == [NSCalendar currentYear])
    {
        return 12 - month + 1;
    }
    else
    {
        return 12;
    }
}

+ (NSInteger)getDaysWithYear:(NSInteger)year
                       month:(NSInteger)month
                   originDay:(NSInteger)originDay
{
    NSInteger day = 0;
    
    switch (month) {
        case 1:
            day = 31;
            break;
        case 2:
            if (year%400==0 || (year%100!=0 && year%4 == 0)) {
                day = 29;
            }else{
                day = 28;
            }
            break;
        case 3:
            day = 31;
            break;
        case 4:
            day = 30;
            break;
        case 5:
            day = 31;
            break;
        case 6:
            day = 30;
            break;
        case 7:
            day = 31;
            break;
        case 8:
            day = 31;
            break;
        case 9:
            day = 30;
            break;
        case 10:
            day = 31;
            break;
        case 11:
            day = 30;
            break;
        case 12:
            day = 31;
            break;
        default:
            day = 0;
            break;
    }
    
    if (year == [NSCalendar currentYear] && month == [NSCalendar currentMonth]) {
        if (originDay) {
            day = day - originDay + 1;
        }
    }
    return day;
}


@end
