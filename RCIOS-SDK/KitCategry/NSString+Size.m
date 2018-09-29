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

    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5;// 字体的行间距
    NSDictionary *attrs = @{
                   NSFontAttributeName:font,
                   NSParagraphStyleAttributeName:paragraphStyle
                   };
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}



@end
