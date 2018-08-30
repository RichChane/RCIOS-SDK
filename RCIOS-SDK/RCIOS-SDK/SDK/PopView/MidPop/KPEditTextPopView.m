//
//  KPEditTextPopView.m
//  kpkd
//
//  Created by gzkp on 2017/8/7.
//  Copyright © 2017年 kptech. All rights reserved.
//

#import "KPEditTextPopView.h"
#import "NSString+Size.h"

@interface KPEditTextPopView()<UITextFieldDelegate>

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UITextField *unitNumer;
@property (nonatomic,strong) UIButton *defualtBtn;

@end

static const CGFloat normalWith = 270;
static const CGFloat leftDis = 15;;

@implementation KPEditTextPopView
{
    NSString *_title;
    NSString *_placeHoldTitle;
    CGSize _titleSize;
    NSString *_content;
    CGSize _contentSize;
    NSString *_rightText;
    
}


- (instancetype)initWithTitle:(NSString*)title placeHoldTitle:(NSString*)placeHoldTitle content:(NSString *)content cancelBtnTitle:(NSString*)cancelBtnTitle okBtnTitle:(NSString*)okBtnTitle makeSure:(ConfirmV1)makeSure cancel:(Cancel)cancel
{
    self = [super initWithCancelBtnTitle:cancelBtnTitle okBtnTitle:okBtnTitle];
    if (self) {
        
        self.cancel = cancel;
        self.confirmV1 = makeSure;
        
        _title = title;
        _placeHoldTitle = placeHoldTitle;
        _content = content;
        
        _titleSize = [title sizeWithFont:FontSize(17) maxSize:CGSizeMake(normalWith - leftDis*2, 0)];

        
        [self createItems];
        [self refreshCenterView:self.topView contentView:self.contentView];
    }
    return self;

    
    
}

- (instancetype)initWithTitle:(NSString*)title placeHoldTitle:(NSString*)placeHoldTitle content:(NSString *)content rightText:(NSString *)rightText cancelBtnTitle:(NSString*)cancelBtnTitle okBtnTitle:(NSString*)okBtnTitle makeSure:(ConfirmV1)makeSure cancel:(Cancel)cancel
{
    self = [super initWithCancelBtnTitle:cancelBtnTitle okBtnTitle:okBtnTitle];
    if (self) {
        
        self.cancel = cancel;
        self.confirmV1 = makeSure;
        
        _title = title;
        _placeHoldTitle = placeHoldTitle;
        _rightText = rightText;
        
        _titleSize = [title sizeWithFont:FontSize(17) maxSize:CGSizeMake(normalWith - leftDis*2, 0)];
        
        [self createItems];
        [self refreshCenterView:self.topView contentView:self.contentView];
    }
    return self;
    
    
    
}

- (void)createItems
{
    
    CGFloat labelWidth = normalWith - leftDis*2;
    
    CGFloat nowY = 0;
    if (_title && ![_title isEqualToString:@""])
    {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftDis, 20, labelWidth, _titleSize.height)];
        //_distanceLabel.backgroundColor = [UIColor colorWithWhite:0.67 alpha:1.00];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = FontSize(17);
        _titleLabel.textColor = kUIColorFromRGB(0x282b34);
        _titleLabel.text = _title;
        _titleLabel.numberOfLines = 0;
        [self.contentView addSubview:_titleLabel];
        
        nowY = CGRectGetMaxY(_titleLabel.frame)+15;
    }
    UILabel *rightLabel;
    if (_rightText) {
        rightLabel = [[UILabel alloc]init];
        rightLabel.font = FontSize(15);
        rightLabel.text = _rightText;
        [self.contentView addSubview:rightLabel];
        [rightLabel sizeToFit];
        rightLabel.frame = CGRectMake(normalWith-30, CGRectGetMaxY(_titleLabel.frame) + 20, rightLabel.frame.size.width, 30);
        
        nowY = CGRectGetMaxY(rightLabel.frame)+15;
    }
    
    KPTextField *unitTitleTextField = [[KPTextField alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(_titleLabel.frame) + 20, normalWith - 60 - rightLabel.frame.size.width - 10, 30)];
    _unitTextField = unitTitleTextField;
    unitTitleTextField.font = FontSize(15);
    unitTitleTextField.borderStyle = UITextBorderStyleRoundedRect;
    unitTitleTextField.placeholder = _placeHoldTitle;
    unitTitleTextField.textAlignment = NSTextAlignmentCenter;
    [unitTitleTextField addTarget:self action:@selector(textToChange:) forControlEvents:UIControlEventEditingChanged];
    [self.contentView addSubview:unitTitleTextField];
    unitTitleTextField.text = _content;
    unitTitleTextField.delegate = self;
    
    nowY = CGRectGetMaxY(unitTitleTextField.frame)+15;
    
    if (_textType == 1) {
        
        unitTitleTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    }

    self.contentView.frame = CGRectMake(0, 0, normalWith, nowY);
}

- (void)showPopView
{
    [super showPopView];
    
    [self performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:0.1];
}

- (BOOL)becomeFirstResponder

{
    //这句可写可不写，中间妖魔鬼怪的无所谓
    [super becomeFirstResponder];
    
    return [_unitTextField becomeFirstResponder];
    
}


#pragma mark - sure&cancel btn

- (void)clickSureBtn:(UIButton *)sender
{
//    if (self.addType == AddTag) {
//        if ([_title containsString:ML(@"标签")]) {
//            if (_unitTextField.text.length == 0) {
//                [GMUtils showQuickTipWithText:ML(@"标签名不能为空")];
//                return;
//            }
//            if ([self isRepeat:_unitTextField.text]) {
//                [GMUtils showQuickTipWithText:ML(@"标签名不能重复")];
//                return;
//            }
//        }else if ([_title containsString:ML(@"名字")]){
//            if (_unitTextField.text.length == 0) {
//                [GMUtils showQuickTipWithText:ML(@"名字不能为空")];
//                return;
//            }
//        }
//    }else if (self.addType ==AddPayment){
//        if ([self isRepeat:_unitTextField.text]) {
//            [GMUtils showQuickTipWithText:ML(@"该收款方式已存在")];
//            return;
//        }
//
//    }
//
//
//    if (self.confirmV1) {
//        self.confirmV1(_unitTextField.text);
//    }
    [super clickSureBtn:sender];
    
}

- (void)clickDeleteBtn:(UIButton *)sender
{
    if (self.cancel) {
        self.cancel();
    }
    [super clickCancleBtn:sender];
    
    
}

- (BOOL)isRepeat:(NSString *)title
{
//    if ([_content isEqualToString:title]) {
//        return NO;
//    }
//    if (self.addType == AddTag) {
//        NSUInteger allTagCount = [[[DataManager getInstance] getProductManager] tagCount:0];
//        for (int i = 0; i < allTagCount; i ++) {
//
//            KPTag *tagParent = [[[DataManager getInstance] getProductManager] tagAtIndex:(int)i parentId:0];
//            if ([tagParent.name isEqualToString:title]) {
//                return YES;
//            }
//
//
//            NSInteger subTagCount = [[[DataManager getInstance] getProductManager] tagCount:tagParent.tagId];
//            for (int j = 0; j < subTagCount; j ++) {
//                KPTag *subTag = [[[DataManager getInstance] getProductManager] tagAtIndex:j parentId:tagParent.tagId];
//                if ([subTag.name isEqualToString:title]) {
//                    return YES;
//                }
//            }
//
//        }
//
//        return NO;
//    }else if (self.addType == AddPayment){
//        if ([self.verifyArray containsObject:title]) {
//            return YES;
//        }else{
//            return NO;
//        }
//    }
    return NO;
}

- (void)textToChange:(UITextField *)textField{
//    NSString *str = [textField.text stringByReplacingOccurrencesOfString:@"," withString:@""];
//    if (![str length]) {
//        return;
//    }
//
//    if (_maxLength != 0) {
//
//        if (textField.text.length > _maxLength) {
//            textField.text = [textField.text substringToIndex:10];
//        }
//
//    }
//
//
//    if (_textType == 1) {
//        if (![StringCheckout validateMoney:str]) {
//            str = [str substringToIndex:str.length - 1];
//        }
//        if (!(str.doubleValue <= 999.99 && str.doubleValue >= 0)) {
//            str = [str substringToIndex:str.length - 1];
//        }
//        textField.text = str;
//    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
//    [textField selectAll:textField];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)aTextfield {
    [aTextfield resignFirstResponder];//关闭键盘
    return YES;
}

@end
