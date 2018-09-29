//
//  NSString+Size.h
//  kp
//
//  Created by gzkp on 2017/6/1.
//  Copyright © 2017年 kptech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (Size)

//返回字符串所占用的尺寸.
-(CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;


@end
