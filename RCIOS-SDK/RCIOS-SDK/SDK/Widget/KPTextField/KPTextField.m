//
//  KPTextField.m
//  kpkd
//
//  Created by gzkp on 2017/9/4.
//  Copyright © 2017年 kptech. All rights reserved.
//

#import "KPTextField.h"


@implementation KPTextField
{
    NSInteger _openNum;
    
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.tintColor = GC.MC;
        [self setValue:kUIColorFromRGB(0xCCCCCC) forKeyPath:@"_placeholderLabel.textColor"];
        
        self.delegate = self;
        
        [self setReturnKeyType:UIReturnKeyDone];
    }
    return self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)aTextfield {
    [aTextfield resignFirstResponder];//关闭键盘
    return YES;
}

//- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
//
//    UIMenuController *menuController = [UIMenuController sharedMenuController];
//
//    if (menuController)
//
//    {
//
//        [UIMenuController sharedMenuController].menuVisible = NO;
//
//    }
//
//    return NO;
//
//}

@end
