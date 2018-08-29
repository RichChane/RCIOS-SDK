//
//  UpImgDownTextBtn.m
//  kpkd
//
//  Created by gzkp on 2017/8/11.
//  Copyright © 2017年 kptech. All rights reserved.
//

#import "UpImgDownTextBtn.h"

@interface UpImgDownTextBtn()

@property (nonatomic,strong) UIImageView *showImageView;


@end

@implementation UpImgDownTextBtn

- (id)initWithFrame:(CGRect)frame image:(UIImage *)image text:(NSString *)text direction:(Direction)direction
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setTitle:text forState:UIControlStateNormal];
        [self setTitleColor:kUIColorFromRGB(0x3D4245) forState:UIControlStateNormal];
        if (SCREEN_WIDTH == 320) {
            self.titleLabel.font = FontSize(10);
        }else{
            self.titleLabel.font = FontSize(12);
        }
        
        [self setImage:image forState:UIControlStateNormal];
        [self setImage:image forState:UIControlStateHighlighted];
        self.highlighted = NO;
        _showImageView = [[UIImageView alloc]initWithImage:image];
        
        CGFloat imageWidth = self.imageView.bounds.size.width;
        CGFloat labelWidth = self.titleLabel.bounds.size.width;
        
        CGFloat imageHeight = self.imageView.bounds.size.height;
        CGFloat labelHeight = self.titleLabel.bounds.size.height;
        
        switch (direction) {
            case DireUpImage:// 在pad上图片和文字不对齐 可能是btn太大的原因？
                
                
                self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居中显示
                [self setTitleEdgeInsets:UIEdgeInsetsMake(self.imageView.frame.size.height  + 10,-self.imageView.frame.size.width, 0.0,0.0)];
                 //(self.width-self.imageView.frame.size.width)/2-(self.width-(self.imageView.frame.size.width+self.titleLabel.frame.size.width))/2;
                [self setImageEdgeInsets:UIEdgeInsetsMake(-(self.frame.size.height - self.imageView.frame.size.height)/2, 0,0.0, -self.titleLabel.frame.size.width)];
                
                
                //                self.imageEdgeInsets = UIEdgeInsetsMake(-labelHeight, 0, labelHeight, 0);
                //                self.titleEdgeInsets = UIEdgeInsetsMake(imageHeight, 0, -imageHeight, 0);
                
                break;
                
            case DireDownImage:
                
                self.imageEdgeInsets = UIEdgeInsetsMake(labelHeight, 0, -labelHeight, 0);
                self.titleEdgeInsets = UIEdgeInsetsMake(-imageHeight, 0, imageHeight, 0);
                
                break;
                
            case DireLeftImage:
                
                self.imageEdgeInsets = UIEdgeInsetsMake(0, -labelWidth, 0, labelWidth);//图片距离右边框距离减少图片的宽度，其它不边
                self.titleEdgeInsets = UIEdgeInsetsMake(0, imageWidth, 0, -imageWidth);//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
                
                break;
                
            case DireRightImage:
                
//                self.contentEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
                
                self.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth+imageWidth, 0, -labelWidth-imageWidth);
                self.titleEdgeInsets = UIEdgeInsetsMake(0, -imageWidth, 0, imageWidth);
                
                break;
            default:
                break;
        }
        
    }
    
    return self;
}

- (void)setImageShow:(BOOL)isShow
{
    if (isShow) {
        self.imageView.hidden = NO;
        [self setImage:_showImageView.image forState:UIControlStateNormal];
    }else{
        self.imageView.hidden = YES;
        //[self setImage:[CommenHelper createImageWithColor:WHITE_COLOR rect:_showImageView.frame] forState:UIControlStateNormal];
    }
    
}



@end

