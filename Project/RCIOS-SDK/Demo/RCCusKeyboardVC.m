//
//  RCCusKeyboardVC.m
//  RCIOS-SDK
//
//  Created by gzkp on 2018/10/19.
//  Copyright © 2018年 RC. All rights reserved.
//

#import "RCCusKeyboardVC.h"
#import "KeyBoardDigitalView.h"


@interface RCCusKeyboardVC ()

@end

@implementation RCCusKeyboardVC
{
    UIView *footView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = WHITE_COLOR;
    footView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH, 50)];
    
    UITextField *textField = [[UITextField alloc]init];
    [textField setFrame:CGRectMake(100, 100, 200, 50)];
    [textField setFont:[UIFont systemFontOfSize:17]];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:textField];

    [textField addTarget:self action:@selector(textFieldDidBeginDo:) forControlEvents:UIControlEventEditingDidBegin];
    [textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    


}

#pragma mark - input delegate
- (void)textFieldDidBeginDo:(UITextField *)textField {

//    [KeyBoardDigitalView getInstance].upToView = self.view;
    
    [KeyBoardDigitalView getInstance].footView = footView;
    
    [[KeyBoardDigitalView getInstance] setKeyBoardInputView:textField];
}

// 优惠改变 实现方法
- (void)textFieldDidChange:(UITextField *)textField {
    
    textField.text = [textField.text stringByReplacingOccurrencesOfString:@"," withString:@""];
    
    if ([textField.text isEqualToString:@""]) {
        textField.text = @"0";
    }
    

    
}


@end
