//
//  PasswordInputView.m
//  kp
//
//  Created by gzkp on 2018/4/10.
//  Copyright © 2018年 kptech. All rights reserved.
//

#import "PasswordInputView.h"
#import "InputSecurityView.h"


@interface PasswordInputView()

@property (nonatomic,strong) NSMutableArray *inputViewArray;
@property (nonatomic,strong) UIImage *securityImage;
@property (nonatomic,strong) UITextField *dynamicTextField;

@end

@implementation PasswordInputView
{
    NSInteger _inputNum;
    
}

- (id)initWithFrame:(CGRect)frame securityImage:(UIImage *)securityImage inputNum:(NSInteger)inputNum
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _inputNum = inputNum;
        _securityImage = securityImage;
        _inputViewArray = [NSMutableArray array];
        CGFloat itemWidth = frame.size.width/inputNum;
        for (int i = 0; i < inputNum; i ++) {
            
            InputSecurityView *btnView = [[InputSecurityView alloc]initWithFrame:CGRectMake(i*itemWidth, 0, itemWidth, frame.size.height)];// btn需要重做
            [self addSubview:btnView];
            [btnView setSecurityImage:nil];
            [_inputViewArray addObject:btnView];
        }
        
        //textField
        UIControl *tapControl = [[UIControl alloc]initWithFrame:self.bounds];
        [self addSubview:tapControl];
        [tapControl addTarget:self action:@selector(textBecomeFirstRespond) forControlEvents:UIControlEventTouchUpInside];
        
        UITextField *dynamicTextField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 1, 1)];
        _dynamicTextField = dynamicTextField;
        [dynamicTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        dynamicTextField.hidden = YES;
        dynamicTextField.keyboardType = UIKeyboardTypeDecimalPad;
        [self addSubview:dynamicTextField];
        
    }
    
    return self;
    
    
}


#pragma mark - input
-(void)textFieldDidChange:(UITextField *)theTextField{
    
    if (theTextField.text.length >= _inputNum) {
        theTextField.text = [theTextField.text substringToIndex:6];
        
        if ([self.delegate respondsToSelector:@selector(inputComplete:)]) {
            [self.delegate inputComplete:theTextField.text];
        }
        
    }
    [self refreshWithInputWord:theTextField.text];
}


- (void)refreshWithInputWord:(NSString *)inputWord
{

    for (int i = 0; i < _inputViewArray.count; i ++) {
        
        InputSecurityView *btnView = _inputViewArray[i];
        
        if (inputWord.length > i) {
            NSString *aChar = [inputWord substringWithRange:NSMakeRange(i, 1)];
            [btnView setText:aChar];
        }else{
            [btnView setText:nil];
            
        }
    }
    
}

- (void)textBecomeFirstRespond
{
    [_dynamicTextField becomeFirstResponder];
    
}




@end
