//
//  KPRedAlertPopView.m
//  RCIOS-SDK
//
//  Created by gzkp on 2018/8/25.
//  Copyright © 2018年 RC. All rights reserved.
//

#import "KPRedAlertPopView.h"
#import "YYKeyboardManager.h"
#import "NSString+Size.h"
#import "LittleImageBigControl.h"
#import "PasswordInputView.h"


@interface KPRedAlertPopView ()

@property (nonatomic,strong) UIView *bottomLine;
@property (nonatomic,strong) UIView *midLine;
@property (nonatomic,strong) UIView *contentView1;
@property (nonatomic,strong) UIView *contentView2;

@property (nonatomic,strong) PasswordInputView *dynamicInputView;
@property (nonatomic,strong) KPTextField *dynamicTextField;
@property (nonatomic,strong) UIButton *dynamicBtn;
@property (nonatomic,strong) UILabel *contentLabel;

@end

@implementation KPRedAlertPopView
{
    NSString *_cancelTitle;
    NSString *_okBtnTitle;
    UIImage *_image;
    NSString *_title;
    NSString *_content;
    
    CGFloat _contentWidth;
    CGFloat _contentHeight;
    CGFloat _originY;
    
    NSInteger _stepOpration;
}


- (instancetype)initWithImage:(UIImage *)image title:(NSString*)title content:(NSString *)content cancelBtnTitle:(NSString*)cancelBtnTitle okBtnTitle:(NSString*)okBtnTitle  makeSure:(ConfirmV2)makeSure cancel:(Cancel)cancel
{
    self = [super initWithCancelBtnTitle:cancelBtnTitle okBtnTitle:okBtnTitle];
    
    if (self) {
        
        self.cancel = cancel;
        self.confirmV2 = makeSure;
        
        self.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.5];
        
        _cancelTitle = cancelBtnTitle;
        _okBtnTitle = okBtnTitle;
        _image = image;
        _contentWidth = SCREEN_WIDTH*560/720;
        _originY = SCREEN_HEIGHT*156/640;
        _title = title;
        _content = content;
        
        
        [self createFirstContentView];
        [self refreshCenterView:self.topView contentView:self.contentView];

    }
    
    return self;
}

- (void)createFirstContentView
{
    CGFloat originY = 0.0;
    
    _contentView1 = [[UIView alloc]init];
    _contentView1.backgroundColor = [UIColor whiteColor];
    _contentView1.layer.cornerRadius = 5;
    _contentView1.clipsToBounds = YES;
    [self.contentView addSubview:_contentView1];
    
    
    //中间
    UIImageView *imageView = [[UIImageView alloc]initWithImage:_image];
    imageView.frame = CGRectMake((_contentWidth - imageView.frame.size.width)/2, 25, imageView.frame.size.width, imageView.frame.size.height);
    [_contentView1 addSubview:imageView];
    
    CGFloat distance = 20;
    CGFloat labelWidth = _contentWidth-distance*2;
    CGSize titleSize = [_title sizeWithFont:FontSize(17) maxSize:CGSizeMake(labelWidth, 0)];
    UILabel *titleLabel = [UIFactory createLabelWithText:_title textColor:kUIColorFromRGB(0x282b34) font:FontSize(16)];
    titleLabel.frame = CGRectMake(distance, CGRectGetMaxY(imageView.frame)+20, labelWidth, titleSize.height);
    titleLabel.numberOfLines = 0;
    [_contentView1 addSubview:titleLabel];
    originY = CGRectGetMaxY(titleLabel.frame)+14;
    
    if (_content && _content.length) {
        CGSize contentSize = [_content sizeWithFont:FontSize(14) maxSize:CGSizeMake(labelWidth, 0)];
        UILabel *contentLabel = [UIFactory createLabelWithText:_content textColor:kUIColorFromRGBAlpha(0x000000, 0.3) font:FontSize(14)];
        contentLabel.frame = CGRectMake(distance, originY, labelWidth, contentSize.height);
        contentLabel.numberOfLines = 0;
        contentLabel.textAlignment = NSTextAlignmentCenter;
        [_contentView1 addSubview:contentLabel];
        originY = CGRectGetMaxY(contentLabel.frame)+20;
    }else{
        originY = originY+20;
    }

    _contentView1.frame = CGRectMake(0, 0, _contentWidth, originY);
    self.contentView.frame = CGRectMake((SCREEN_WIDTH - _contentWidth)/2, _originY, _contentWidth, originY);
}

- (void)createSecondContentView
{
    CGFloat itemWidth = _contentWidth-dis_LEFTSCREEN*2;
    
    _contentView2 = [[UIView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - _contentWidth)/2, _originY, _contentWidth, 188) ];
    _contentView2.layer.cornerRadius = 5;
    _contentView2.clipsToBounds = YES;
    _contentView2.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_contentView2];
    
    LittleImageBigControl *closeControl = [LittleImageBigControl createControlWithSize:CGSizeMake(50, 50) imageName:@"common_close"];
    [_contentView2 addSubview:closeControl];
    [closeControl addTarget:self action:@selector(clickCancleBtn) forControlEvents:UIControlEventTouchUpInside];
    closeControl.frame = CGRectMake(_contentWidth-50, 0, 50, 50);
    
    UILabel *titleLabel = [UIFactory createLabelWithText:ML(@"验证身份") textColor:kUIColorFromRGB(0x000000) font:FontSize(18)];
    titleLabel.frame = CGRectMake(dis_LEFTSCREEN, 25, itemWidth, 25);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [_contentView2 addSubview:titleLabel];
    
    NSString *content = [NSString stringWithFormat:@"%@%@%@",ML(@"已向"),self.account,ML(@"发送验证码")];
    CGSize size = [content sizeWithFont:FontSize(16) maxSize:CGSizeMake(itemWidth, 0)];
    CGFloat contentHeight = size.height < 23 ? 23:size.height;
    UILabel *contentLabel = [UIFactory createLabelWithText:content textColor:kUIColorFromRGBAlpha(0x000000, 0.3) font:FontSize(16)];
    contentLabel.frame = CGRectMake(dis_LEFTSCREEN, CGRectGetMaxY(titleLabel.frame)+5, itemWidth, contentHeight) ;
    contentLabel.textAlignment = NSTextAlignmentCenter;
    _contentLabel = contentLabel;
    [_contentView2 addSubview:contentLabel];
    
    KPTextField *dynamicTextField = [[KPTextField alloc]initWithFrame:CGRectMake(dis_LEFTSCREEN, CGRectGetMaxY(contentLabel.frame)+10, itemWidth, 50)];
    _dynamicTextField = dynamicTextField;
    dynamicTextField.keyboardType = UIKeyboardTypeNumberPad;
    [_contentView2 addSubview:dynamicTextField];
    UIView *inputLine = [[UIView alloc]initWithFrame:CGRectMake(0, dynamicTextField.frame.size.height, dynamicTextField.frame.size.width, 0.5)];
    inputLine.backgroundColor = GC.LINE;
    [dynamicTextField addSubview:inputLine];
    
    
    UIButton *dynamicBtn = [[UIButton alloc]initWithFrame:CGRectMake(dis_LEFTSCREEN, CGRectGetMaxY(dynamicTextField.frame), itemWidth, 25)];
    _dynamicBtn = dynamicBtn;
    [dynamicBtn setTitle:ML(@"获取动态密码") forState:UIControlStateNormal];
    [dynamicBtn setTitleColor:GC.MC forState:UIControlStateNormal];
    [dynamicBtn.titleLabel setFont:FontSize(15)];
    [dynamicBtn addTarget:self action:@selector(dynamicBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_contentView2 addSubview:dynamicBtn];

    
    _contentView2.frame = CGRectMake(0, 0, _contentWidth, CGRectGetMaxY(dynamicBtn.frame)+20);
    self.contentView.frame = CGRectMake(0, 0, _contentWidth, CGRectGetMaxY(dynamicBtn.frame)+20);
    [self.contentView addSubview:_contentView2];
    
}

- (void)showPopView
{
    UIWindow* window = [UIApplication sharedApplication].delegate.window;
    [window addSubview:self];
    
}

#pragma mark - sure&cancel btn
- (void)clickSureBtn:(UIButton *)sender
{
    switch (self.alertPopType) {
        case 0:
            if (self.confirmV2) {
                self.confirmV2(nil,0);
            }
            [super clickSureBtn:sender];
            
            break;
            
        case 1:
            if (_stepOpration == 0) {
                [self createSecondContentView];
                _contentView1.hidden = YES;
                _contentView2.hidden = NO;
                [self refreshCenterView:self.topView contentView:self.contentView];
                [_dynamicInputView textBecomeFirstRespond];
                
            }else if (_stepOpration == 1){
                if (self.confirmV2) {
                    self.confirmV2(nil,0);
                }
                [super clickSureBtn:sender];
                
                break;
                
            }
            
            break;
            
        default:
            break;
    }
    _stepOpration += 1;
}

- (void)clickCancleBtn:(UIButton *)sender
{
    if (self.cancel) {
        self.cancel();
    }
    [super clickCancleBtn:sender];
    
}

- (void)dynamicBtnAction:(UIButton *)sender
{
    
    
}

@end
