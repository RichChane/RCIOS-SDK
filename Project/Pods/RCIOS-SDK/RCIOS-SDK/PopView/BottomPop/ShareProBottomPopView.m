//
//  ShareProBottomPopView.m
//  kp
//
//  Created by gzkp on 2018/6/4.
//  Copyright © 2018年 kptech. All rights reserved.
//

#import "ShareProBottomPopView.h"
#import "UpImgDownTextBtn.h"


@interface ShareProBottomPopView()

@property (nonatomic,strong) NSArray *selectArr;
@property (nonatomic,strong) NSMutableArray *selectGroupArr;
@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,strong) NSArray *textArray;
@property (nonatomic,strong) NSArray *imageArray;

@end

static const CGFloat ItemHeight = 45;
@implementation ShareProBottomPopView
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
    
    
    NSInteger sectionNum = ((_textArray.count%4)+_textArray.count)/rowNum;
    
    CGFloat selectGroupViewHeight = btn1Height*sectionNum;
    CGFloat ContentViewHeight = 190;
    UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, ContentViewHeight)];
    _contentView = contentView;
    contentView.backgroundColor = WHITE_COLOR;
    [self addSubview:contentView];
    

    _selectGroupArr = [NSMutableArray array];
    UIView *selectGroupView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, selectGroupViewHeight)];
    selectGroupView.backgroundColor = WHITE_COLOR;
    [contentView addSubview:selectGroupView];
    
    CGFloat btDis = ASIZE(105);
    CGFloat ItemWidth = 90;
    CGFloat btnOriginX = (SCREEN_WIDTH-btDis-ItemWidth*2)/2;
    
    UpImgDownTextBtn *shareBtn = [[UpImgDownTextBtn alloc]initWithFrame:CGRectMake(btnOriginX, 0, ItemWidth, btn1Height) image:_imageArray[0] text:_textArray[0] direction:DireUpImage];
    shareBtn.tag = 100;
    [shareBtn setTitleColor:GC.CBlack forState:UIControlStateNormal];
    [selectGroupView addSubview:shareBtn];
    [shareBtn addTarget:self action:@selector(clickCollectionBtnsAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UpImgDownTextBtn *saveBtn = [[UpImgDownTextBtn alloc]initWithFrame:CGRectMake(CGRectGetMaxX(shareBtn.frame)+btDis, 0, ItemWidth, btn1Height) image:_imageArray[1] text:_textArray[1] direction:DireUpImage];
    saveBtn.tag = 101;
    [saveBtn setTitleColor:GC.CBlack forState:UIControlStateNormal];
    [selectGroupView addSubview:saveBtn];
    [saveBtn addTarget:self action:@selector(clickCollectionBtnsAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(selectGroupView.frame)+10, SCREEN_WIDTH-40, ItemHeight)];
    cancelBtn.layer.cornerRadius = 4;
    cancelBtn.layer.borderColor = GC.LINE.CGColor;
    cancelBtn.layer.borderWidth = 1;
    cancelBtn.backgroundColor = WHITE_COLOR;
    [cancelBtn setTitle:ML(@"取消") forState:UIControlStateNormal];
    [cancelBtn setTitleColor:GC.CBlack forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(dismissPopView) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:cancelBtn];
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
