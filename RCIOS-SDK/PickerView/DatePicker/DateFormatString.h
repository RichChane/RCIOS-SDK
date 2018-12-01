//
//  DateFormatString.h
//  PreciousMetal
//
//  Created by Fan ao on 16/9/27.
//  Copyright © 2016年 Rich. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateFormatString : NSObject

+(NSString*)DateToFormatStrings:(NSString*)date_st;
+(NSString*)DateToFormatString:(NSString*)date_st;
+(NSString*)hourDateToFormatString:(NSString*)date_st;
+(NSString*)nianDateToFormatString:(NSString*)date_st;
+(NSString*)HMToFormatString:(NSString*)date_st;

+(NSString*)DateToFormatStringhuanhang:(NSString*)date_st;
@end

