//
//  UIFactory.m
//  kpkd
//
//  Created by Kevin on 2018/1/11.
//  Copyright © 2018年 kptech. All rights reserved.
//

#import "UIFactory.h"


@implementation UIFactory

+ (CGSize)sizeFromString:(NSString *)string maxWidth:(CGFloat)width maxHeight:(CGFloat)height font:(UIFont *)font lineSpace:(CGFloat)lineSpace
{
    if(!string||!font||!width){
        return CGSizeZero;
    }
    CGSize maxSize = CGSizeMake(width, CGFLOAT_MAX);
    if(height!=0){
        maxSize.height = height;
    }
    
    CGSize textSize = CGSizeZero;
    
    NSStringDrawingOptions opts = NSStringDrawingUsesLineFragmentOrigin |
    NSStringDrawingUsesFontLeading;
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = lineSpace;
    [style setLineBreakMode:NSLineBreakByCharWrapping];
    
    NSDictionary *attributes = @{ NSFontAttributeName : font, NSParagraphStyleAttributeName : style};
    
    CGRect rect = [string boundingRectWithSize:maxSize
                                       options:opts
                                    attributes:attributes
                                       context:nil];
    textSize = rect.size;
    return textSize;
}
+ (CGSize)sizeFromString:(NSString *)string maxWidth:(CGFloat)width maxHeight:(CGFloat)height font:(UIFont *)font
{
    return [self sizeFromString:string maxWidth:width maxHeight:height font:font lineSpace:0];
}

+ (UILabel *)createLabelWithText:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font lineSpace:(CGFloat)lineSpace
{
    return [self createLabelWithText:text textColor:textColor textAlignment:NSTextAlignmentLeft font:font lineSpace:lineSpace maxWidth:SCREEN_WIDTH-30];
}

+ (UILabel *)createLabelWithText:(NSString *)text textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)alignment font:(UIFont *)font lineSpace:(CGFloat)lineSpace maxWidth:(CGFloat)width
{
    UILabel *commonLabel = [[UILabel alloc] init];
    commonLabel.backgroundColor = [UIColor clearColor];
    commonLabel.numberOfLines= 0;
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = lineSpace;
    style.alignment = alignment;
    [style setLineBreakMode:NSLineBreakByCharWrapping];
    
    NSDictionary *attributes = @{ NSFontAttributeName : font, NSParagraphStyleAttributeName : style,NSForegroundColorAttributeName:textColor};
    CGSize stringsize = [self sizeFromString:text maxWidth:width maxHeight:0 font:font lineSpace:lineSpace];
    CGRect frame = CGRectZero;
    frame.size = stringsize;
    commonLabel.frame = frame;
    NSAttributedString * string = [[NSAttributedString alloc] initWithString:text attributes:attributes];
    commonLabel.attributedText = string;
    return commonLabel;
}

+ (UILabel *)createLabelWithText:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font
{
    UILabel * label = [UIFactory createLabelWithText:text textColor:textColor font:font maxWidth:[UIScreen mainScreen].bounds.size.width];
    return label;
}

+ (UILabel *)createLabelWithText:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font maxWidth:(CGFloat)width
{
    UILabel * label = [UIFactory createLabel:width textColor:textColor alignment:NSTextAlignmentLeft font:font lineNum:0];
    CGSize size = [UIFactory sizeFromString:text maxWidth:width maxHeight:0 font:font];
    CGRect rect = label.frame;
    rect.size = CGSizeMake(size.width, size.height?size.height:font.lineHeight);
    label.frame = rect;
    label.text = text;
    return label;
}

+ (UILabel *)createLabelWithText:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font maxWidth:(CGFloat)width maxHeight:(CGFloat)height {
    UILabel * label = [UIFactory createLabel:width textColor:textColor alignment:NSTextAlignmentLeft font:font lineNum:0];
    CGSize size = [UIFactory sizeFromString:text maxWidth:width maxHeight:height font:font];
    CGRect rect = label.frame;
    rect.size = CGSizeMake(size.width, size.height?size.height:font.lineHeight);
    label.frame = rect;
    label.text = text;
    return label;
}

+ (UILabel *)createLabel:(CGFloat)width textColor:(UIColor *)textColor alignment:(NSTextAlignment)align font:(UIFont *)textFont
{
    return [UIFactory createLabel:width textColor:textColor alignment:align font:textFont lineNum:1];
}

+ (UILabel *)createLabel:(CGFloat)width textColor:(UIColor *)textColor alignment:(NSTextAlignment)align font:(UIFont *)textFont lineNum:(NSInteger)lineNum
{
    UILabel * label = [UIFactory createCommonLabel:CGRectZero textColor:textColor backgroundColor:[UIColor clearColor] textFont:textFont text:@""];
    CGRect rect = label.frame;
    rect.size.width = width;
    rect.size.height = lineNum*textFont.lineHeight;
    label.frame = rect;
    label.numberOfLines = lineNum;
    label.textAlignment = align;
    return label;
}

//创建Label
+ (UILabel *)createCommonLabel:(CGRect)frame textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor textFont:(UIFont *)textFont text:(NSString *)text{
    UILabel *commonLabel = [[UILabel alloc] initWithFrame:frame];
    commonLabel.backgroundColor = backgroundColor;
    commonLabel.text = text;
    commonLabel.font = textFont;
    commonLabel.textColor = textColor;
    commonLabel.textAlignment = NSTextAlignmentLeft;
    return commonLabel;
}

+ (UIButton *)createBtnWithTitle:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(UIFont*)titleFont target:(id)target select:(SEL)function
{
    CGSize titleSize = [self sizeFromString:title maxWidth:SCREEN_WIDTH maxHeight:SCREEN_HEIGHT font:titleFont];
    CGRect rect = CGRectMake(0, 0, titleSize.width, titleSize.height);
    UIButton * btn = [self createbtnWithRect:rect target:target select:function];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    btn.titleLabel.font = titleFont;
    return btn;
}

+ (UIButton *)createbtnWithRect:(CGRect)frame target:(id)target select:(SEL)function
{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:function forControlEvents:UIControlEventTouchUpInside];
    btn.frame = frame;
    return btn;
}

+ (UIButton *)createbtnWithImage:(UIImage *)image target:(id)target select:(SEL)function
{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (image) {
        [btn setImage:image forState:0];
    }
    [btn addTarget:target action:function forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

+ (UIImageView *)createImageViewWithImageName:(NSString *)imageName
{
    if(!imageName||imageName.length==0){
        return nil;
    }
    UIImageView * imageView = [self createImageViewWithImageName:imageName tinColor:nil];
    return imageView;
}

+ (UIImageView *)createImageViewWithImageName:(NSString *)imageName tinColor:(UIColor *)color
{
    UIImage * image = [UIImage imageNamed:imageName];
    if(color){
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    }
    UIImageView * imageView = [[UIImageView alloc] initWithImage:image];
    if(color){
        imageView.tintColor = color;
    }
    return imageView;
}

+ (UILabel *)createLabelWithText:(NSString *)text Frame:(CGRect)frame textColor:(UIColor *)textColor font:(UIFont *)font BackGroundColor:(UIColor *)backgroundColor borderColor:(UIColor *)borderColor{
    
    UILabel *lable = [UIFactory createLabelWithText:text textColor:textColor font:font];
    if (frame.size.width) {
        
    }else {
        frame = CGRectMake(0, 0, 73, 32);
    }
    lable.frame = frame;
    lable.backgroundColor = backgroundColor;
    lable.textAlignment = NSTextAlignmentCenter;
    lable.layer.cornerRadius = frame.size.height/2;
    lable.layer.masksToBounds = YES;
    if (borderColor) {
        lable.layer.borderColor = borderColor.CGColor;
        lable.layer.borderWidth = 1;
    }
    return lable;
}

+ (M80AttributedLabel*)createAttributedLabelWithFrame:(CGRect)rect
                                            fontArray:(NSArray*)fontSizes
                                            textArray:(NSArray*)textArray
                                           colorArray:(NSArray*)colorArray
                                        numberOfLines:(NSInteger)numberOfLines
                                       backgroudColor:(UIColor*)backgroudColor
{
    
    M80AttributedLabel *attributedLabel = [[M80AttributedLabel alloc] initWithFrame:rect];
    NSInteger count = [textArray count];
    for (NSInteger i=0;i<count;i++)
    {
        UIColor *textColor =  colorArray[i];
        NSString *text = textArray[i];
        NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]initWithString:text];
        if (fontSizes.count == 1)
        {
            [attributedText setFont:fontSizes[0]];
        }
        else
        {
            [attributedText setFont:fontSizes[i]];
        }
        
        [attributedText setTextColor:textColor];
        [attributedLabel appendAttributedText:attributedText];
    }
    attributedLabel.numberOfLines = numberOfLines;
    attributedLabel.backgroundColor = backgroudColor?:[UIColor clearColor];
    return attributedLabel;
    
}


@end
