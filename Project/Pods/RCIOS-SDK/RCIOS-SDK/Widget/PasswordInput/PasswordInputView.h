//
//  PasswordInputView.h
//  kp
//
//  Created by gzkp on 2018/4/10.
//  Copyright © 2018年 kptech. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PasswordInputViewDelegate;

@interface PasswordInputView : UIControl

@property (nonatomic,weak) id delegate;

- (id)initWithFrame:(CGRect)frame securityImage:(UIImage *)securityImage inputNum:(NSInteger)inputNum;

- (void)refreshWithInputWord:(NSString *)inputWord;

- (void)textBecomeFirstRespond;

@end

@protocol PasswordInputViewDelegate

- (void)inputComplete:(NSString*)inputWord;

@end
