//
//  NSCalendar+Util.m
//  kp
//
//  Created by gzkp on 2017/6/13.
//  Copyright © 2017年 kptech. All rights reserved.
//

#import "NSCalendar+Util.h"

@implementation NSCalendar (Util)

//一个月的首天和最后一天 时间戳
+ (NSDictionary *)getCheckTimeInMonthWithYear:(NSString *)year month:(NSString*)month
{
    return [self getMonthBeginAndEndWith:[NSString stringWithFormat:@"%@-%@",year,month]];
}

+ (NSDictionary *)getMonthBeginAndEndWith:(NSString *)dateStr{
    
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy/MM"];
    NSDate *newDate=[format dateFromString:dateStr];
    double interval = 0;
    NSDate *beginDate = nil;
    NSDate *endDate = nil;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar setFirstWeekday:2];//设定周一为周首日
    BOOL ok = [calendar rangeOfUnit:NSCalendarUnitMonth startDate:&beginDate interval:&interval forDate:newDate];
    //分别修改为 NSDayCalendarUnit NSWeekCalendarUnit NSYearCalendarUnit
    if (ok) {
        endDate = [beginDate dateByAddingTimeInterval:interval-1];
    }else {
        return nil;
    }
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    [myDateFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    double beginDouble = [beginDate timeIntervalSince1970]*1000 ;
    double endDouble = [endDate timeIntervalSince1970]*1000;

    return @{BeginTimer:@(beginDouble),EndTimer:@(endDouble)};
}

#pragma mark - 一个月 第一天的起始结束-时间戳 最后一天起始结束-时间戳

+ (NSDictionary*)getDayGapInMonthWithYear:(NSString *)year month:(NSString*)month
{
    return [self getDayGapInMonth:[NSString stringWithFormat:@"%@-%@",year,month]];
    
}

+ (NSDictionary *)getDayGapInMonth:(NSString *)dateStr{
    
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM"];
    NSDate *newDate=[format dateFromString:dateStr];
    int64_t interval = 0;
    NSDate *beginDate = nil;
    NSDate *endDate = nil;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar setFirstWeekday:2];//设定周一为周首日
    BOOL ok = [calendar rangeOfUnit:NSCalendarUnitMonth startDate:&beginDate interval:&interval forDate:newDate];
    //分别修改为 NSDayCalendarUnit NSWeekCalendarUnit NSYearCalendarUnit
    if (ok) {
        endDate = [beginDate dateByAddingTimeInterval:interval-1];
    }else {
        return nil;
    }
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    [myDateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    int64_t beginDouble = [beginDate timeIntervalSince1970]*1000;
    int64_t endDouble = [endDate timeIntervalSince1970]*1000;
    NSTimeInterval todayInterval = [[NSDate date] timeIntervalSince1970] * 1000;
    if (todayInterval < endDouble) {
        endDouble = todayInterval;
    }

    
    return @{@"FirstDay":@{@"BeginTimer":@(beginDouble),@"EndTimer":@(beginDouble + 24 * 3600 + 100)},
      @"LastDay":@{@"BeginTimer":@(endDouble),@"EndTimer":@(endDouble + 24 * 3600 + 100)}};
    
}

+ (int64_t)getSyncTime {// 3个月前时间
    NSDate *date = [NSDate date];
    
    return date.timeIntervalSince1970 - 25 * 24 * 3600 * 3;
    
}


@end
