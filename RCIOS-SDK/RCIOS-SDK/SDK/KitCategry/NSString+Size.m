//
//  NSString+Size.m
//  kp
//
//  Created by gzkp on 2017/6/1.
//  Copyright © 2017年 kptech. All rights reserved.
//

#import "NSString+Size.h"

@implementation NSString (Size)

//返回字符串所占用的尺寸.
-(CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}


@end
