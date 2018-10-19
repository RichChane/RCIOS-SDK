//
//  KeyBoardDigitalView.m
//  kpkd
//
//  Created by zyy on 2018/5/22.
//  Copyright © 2018年 kptech. All rights reserved.
//

#import "KeyBoardDigitalView.h"

#import "BaseData.h"
#import "GeneralCore.h"
#import "GeneralUIUse.h"

#define OneRowHeight    ASIZE(58)

#define selectBColor kUIColorFromRGB(0xF5F5F5)

@interface KeyBoardDigitalView() {
    __weak UIView *subFootView;         // 原始父视图
    CGRect orgFootFrame;            // 原始frame
}

@end

@implementation KeyBoardDigitalView

+ (UIButton *)FootSaveButton:(CGRect)bFrame {
    UIButton *saveButton = [[UIButton alloc] initWithFrame:bFrame];
    [saveButton setBackgroundColor:GC.MC];
    [saveButton.layer setCornerRadius:4];
    [saveButton.layer setMasksToBounds:YES];
    [saveButton setTitle:@"保 存" forState:0];
    [saveButton.titleLabel setFont:FontSize(19)];
    [saveButton setTitleColor:GC.CWhite forState:0];
    
    return saveButton;
}

+ (instancetype)getInstance {
    static KeyBoardDigitalView *keyBView = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        keyBView = [[KeyBoardDigitalView alloc] init];
    });
    return keyBView;
}


- (id)init {
    if (self = [super init]) {
        _keyMainView = nil;
        _toTextView = nil;
        subFootView = nil;
        _upToView = nil;
    }
    return self;
}

- (void)setKeyBoardInputView:(UITextField *)textField {
    
    _toTextView = textField;
    
    if (_footView) {
        UIView *foot_sup = [_footView superview];
        if (foot_sup) {
            if (!_keyMainView || ![_keyMainView isEqual:foot_sup]) {
                orgFootFrame = _footView.frame;
                subFootView = foot_sup;
            }
        } else {
            subFootView = nil;
        }

    } else {
        subFootView = nil;
    }
    
    [self buildKeyBoard];
    
    // 此方法是解决iPad上面 自定义键盘 不能被消除的toolbar
    if ( [[UIDevice currentDevice] systemVersion].floatValue >= 9.0) {
        UITextInputAssistantItem* item = [_toTextView inputAssistantItem];
        if (item){
            item.leadingBarButtonGroups = @[];
            item.trailingBarButtonGroups = @[];
        }
    }
    
    [_toTextView setInputView:_keyMainView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHideNotification:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];

}

- (void)keyBoardDismiss {
    if (_toTextView) {
        [_toTextView setInputView:nil];
        _toTextView = nil;
    }
    if (_keyMainView) {
        _keyMainView = nil;
    }
    if (_footView) {
        _footView = nil;
    }
    if (_headView) {
        _headView = nil;
    }
    if (subFootView) {
        subFootView = nil;
    }
    if (_upToView) {        // 比较特殊，要从父视图释放
        [_upToView removeFromSuperview];
        _upToView = nil;
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 创建键盘
- (void)buildKeyBoard {
    
    CGRect frameView = CGRectMake(0, 0, SCREEN_WIDTH, 0);
    _keyMainView = [[UIView alloc] initWithFrame:frameView];
    _keyMainView.backgroundColor = GC.BG;
    
    if (_headView) {
        CGRect hFrame = _headView.frame;
        hFrame.origin.x = 0;
        _headView.frame = hFrame;
        [_keyMainView addSubview:_headView];
        frameView.size.height += _headView.frame.size.height;
    }
    
    // 所有的按钮分为13份，小的占2分、大的占3分
    // 两边较小按钮的宽度
    CGFloat littleWidth = SCREEN_WIDTH * 2/13;
    // 中间数字按钮的宽度
    CGFloat largeWidth = SCREEN_WIDTH * 3/13;
    
    NSArray * leftArray = @[@"-",@"·",@"0"];
    for (int i = 0; i < leftArray.count; i++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, OneRowHeight * i + frameView.size.height, littleWidth, OneRowHeight);
        [button setTitle:leftArray[i] forState:0];
        [button setTitleColor:GC.CBlack forState:0];
        [button.titleLabel setFont:FontSize(18)];
        [button setBackgroundColor:GC.CWhite];
        
        button.tag = 2000 + i;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [button addTarget:self action:@selector(buttonDown:) forControlEvents:UIControlEventTouchDown];
        [button addTarget:self action:@selector(buttonCancel:) forControlEvents:UIControlEventTouchCancel|UIControlEventTouchDragOutside];
        [_keyMainView addSubview:button];
        
        [GeneralUIUse AddLineUp:button Color:GC.LINE LeftOri:0 RightOri:0];
    }
    
    NSArray * titleArray = [NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil];
    for (int j = 0; j < titleArray.count; j++) {
        
        CGFloat x = j%3 * largeWidth + littleWidth;
        CGFloat y = j/3 * OneRowHeight + frameView.size.height;
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(x, y, largeWidth, OneRowHeight);
        [button setTitle:titleArray[j] forState:0];
        [button setTitleColor:GC.CBlack forState:0];
        [button.titleLabel setFont:FontSize(18)];
        [button setBackgroundColor:GC.CWhite];
        
        button.tag = 2003 + j;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [button addTarget:self action:@selector(buttonDown:) forControlEvents:UIControlEventTouchDown];
        [button addTarget:self action:@selector(buttonCancel:) forControlEvents:UIControlEventTouchCancel|UIControlEventTouchDragOutside];
        [_keyMainView addSubview:button];
        
        [GeneralUIUse AddLineUp:button Color:GC.LINE LeftOri:0 RightOri:0];
        [GeneralUIUse AddLineLeft:button Color:GC.LINE UpOri:0 DownOri:0];
    }
    
    // 删除按钮
    UIButton * deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat delX = 3 * largeWidth + littleWidth;
    deleteButton.frame = CGRectMake(delX, frameView.size.height, littleWidth, OneRowHeight);
    [deleteButton setImage:_pickupKey forState:0];         // ImageName(@"keyboard_pickup")
    [deleteButton setBackgroundColor:GC.CWhite];
    
    deleteButton.tag = 2100;
    [deleteButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [deleteButton addTarget:self action:@selector(buttonDown:) forControlEvents:UIControlEventTouchDown];
    [deleteButton addTarget:self action:@selector(buttonCancel:) forControlEvents:UIControlEventTouchCancel|UIControlEventTouchDragOutside];
    [_keyMainView addSubview:deleteButton];
    
    [GeneralUIUse AddLineUp:deleteButton Color:GC.LINE LeftOri:0 RightOri:0];
    [GeneralUIUse AddLineLeft:deleteButton Color:GC.LINE UpOri:0 DownOri:0];
    
    // 完成按钮
    UIButton * finalButton = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat finalY = OneRowHeight + frameView.size.height;
    finalButton.frame = CGRectMake(delX, finalY, littleWidth, OneRowHeight * 2);
    [finalButton setImage:_delKey forState:0];                 // ImageName(@"keyboard_delete")
    [finalButton setTitleColor:GC.CWhite forState:0];
    [finalButton setBackgroundColor:GC.CWhite];
    
    finalButton.tag = 2101;
    [finalButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [finalButton addTarget:self action:@selector(buttonDown:) forControlEvents:UIControlEventTouchDown];
    [finalButton addTarget:self action:@selector(buttonCancel:) forControlEvents:UIControlEventTouchCancel|UIControlEventTouchDragOutside];
    [_keyMainView addSubview:finalButton];
    
    [GeneralUIUse AddLineUp:finalButton Color:GC.LINE LeftOri:0 RightOri:0];
    [GeneralUIUse AddLineLeft:finalButton Color:GC.LINE UpOri:0 DownOri:0];
    
    frameView.size.height += 3 * OneRowHeight;
    
    // 底部背景
    if (_footView) {
        CGRect fFrame = _footView.frame;
        fFrame.origin.y = frameView.size.height;
        _footView.frame = fFrame;
        [_keyMainView addSubview:_footView];
        
        frameView.size.height += _footView.frame.size.height;
    }
    
    _keyMainView.frame = frameView;
}

#pragma mark - 点击方法
- (void)buttonDown:(UIButton *)sender {
    if (sender.tag == 2102) {
        // 保存按钮
        UIView * view = [_keyMainView viewWithTag:2200];
        [view setBackgroundColor:kUIColorFromRGB(0xF29600)];
        
    } else {
        sender.backgroundColor = selectBColor;
    }
    
}

- (void)buttonCancel:(UIButton *)sender {
    if (sender.tag == 2102) {
        // 保存按钮
        UIView * view = [_keyMainView viewWithTag:2200];
        [view setBackgroundColor:kUIColorFromRGB(0xFC9F06)];
        
    } else {
        [sender setBackgroundColor:GC.CWhite];
    }
    
    
}

- (void)buttonAction:(UIButton *)sender {
    
    // 播放一个输入的声音
    [[UIDevice currentDevice] playInputClick];
    [sender setBackgroundColor:GC.CWhite];
    
    NSString * key = @"";
    if (sender.tag == 2100) {
        // 收键盘
        key = @"*";
        [_toTextView resignFirstResponder];
        
    }else if (sender.tag == 2101) {
        // 图标删除
        [_toTextView deleteBackward];
        
    }else if (sender.tag == 2102) {
        // 保存
        key = @"#";
        UIView * view = [_keyMainView viewWithTag:2200];
        [view setBackgroundColor:GC.MC];
        [sender setBackgroundColor:[UIColor clearColor]];
        
    }else if (sender.tag == 2103) {
        // 文字删除
        key = @"#*";
        [_toTextView resignFirstResponder];
        
    } else {
        
        key = sender.currentTitle;
        if ([key isEqualToString:@"·"]) {
            key = @".";
        }
        
        NSRange r1 = NSMakeRange(_toTextView.text.length, 1);
        BOOL isInsert = YES;
        if ([_toTextView.delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
            isInsert = [_toTextView.delegate textField:_toTextView shouldChangeCharactersInRange:r1 replacementString:key];
        }
        
        if (isInsert) {
            [_toTextView insertText:key];
        }
        
    }
    
}

#pragma mark keyboard NSNotification
- (void)keyboardWillHideNotification:(NSNotification *)notif {
    NSTimeInterval duration = 0;
//    UIViewAnimationOptions options;
    if ([notif.name isEqualToString:UIKeyboardWillHideNotification] && notif.userInfo){
        NSNumber *durationNumber = notif.userInfo[UIKeyboardAnimationDurationUserInfoKey];
        duration = durationNumber.doubleValue;
        
//        NSNumber *curveNumber = notif.userInfo[UIKeyboardAnimationCurveUserInfoKey];
//        UIViewAnimationCurve curve = curveNumber.integerValue;
//        UIViewAnimationOptions options = curve << 16;
    }
    
    
    [self performSelector:@selector(reductionView) withObject:nil afterDelay:duration/2];
    
    [self performSelector:@selector(keyBoardDismiss) withObject:nil afterDelay:duration];
}

- (void)reductionView {
    if (subFootView && _footView) {
        _footView.frame = orgFootFrame;
        [subFootView addSubview:_footView];
    }
}

@end
