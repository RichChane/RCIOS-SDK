//
//  DateFormatString.m
//  PreciousMetal
//
//  Created by Fan ao on 16/9/27.
//  Copyright © 2016年 Rich. All rights reserved.
//

#import "DateFormatString.h"

@implementation DateFormatString

/*
 时间戳 转 日期 1495061084  2016-12-12 09:08:22
 */

+(NSString*)DateToFormatStrings:(NSString*)date_st
{
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[date_st doubleValue]/1000];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    // dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    //[dateFormatter setTimeStyle:NSDateFormatterFullStyle];// 修改下面提到的北京时间的时间格式
    //[dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
    NSString *strDate = [dateFormatter stringFromDate:confromTimesp];
    return strDate;
}

+(NSString*)DateToFormatString:(NSString*)date_st
{
    
    //[date_st floatValue]
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[date_st doubleValue]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    // dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    //[dateFormatter setTimeStyle:NSDateFormatterFullStyle];// 修改下面提到的北京时间的时间格式
    //[dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
    NSString *strDate = [dateFormatter stringFromDate:confromTimesp];
    return strDate;
    
}

/* 加了换行*/
+(NSString*)DateToFormatStringhuanhang:(NSString*)date_st
{
    
    //[date_st floatValue]
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[date_st doubleValue]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd \n HH: mm:ss"];
    NSString *strDate = [dateFormatter stringFromDate:confromTimesp];
    return strDate;
    
}



+(NSString*)nianDateToFormatString:(NSString*)date_st
{
    
    //[date_st floatValue]
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[date_st doubleValue]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    NSString *strDate = [dateFormatter stringFromDate:confromTimesp];
    return strDate;
    
}

+(NSString*)hourDateToFormatString:(NSString*)date_st
{
    //[date_st floatValue]
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[date_st doubleValue]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    NSString *strDate = [dateFormatter stringFromDate:confromTimesp];
    return strDate;
    
}

+(NSString*)HMToFormatString:(NSString*)date_st
{
    //[date_st floatValue]
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[date_st doubleValue]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *strDate = [dateFormatter stringFromDate:confromTimesp];
    return strDate;
    
}

@end

