//
//  ImageTextFactory.m
//  RCIOS-SDK
//
//  Created by gzkp on 2019/1/7.
//  Copyright © 2019年 RC. All rights reserved.
//

#import "ImageTextFactory.h"

@implementation ImageTextFactory

+ (UIImage *)createLeftImage:(UIImage *)image RightText:(NSString *)text color:(UIColor *)color
{
    UILabel *label = [UILabel new];
    [label setFont:[UIFont systemFontOfSize:15]];
    [label setTextColor:color];
    label.text = text;
    [label sizeToFit];
    
    UIImageView *imv = [[UIImageView alloc]initWithImage:image];
    CGFloat itemHeight = MAX(label.height, imv.height);
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, imv.width+5+label.width, itemHeight)];
    [bgView addSubview:imv];
    [bgView addSubview:label];
    
    label.frame = CGRectMake(imv.width+5, (itemHeight-label.height)/2, label.width, label.height);
    imv.frame = CGRectMake(0, (itemHeight-imv.height)/2, imv.width, imv.height);
    
    return [self captureImageFromView:bgView];
    
}


#pragma mark - 截屏
+ (UIImage *)captureImageFromView:(UIView *)view
{
    
    UIGraphicsBeginImageContextWithOptions(view.frame.size,NO, 0);
    
    [[UIColor clearColor] setFill];
    
    [[UIBezierPath bezierPathWithRect:view.bounds] fill];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    [view.layer renderInContext:ctx];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
    
}

@end
