//
//  PopBaseView.m
//  RCIOS-SDK
//
//  Created by gzkp on 2018/8/22.
//  Copyright © 2018年 RC. All rights reserved.
//

#import "PopBaseView.h"
#import "YYKeyboardManager.h"


@interface PopBaseView()

@property (nonatomic,strong) UIView *centerView;
@property (nonatomic,strong) UIView *bottomLine;
@property (nonatomic,strong) UIView *bottomMidLine;

@end

@implementation PopBaseView
{
    NSString *_title;
    
    NSString *_cancelTitle;
    NSString *_okBtnTitle;
    CGFloat _contentWidth;
    CGFloat _contentHeight;
}


- (instancetype)initWithCancelBtnTitle:(NSString*)cancelBtnTitle okBtnTitle:(NSString*)okBtnTitle
{
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.5];
        
        _cancelTitle = cancelBtnTitle;
        _okBtnTitle = okBtnTitle;
        
        self.topView = [UIView new];
        self.contentView = [UIView new];
        [self createCenterView];
#warning Add LandScapeNotice
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapScrollView)];
        tap.cancelsTouchesInView = NO;
        [self addGestureRecognizer:tap];
        
    }
    return self;
}

- (void)createCenterView
{
    _centerView = [[UIView alloc]initWithFrame:CGRectZero];
    _centerView.backgroundColor = [UIColor whiteColor];
    _centerView.layer.cornerRadius = 7;
    _centerView.clipsToBounds = YES;
    [self addSubview:_centerView];
    
    UIButton *cancelBtn = [[UIButton alloc]init];
    _cancelBtn = cancelBtn;
    [cancelBtn addTarget:self action:@selector(clickCancleBtn:) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setTitle:_cancelTitle forState:UIControlStateNormal];
    [cancelBtn setTitleColor:kUIColorFromRGB(0x888888) forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = FontSize(16);
    [_centerView addSubview:cancelBtn];
    
    UIButton *okBtn = [[UIButton alloc]init];
    _okBtn = okBtn;
    [okBtn addTarget:self action:@selector(clickSureBtn:) forControlEvents:UIControlEventTouchUpInside];
    [okBtn setTitle:_okBtnTitle forState:UIControlStateNormal];
    [okBtn setTitleColor:kUIColorFromRGB(0xFC9F06) forState:UIControlStateNormal];
    okBtn.titleLabel.font = FontSize(16);
    okBtn.backgroundColor = nil;
    [_centerView addSubview:okBtn];
    
    UIView *line = [UIView new];
    line.backgroundColor = GC.LINE;
    _bottomLine = line;
    [_centerView addSubview:line];
    
    _bottomMidLine = [UIView new];
    _bottomMidLine.backgroundColor = GC.LINE;
    [_centerView addSubview:_bottomMidLine];
    
}

#define BottomBtnHeight 45
- (void)refreshCenterView:(UIView *)topView contentView:(UIView *)contentView
{
    CGFloat originY = 0.0;
    if (topView && topView.frame.size.height) {
        topView.frame = CGRectMake(0, originY, topView.frame.size.width, topView.frame.size.height);
        [_centerView addSubview:topView];
        
        originY = CGRectGetMaxY(topView.frame);
    }
    if (contentView && contentView.frame.size.height) {
        contentView.frame = CGRectMake(0, originY, contentView.frame.size.width, contentView.frame.size.height);
        [_centerView addSubview:contentView];
        
        originY = CGRectGetMaxY(contentView.frame);
    }
    
    _bottomLine.frame = CGRectMake(0, originY, contentView.frame.size.width, 0.5);
    _bottomMidLine.frame = CGRectMake(contentView.frame.size.width/2, originY, 0.5, BottomBtnHeight);
    
    if (_cancelTitle && ![_cancelTitle isEqualToString:@""]){
        _cancelBtn.frame = CGRectMake(0, originY, contentView.frame.size.width/2, BottomBtnHeight);
        _okBtn.frame = CGRectMake(CGRectGetMaxX(_cancelBtn.frame), originY, contentView.frame.size.width/2, BottomBtnHeight);
        
    }else{
        _okBtn.frame = CGRectMake(0, originY, contentView.frame.size.width, BottomBtnHeight);
        _bottomMidLine.hidden = YES;
        _cancelBtn.hidden = YES;
    }
    
    _centerView.frame = CGRectMake(0, 0, contentView.frame.size.width, topView.frame.size.height+contentView.frame.size.height+BottomBtnHeight);
    _centerView.center = self.center;
}


- (void)setOKBtnBgColor:(UIColor*)bgColor titleColor:(UIColor*)titleColor
{
    _okBtn.backgroundColor = bgColor;
    [_okBtn setTitleColor:titleColor forState:UIControlStateNormal];
}

#pragma mark - action

-(void)showPopView{
    
    [[YYKeyboardManager defaultManager] addObserver:self];
    UIWindow* window = [UIApplication sharedApplication].delegate.window;
    [window addSubview:self];
    
}

-(void)dismissPopView{
    
    [[YYKeyboardManager defaultManager] removeObserver:self];
    
    [self removeFromSuperview];
    
}

- (void)tapScrollView
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
}

#pragma mark - 横屏处理

- (void)landscapeNotice{
    
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    _centerView.center = self.center;
}


#pragma mark - action

-(void)clickCancleBtn:(UIButton*)sender{
    //    [self.popViewDelegate PopBaseView:self clickCancleBtn:sender];
    [self dismissPopView];
    
}
-(void)clickSureBtn:(UIButton*)sender{
    //    [self.popViewDelegate PopBaseView:self clickSureBtn:sender];
    [self dismissPopView];
}

#pragma mark - @protocol YYKeyboardObserver

- (void)keyboardChangedWithTransition:(YYKeyboardTransition)transition {
    [UIView animateWithDuration:transition.animationDuration delay:0 options:transition.animationOption animations:^{
        UIWindow * keyWindow = [[UIApplication sharedApplication] keyWindow];
        CGRect kbFrame = [[YYKeyboardManager defaultManager] convertRect:transition.toFrame toView:keyWindow];
        //获取当前第一响应者
        CGRect textFieldFrame = _centerView.frame;
        
        if (CGRectGetMaxY(textFieldFrame) > kbFrame.origin.y) {
            CGRect textframe = self.frame;
            textframe.origin.y = kbFrame.origin.y - CGRectGetMaxY(textFieldFrame);
            self.frame = textframe;
            
        }else if (kbFrame.origin.y == SCREEN_HEIGHT){//收键盘
            self.frame = self.bounds;
            
        }
    } completion:^(BOOL finished) {
        
    }];
}

@end

