//
//  KPEditUintPopView.m
//  kpkd
//
//  Created by gzkp on 2017/7/26.
//  Copyright © 2017年 kptech. All rights reserved.
//

#import "KPEditUintPopView.h"
#import "NSString+Size.h"
#import "LittleImageBigControl.h"

@interface KPEditUintPopView()<UITextFieldDelegate>

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UITextField *unitTextField;
@property (nonatomic,strong) UITextField *unitNumer;
@property (nonatomic,copy) Delete deleteAction;
@property (nonatomic,strong) UIButton *defualtBtn;

@end

static const CGFloat normalWith = 270;
static const CGFloat normalHeight = 85;
static const CGFloat leftDis = 15;

@implementation KPEditUintPopView
{
    NSString *_title;
    NSString *_unitTitle;
    NSString *_number;
    BOOL _isDefaultUnit;
    NSString *_baseUnitTitle;
    
    CGSize _titleSize;
    NSString *_content;
    CGSize _contentSize;
    
    NSInteger kMaxLength;
}

//由于历史原因 cancelAction是删除事件 makeSure确定 deleteAction是取消事件
- (instancetype)initWithTitle:(NSString*)title unitTitle:(NSString*)unitTitle number:(double)number baseUnitTitle:(NSString*)baseUnitTitle isDefaultUnit:(BOOL)isDefaultUnit cancelBtnTitle:(NSString*)cancelBtnTitle okBtnTitle:(NSString*)okBtnTitle  makeSure:(ConfirmV3)makeSure cancel:(Cancel)cancel delete:(Delete)deleteAction
{
    self = [super initWithCancelBtnTitle:cancelBtnTitle okBtnTitle:okBtnTitle];
    if (self) {
        
        self.cancel = cancel;
        self.confirmV3 = makeSure;
        _deleteAction = deleteAction;
        _title = title;
        _unitTitle = unitTitle;
        
        if (number == 0) {
            _number = @"";
        }
        kMaxLength = 8;
        _isDefaultUnit = isDefaultUnit;
        _baseUnitTitle = baseUnitTitle;
        
        
        _titleSize = [title sizeWithFont:FontSize(17) maxSize:CGSizeMake(normalWith - leftDis*2, 0)];
        
        [self createItems];
        [self refreshCenterView:self.topView contentView:self.contentView];
    }
    return self;
    
}

- (void)createItems
{
    CGFloat labelWidth = normalWith - leftDis*2;
    
    if (_title && ![_title isEqualToString:@""])
    {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftDis, 20, labelWidth, _titleSize.height)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = FontSize(17);
        _titleLabel.textColor = kUIColorFromRGB(0x282b34);
        _titleLabel.text = _title;
        _titleLabel.numberOfLines = 0;
        [self.contentView addSubview:_titleLabel];
    }
    
    CGSize baseUnitSize = [_baseUnitTitle sizeWithFont:FontSize(15) maxSize:CGSizeMake(999, 30)];
    if (baseUnitSize.width > 50) {
        baseUnitSize.width = 50;
    }
    CGFloat fieldWidth = (normalWith - 60 - baseUnitSize.width - 35)/2;
    
    KPTextField *unitTitleTextField = [[KPTextField alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(_titleLabel.frame) + 20, fieldWidth, 30)];
    _unitTextField = unitTitleTextField;
    unitTitleTextField.delegate = self;
    unitTitleTextField.font = FontSize(17);
    unitTitleTextField.borderStyle = UITextBorderStyleRoundedRect;
    unitTitleTextField.placeholder = ML(@"新单位");
    unitTitleTextField.text = _unitTitle;
    unitTitleTextField.textAlignment = NSTextAlignmentCenter;
    [unitTitleTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.contentView addSubview:unitTitleTextField];
    
    UILabel *equalLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(unitTitleTextField.frame) + 10, unitTitleTextField.frame.origin.y, 15, 30)];
    equalLabel.font = FontSize(15);
    equalLabel.text = @"=";
    [self.contentView addSubview:equalLabel];
    
    
    KPTextField *unitNumTextField = [[KPTextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(equalLabel.frame) + 10, unitTitleTextField.frame.origin.y, fieldWidth, 30)];
    _unitNumer = unitNumTextField;
    unitNumTextField.font = FontSize(15);
    unitNumTextField.borderStyle = UITextBorderStyleRoundedRect;
    unitNumTextField.keyboardType = UIKeyboardTypeDecimalPad;
    unitNumTextField.placeholder = ML(@"数量");
    unitNumTextField.text = _number;
    unitNumTextField.textAlignment = NSTextAlignmentCenter;
    unitNumTextField.delegate = self;
    [self.contentView addSubview:unitNumTextField];
    
    UILabel *baseUnitLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(unitNumTextField.frame) + 10, unitTitleTextField.frame.origin.y, baseUnitSize.width, 30)];
    baseUnitLabel.font = FontSize(15);
    baseUnitLabel.text = _baseUnitTitle;
    [self.contentView addSubview:baseUnitLabel];
    LittleImageBigControl *cancelControl = [LittleImageBigControl createControlWithSize:CGSizeMake(50, 50) imageName:@"common_close"];
    [self.contentView addSubview:cancelControl];
    [cancelControl addTarget:self action:@selector(clickDeleteBtn:) forControlEvents:UIControlEventTouchUpInside];
    cancelControl.frame = CGRectMake(normalWith-50, 0, 50, 50);
    
    CGFloat nowY = CGRectGetMaxY(unitTitleTextField.frame);
    UIImage *defualtImage = [UIImage imageNamed:@"common_unselect"];
    UIButton *defualtBtn = [[UIButton alloc]initWithFrame:CGRectMake(30, nowY + 20, defualtImage.size.width, defualtImage.size.width)];
    [defualtBtn addTarget:self action:@selector(defualtBtnSelected:) forControlEvents:UIControlEventTouchUpInside];
    _defualtBtn = defualtBtn;
    [defualtBtn setImage:defualtImage forState:UIControlStateNormal];
    [self.contentView addSubview:defualtBtn];
    [self setDefualtWithBtn:defualtBtn];
    
    nowY =  defualtBtn.frame.origin.y;
    
    UILabel *defualtLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(defualtBtn.frame) + 15,nowY, 150, defualtBtn.frame.size.height)];
    defualtLabel.text = ML(@"默认售卖单位");
    defualtLabel.font = FontSize(12);
    defualtLabel.textColor = kUIColorFromRGB(0x333333);
    [self.contentView addSubview:defualtLabel];
    
    nowY =  CGRectGetMaxY(defualtBtn.frame)+20;
    
    
    self.contentView.frame = CGRectMake(0, 0, normalWith, nowY);
}

- (void)defualtBtnSelected:(UIButton *)sender
{
    _isDefaultUnit = !_isDefaultUnit;
    [self setDefualtWithBtn:sender];
    
}

- (void)setDefualtWithBtn:(UIButton *)sender
{
    if (_isDefaultUnit) {
        [sender setImage:[UIImage imageNamed:@"common_select"] forState:UIControlStateNormal];
    }else{
        [sender setImage:[UIImage imageNamed:@"common_unselect"] forState:UIControlStateNormal];
    }
    
}

- (void)textFieldDidChange:(UITextField*)textField
{
    
    NSString *toBeString = textField.text;
    NSString *lang = [[UIApplication sharedApplication]textInputMode].primaryLanguage; //ios7之前使用[UITextInputMode currentInputMode].primaryLanguage
    if ([lang isEqualToString:@"zh-Hans"]) { //中文输入
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        if (!position) {// 没有高亮选择的字，则对已输入的文字进行字数统计和限制
            if (toBeString.length > kMaxLength) {
                textField.text = [toBeString substringToIndex:kMaxLength];
            }
        }
        else{//有高亮选择的字符串，则暂不对文字进行统计和限制
        }
    }else{//中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        if (toBeString.length > kMaxLength) {
            textField.text = [toBeString substringToIndex:kMaxLength];
        }
    }
    
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if ([textField isEqual:_unitTextField]) {
        if ([@"0123456789" containsString:string]) {
            return NO;
        }
    }else if ([textField isEqual:_unitNumer]){
        //return [StringCheckout validateNumber:string textField:textField floatCount:PricePrecision];
    }
    
    
    return YES;
}


#pragma mark - sure&cancel btn

- (void)clickSureBtn:(UIButton *)sender
{
//    if (_unitTextField.text.length == 0) {
//        [GMUtils showQuickTipWithText:ML(@"请输入新单位")];
//        return;
//    }else if (_unitNumer.text.length == 0) {
//        [GMUtils showQuickTipWithText:ML(@"请输入数量")];
//        return;
//    }
    
    if (self.confirmV3) {
        //self.confirmV3(_unitTextField.text,[CommenHelper exchangeFromText:_unitNumer.text],_isDefaultUnit);
        self.confirmV3(_unitTextField.text,0.5,_isDefaultUnit);
    }
    [super clickSureBtn:sender];
    
}

- (void)clickCancleBtn:(UIButton *)sender
{
    if (_deleteAction) {
        _deleteAction();
    }
    [super clickCancleBtn:sender];
    
}

- (void)clickDeleteBtn:(UIButton *)sender
{
    if (self.cancel) {
        self.cancel();
    }
    [super clickCancleBtn:sender];
    
    
}

- (void)showPopView:(UIView *)view{
    if (view) {
        [self setFrame:view.bounds];
        [view addSubview:self];
    }
}

@end
