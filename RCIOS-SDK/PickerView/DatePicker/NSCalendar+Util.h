//
//  NSCalendar+Util.h
//  kp
//
//  Created by gzkp on 2017/6/13.
//  Copyright © 2017年 kptech. All rights reserved.
//

#import <Foundation/Foundation.h>

#define BeginTimer @"BeginTimer"
#define EndTimer @"EndTimer"
#define DateKey @"DateKey"


@interface NSCalendar (Util)

//@{@"BeginTimer":@(beginDouble),@"EndTimer":@(endDouble)}
+ (NSDictionary *)getCheckTimeInMonthWithYear:(NSString *)year month:(NSString*)month;
+ (NSDictionary *)getMonthBeginAndEndWith:(NSString *)dateStr;


//@{@"FirstDay":@{@"BeginTimer":@(beginDouble),@"EndTimer":@(beginDouble + 24 * 3600 + 100)},@"LastDay":@{@"BeginTimer":@(endDouble),@"EndTimer":@(endDouble + 24 * 3600 + 100)}}
+ (NSDictionary*)getDayGapInMonthWithYear:(NSString *)year month:(NSString*)month;
+ (NSDictionary *)getDayGapInMonth:(NSString *)dateStr;
+ (int64_t)getSyncTime;// 3个月前时间

@end
