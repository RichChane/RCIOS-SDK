//
//  STPickerView.m
//  STPickerView
//
//  Created by https://github.com/STShenZhaoliang/STPickerView on 16/2/17.
//  Copyright © 2016年 shentian. All rights reserved.
//

#import "STPickerView.h"


@implementation STPickerView

#pragma mark - --- init 视图初始化 ---
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupDefault];
        [self setupUI];
    }
    return self;
}

- (void)setupDefault
{
    // 1.设置数据的默认值
    _title             = nil;
    _font              = [UIFont systemFontOfSize:15];
    _titleColor        = [UIColor blackColor];
    _borderButtonColor = RGB(205, 205, 205);
    _heightPicker      = 240;
    
    
    // 2.设置自身的属性
    self.bounds = [UIScreen mainScreen].bounds;
    self.backgroundColor = RGBA(0, 0, 0, 102.0/255);
    self.layer.opacity = 0.0;
    [self addTarget:self action:@selector(remove) forControlEvents:UIControlEventTouchUpInside];
    
    // 3.添加子视图
    [self addSubview:self.contentBgView];
    [self.contentBgView addSubview:self.contentView];
    [self.contentView addSubview:self.lineView];
    [self.contentView addSubview:self.pickerView];
    [self.contentView addSubview:self.buttonLeft];
    [self.contentView addSubview:self.buttonRight];
    [self.contentView addSubview:self.labelTitle];
    [self.contentView addSubview:self.lineViewDown];
}

- (void)setupUI
{}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.contentMode == STPickerContentModeBottom ) {
    }else if(self.contentMode == STPickerContentModeTop){
    }else {
        self.buttonLeft.y = self.lineViewDown.bottom + STMarginSmall;
        self.buttonRight.y = self.lineViewDown.bottom + STMarginSmall;
    }
}

#pragma mark - --- delegate 视图委托 ---

#pragma mark - --- event response 事件相应 ---

- (void)selectedOk
{
    [self remove];
}

- (void)selectedCancel
{

    [self remove];
}

#pragma mark - --- private methods 私有方法 ---

- (void)showInView:(UIView *)superView
{
    [superView addSubview:self];
    self.size = superView.size;
    self.origin = CGPointZero;
    if (self.contentMode == STPickerContentModeBottom) {
        CGRect frameContent =  self.contentView.frame;
        frameContent.origin.y =superView.height-self.contentView.height;
        self.contentBgView.frame = frameContent;
    }else if (self.contentMode == STPickerContentModeTop){
        CGRect frameContent =  self.contentView.frame;
        frameContent.origin.y = _topY;
        self.contentBgView.frame = frameContent;
        

    }else {
        
        CGRect frameContent =  self.contentView.frame;
        frameContent.origin.y -= (self.height+self.contentView.height)/2;
        self.contentBgView.frame = frameContent;
    }
    
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self];
    
    if (self.contentMode == STPickerContentModeBottom) {
        self.contentView.frame = CGRectMake(0, self.contentView.height, self.contentView.width, self.contentView.height);
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            [self.layer setOpacity:1.0];
            self.contentView.frame = CGRectMake(0, 0, self.contentView.width, self.contentView.height);
        } completion:^(BOOL finished) {
        }];
    }else if (self.contentMode == STPickerContentModeTop){
        
        self.backgroundColor = CLEAR_COLOR;
        CGRect frameContent =  self.contentView.frame;
        frameContent.origin.y = _topY;
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, _topY, self.width, self.height-_topY)];
        bgView.backgroundColor = RGBA(0, 0, 0, 102.0/255);
        [self addSubview:bgView];
        [self sendSubviewToBack:bgView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectedCancel)];
        [bgView addGestureRecognizer:tap];
        
        self.contentView.frame = CGRectMake(0, -self.contentView.height, self.contentView.width, self.contentView.height);
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            [self.layer setOpacity:1.0];
            self.contentView.frame = CGRectMake(0, 0, self.contentView.width, self.contentView.height);
        } completion:^(BOOL finished) {
        }];
        
    }else {
        
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            [self.layer setOpacity:1.0];
            self.contentView.frame = CGRectMake(0, 0, self.contentView.width, self.contentView.height);
        } completion:^(BOOL finished) {
        }];
    }

}

- (void)show
{
    [self showInView:[UIApplication sharedApplication].keyWindow];
}

- (void)remove
{
    if (self.contentMode == STPickerContentModeBottom) {
        CGRect frameContent =  self.contentView.frame;
        frameContent.origin.y += self.contentView.height;
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            [self.layer setOpacity:0.0];
            self.contentView.frame = frameContent;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }else if (self.contentMode == STPickerContentModeTop){
        
        CGRect frameContent =  self.contentView.frame;
        frameContent.origin.y = -CGRectGetMaxY(self.contentView.frame);
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            [self.layer setOpacity:1.0];
            self.contentView.frame = frameContent;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
        
    }else {
        CGRect frameContent =  self.contentView.frame;
        frameContent.origin.y += (SCREEN_HEIGHT+self.contentView.height)/2;
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            [self.layer setOpacity:0.0];
            self.contentView.frame = frameContent;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
    
    
}

#pragma mark - --- setters 属性 ---

- (void)setTitle:(NSString *)title
{
    _title = title;
    [self.labelTitle setText:title];
}

- (void)setFont:(UIFont *)font
{
    _font = font;
    [self.buttonLeft.titleLabel setFont:font];
    [self.buttonRight.titleLabel setFont:font];
    [self.labelTitle setFont:font];
}

- (void)setTitleColor:(UIColor *)titleColor
{
    _titleColor = titleColor;
    [self.labelTitle setTextColor:titleColor];
    [self.buttonLeft setTitleColor:titleColor forState:UIControlStateNormal];
    [self.buttonRight setTitleColor:titleColor forState:UIControlStateNormal];
}

- (void)setBorderButtonColor:(UIColor *)borderButtonColor
{
    _borderButtonColor = borderButtonColor;
    [self.buttonLeft addBorderColor:borderButtonColor];
    [self.buttonRight addBorderColor:borderButtonColor];
}

- (void)setHeightPicker:(CGFloat)heightPicker
{
    _heightPicker = heightPicker;
    self.contentView.height = heightPicker;
}

- (void)setContentMode:(STPickerContentMode)contentMode
{
    _contentMode = contentMode;
    if (contentMode == STPickerContentModeCenter) {
        self.contentView.height += STControlSystemHeight;
    }else if (contentMode == STPickerContentModeTop) {
        CGRect frame = self.contentView.frame;
        frame.origin.y = -CGRectGetMaxY(self.contentView.frame)+_topY;
        self.contentView.frame = frame;
        
    }
}
#pragma mark - --- getters 属性 ---
- (UIView *)contentBgView
{
    if (!_contentBgView) {
        CGFloat contentX = 0;
        CGFloat contentY = SCREEN_HEIGHT;
        CGFloat contentW = SCREEN_WIDTH;
        CGFloat contentH = self.heightPicker;
        _contentBgView = [[UIView alloc]initWithFrame:CGRectMake(contentX, contentY, contentW, contentH)];
        _contentBgView.clipsToBounds = YES;
        
    }
    return _contentBgView;
    
}


- (UIView *)contentView
{
    if (!_contentView) {
        CGFloat contentX = 0;
        //CGFloat contentY = SCREEN_HEIGHT;
        CGFloat contentW = SCREEN_WIDTH;
        CGFloat contentH = self.heightPicker;
        _contentView = [[UIView alloc]initWithFrame:CGRectMake(contentX, _contentBgView.height, contentW, contentH)];
        [_contentView setBackgroundColor:[UIColor whiteColor]];
        
    }
    return _contentView;
}

- (UIView *)lineView
{
    if (!_lineView) {
        CGFloat lineX = 0;
        CGFloat lineY = STControlSystemHeight;
        CGFloat lineW = self.contentView.width;
        CGFloat lineH = 0.5;
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(lineX, lineY, lineW, lineH)];
        [_lineView setBackgroundColor:self.borderButtonColor];
    }
    return _lineView;
}

- (UIPickerView *)pickerView
{
    if (!_pickerView) {
        CGFloat pickerW = self.contentView.width;
        CGFloat pickerH = self.contentView.height - self.lineView.bottom;
        CGFloat pickerX = 0;
        CGFloat pickerY = self.lineView.bottom;
        _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(pickerX, pickerY, pickerW, pickerH)];
        [_pickerView setBackgroundColor:[UIColor whiteColor]];
    }
    return _pickerView;
}

- (UIButton *)buttonLeft
{
    if (!_buttonLeft) {
        CGFloat leftW = STControlSystemHeight;
        CGFloat leftH = self.lineView.top - STMargin;
        //CGFloat leftX = STMarginBig;
        CGFloat leftX = STMarginBig-5;
        CGFloat leftY = (self.lineView.top - leftH) / 2;
        _buttonLeft = [[UIButton alloc]initWithFrame:CGRectMake(leftX, leftY, leftW, leftH)];
        [_buttonLeft setTitle:@"取消" forState:UIControlStateNormal];
        [_buttonLeft setTitleColor:kUIColorFromRGB(0xCCCCCC) forState:UIControlStateNormal];
        //[_buttonLeft addBorderColor:self.borderButtonColor];
        [_buttonLeft.titleLabel setFont:self.font];
        [_buttonLeft addTarget:self action:@selector(selectedCancel) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buttonLeft;
}

- (UIButton *)buttonRight
{
    if (!_buttonRight) {
        CGFloat rightW = self.buttonLeft.width;
        CGFloat rightH = self.buttonLeft.height;
        CGFloat rightX = self.contentView.width - rightW - self.buttonLeft.x + 5;
        CGFloat rightY = self.buttonLeft.y;
        _buttonRight = [[UIButton alloc]initWithFrame:CGRectMake(rightX, rightY, rightW, rightH)];
        [_buttonRight setTitle:@"确定" forState:UIControlStateNormal];
        [_buttonRight setTitleColor:GC.MC forState:UIControlStateNormal];
        //[_buttonRight addBorderColor:self.borderButtonColor];
        [_buttonRight.titleLabel setFont:self.font];
        [_buttonRight addTarget:self action:@selector(selectedOk) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buttonRight;
}

- (UILabel *)labelTitle
{
    if (!_labelTitle) {
        CGFloat titleX = self.buttonLeft.right + STMarginSmall;
        CGFloat titleY = 0;
        CGFloat titleW = self.contentView.width - titleX * 2;
        CGFloat titleH = self.lineView.top;
        _labelTitle = [[UILabel alloc]initWithFrame:CGRectMake(titleX, titleY, titleW, titleH)];
        [_labelTitle setTextAlignment:NSTextAlignmentCenter];
        [_labelTitle setTextColor:self.titleColor];
        [_labelTitle setFont:self.font];
        _labelTitle.adjustsFontSizeToFitWidth = YES;
    }
    return _labelTitle;
}

- (UIView *)lineViewDown
{
    if (!_lineViewDown) {
        CGFloat lineX = 0;
        CGFloat lineY = self.pickerView.bottom;
        CGFloat lineW = self.contentView.width;
        CGFloat lineH = 0.5;
        _lineViewDown = [[UIView alloc]initWithFrame:CGRectMake(lineX, lineY, lineW, lineH)];
        [_lineViewDown setBackgroundColor:self.borderButtonColor];
    }
    return _lineViewDown;
}
@end

