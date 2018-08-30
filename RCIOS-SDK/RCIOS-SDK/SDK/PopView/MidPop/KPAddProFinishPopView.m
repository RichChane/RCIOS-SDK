//
//  KPAddProFinishPopView.m
//  kpkd
//
//  Created by gzkp on 2017/8/11.
//  Copyright © 2017年 kptech. All rights reserved.
//

#import "KPAddProFinishPopView.h"
#import "UpImgDownTextBtn.h"

@interface KPAddProFinishPopView()

@property (nonatomic,strong) NSArray *textArray;
@property (nonatomic,strong) NSArray *imageArray;


@end



@implementation KPAddProFinishPopView

- (instancetype)initTextArray:(NSArray*)textArray imageArray:(NSArray*)imageArray clickBtnAction:(ClickBtnAction)clickBtnAction
{
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    if (self) {
        
        
        self.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.5];
        _textArray = textArray;
        _imageArray = imageArray;
        _clickBtnAction = clickBtnAction;
        
        
        [self createContent];
        

    }
    return self;

}

static const CGFloat contentWidth = 268;
static const CGFloat contentHeight = 294;
- (void)createContent
{
    UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, contentWidth, contentHeight)];
    contentView.backgroundColor = WHITE_COLOR;
    [self addSubview:contentView];
    contentView.center = self.center;
    contentView.layer.cornerRadius = 4;
    
    CGFloat btn1Height = 100;
    UpImgDownTextBtn *btn1 = [[UpImgDownTextBtn alloc]initWithFrame:CGRectMake((contentWidth - 100)/2, 35, 100, btn1Height) image:_imageArray[0] text:_textArray[0] direction:DireUpImage];
    [contentView addSubview:btn1];
    btn1.tag = 100;
    [btn1 addTarget:self action:@selector(clickCollectionBtnsAction:) forControlEvents:UIControlEventTouchUpInside];
    btn1.titleLabel.font = FontSize(18);
    [btn1 setImageEdgeInsets:UIEdgeInsetsMake(-(btn1.frame.size.height - btn1.imageView.frame.size.height)/2, 0.0,0.0, -btn1.titleLabel.bounds.size.width)];//图片距离右边框距离减少图片的宽度，其它不边
    
    CGFloat btn1Width = (contentWidth - 20*2 - 25*2)/3;
    for (int i = 1; i < _textArray.count; i ++) {
        
        UpImgDownTextBtn *btn = [[UpImgDownTextBtn alloc]initWithFrame:CGRectMake(22 + btn1Width*(i-1) + 22*(i-1), CGRectGetMaxY(btn1.frame) + 30, btn1Width, btn1Height) image:_imageArray[i] text:_textArray[i] direction:DireUpImage];
        [contentView addSubview:btn];
        [btn addTarget:self action:@selector(clickCollectionBtnsAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 100 + i;
    }
    
    
//    UpImgDownTextBtn *btn
    

}

#pragma mark - action

-(void)showPopView{
    
    UIWindow* window = [UIApplication sharedApplication].delegate.window;
    [UIView animateWithDuration:1 animations:^{
        [window addSubview:self];
        
    }];
    
}

- (void)clickCollectionBtnsAction:(UIButton*)sender
{
    if (_clickBtnAction) {
        _clickBtnAction(sender.tag - 100);
    }
    [self dismissPopView];
    
    
}

-(void)dismissPopView{
    
    [self removeFromSuperview];
}


@end
