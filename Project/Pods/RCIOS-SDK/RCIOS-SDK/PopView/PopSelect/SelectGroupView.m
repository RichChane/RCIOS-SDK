//
//  SelectGroupView.m
//  kp
//
//  Created by gzkp on 2017/6/8.
//  Copyright © 2017年 kptech. All rights reserved.
//

#import "SelectGroupView.h"

@interface SelectGroupView()

@property (nonatomic,strong) UIImageView *coverImV;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIControl *tapControl;


@end


@implementation SelectGroupView

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _coverImV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"common_tabcheck"]];
        [self addSubview:_coverImV];
        _coverImV.frame = CGRectMake(self.frame.size.width-_coverImV.frame.size.width, self.frame.size.height-_coverImV.frame.size.height, _coverImV.frame.size.width, _coverImV.frame.size.height);
        
        _titleLabel = [[UILabel alloc]initWithFrame:self.bounds];
        _titleLabel.font = FontSize(15);
        _titleLabel.textColor = kUIColorFromRGB(0x3D4245);
        _titleLabel.text = title;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
        
        UIControl *tapControl = [[UIControl alloc]initWithFrame:self.bounds];
        _tapControl = tapControl;
        [self addSubview:tapControl];
    
        
        self.layer.borderWidth = 1;
        self.layer.cornerRadius = 4;
        
    }
    
    return self;
}

- (void)setTag:(NSInteger)tag
{
    [super setTag:tag];
    _tapControl.tag = tag;
}


- (void)setViewStatusNormal
{
    _titleLabel.textColor = kUIColorFromRGB(0x3D4245);
    _coverImV.hidden = YES;
    
    self.layer.borderColor = GC.BG.CGColor;
    self.backgroundColor = kUIColorFromRGB(0xF5F5F5);
}

- (void)setViewStatusSelected
{
    _titleLabel.textColor = GC.MC;
    _coverImV.hidden = NO;
    
    self.layer.borderColor = GC.MC.CGColor;
    self.backgroundColor = WHITE_COLOR;
}

- (void)addTarget:(id)target action:(nonnull SEL)action
{
    [_tapControl addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
