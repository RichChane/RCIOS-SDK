//
//  ShareBottomPopView.m
//  kp
//
//  Created by gzkp on 2017/11/8.
//  Copyright © 2017年 kptech. All rights reserved.
//

#import "ShareBottomPopView.h"
#import "UpImgDownTextBtn.h"


@interface ShareBottomPopView()

@property (nonatomic,strong) NSArray *selectArr;
@property (nonatomic,strong) NSMutableArray *selectGroupArr;
@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,strong) NSArray *textArray;
@property (nonatomic,strong) NSArray *imageArray;

@end


static const CGFloat ItemHeight = 45;

@implementation ShareBottomPopView
{
    
    NSInteger _selectIndex;
}


- (instancetype)initTextArray:(NSArray*)textArray imageArray:(NSArray*)imageArray clickBtnAction:(ClickBtnAction)clickBtnAction
{
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    if (self) {
        
        
        _selectArr = ShareArray;
        _textArray = textArray;
        _imageArray = imageArray;
        _clickBtnAction = clickBtnAction;
        
        [self createContentView];
        
    }
    return self;
    
}


- (void)createContentView
{
    UIControl *tapControl = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [tapControl addTarget:self action:@selector(dismissPopView) forControlEvents:UIControlEventTouchUpInside];
    tapControl.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.5];
    [self addSubview:tapControl];
    
    CGFloat btn1Height = 100;//每个btn高度
    NSInteger rowNum = 4;//一行几个icon
    CGFloat mid_distance = 10;
    CGFloat btn1Width = (SCREEN_WIDTH - dis_LEFTSCREEN*2 - mid_distance*(rowNum - 1))/4;//每个btn宽度
    
    NSInteger sectionNum = ((_textArray.count%4)+_textArray.count)/rowNum;
    
    CGFloat selectGroupViewHeight = btn1Height*sectionNum;
    CGFloat ContentViewHeight = selectGroupViewHeight + ItemHeight;
    UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, ContentViewHeight)];
    _contentView = contentView;
    contentView.backgroundColor = CLEAR_COLOR;
    [self addSubview:contentView];
    
    
    UIButton *cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, selectGroupViewHeight, SCREEN_WIDTH, ItemHeight)];
    cancelBtn.backgroundColor = WHITE_COLOR;
    [cancelBtn setTitle:ML(@"取消") forState:UIControlStateNormal];
    [cancelBtn setTitleColor:GC.CBlack forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(dismissPopView) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:cancelBtn];
    
    
    _selectGroupArr = [NSMutableArray array];
    UIView *selectGroupView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, selectGroupViewHeight)];
    selectGroupView.backgroundColor = WHITE_COLOR;
    [contentView addSubview:selectGroupView];
    //[GeneralUIUse AddLineDown:selectGroupView Color:kUIColorFromRGB(0xE3ECF5) LeftOri:0 RightOri:0];
    for (int i = 0; i < _textArray.count ; i ++) {
        
        UpImgDownTextBtn *btn = [[UpImgDownTextBtn alloc]initWithFrame:CGRectMake(dis_LEFTSCREEN + btn1Width*i + mid_distance*i, 0, btn1Width, btn1Height) image:_imageArray[i] text:_textArray[i] direction:DireUpImage];
        [selectGroupView addSubview:btn];
        [btn addTarget:self action:@selector(clickCollectionBtnsAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 100 + i;
    }
    
}

- (void)clickCollectionBtnsAction:(UIButton*)sender
{
    if (_clickBtnAction) {
        _clickBtnAction(sender.tag - 100);
    }
    [self dismissPopView];
    
}

#pragma mark - action
-(void)showPopView{
    @RCWeak(self)
    UIWindow* window = [UIApplication sharedApplication].delegate.window;
    [UIView animateWithDuration:0.3 animations:^{
        @RCStrong(self)
        [window addSubview:self];
        self.contentView.frame = CGRectMake(0, SCREEN_HEIGHT - self.contentView.frame.size.height, SCREEN_WIDTH, self.contentView.frame.size.height);
        
    }];
    
}

-(void)dismissPopView{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    @RCWeak(self)
    [UIView animateWithDuration:0.3 animations:^{
        @RCStrong(self)
        self.contentView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, self.contentView.frame.size.height);
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
    }];
    
}

@end
