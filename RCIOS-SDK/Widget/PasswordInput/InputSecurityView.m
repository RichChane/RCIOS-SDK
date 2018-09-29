//
//  InputSecurityView.m
//  kp
//
//  Created by gzkp on 2018/4/11.
//  Copyright © 2018年 kptech. All rights reserved.
//

#import "InputSecurityView.h"

@interface InputSecurityView()

@property (nonatomic,strong) UIImageView *imv;
@property (nonatomic,strong) UILabel *label;
@property (nonatomic,strong) UIImage *image;

@end

@implementation InputSecurityView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImageView *imv = [[UIImageView alloc]initWithFrame:CGRectZero];
        _imv = imv;
        [self addSubview:imv];
        
        UILabel *label = [[UILabel alloc]initWithFrame:self.bounds];
        _label = label;
        label.font = FontSize(36);
        label.textColor = GC.MC;
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        
        
    }
        
    return self;
    
}

- (void)setSecurityImage:(UIImage *)image
{
    if (image) {
        _image = image;
        _imv.image = image;
    }else{
        
        CGFloat width = 12.5;
        CGFloat height = 2;
        _imv.frame = CGRectMake((self.frame.size.width-width)/2, (self.frame.size.height-height)/2, width, height);
        _imv.backgroundColor = kUIColorFromRGBAlpha(0x000000, 0.1);
    }
    
}

- (void)setText:(NSString *)text
{
    if (text && text.length) {
        _label.text = text;
        _imv.hidden = YES;
    }else{
        _label.text = @"";
        _imv.hidden = NO;
    }
    
}



@end
