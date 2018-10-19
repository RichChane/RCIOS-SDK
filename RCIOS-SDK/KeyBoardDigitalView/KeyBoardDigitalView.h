//
//  KeyBoardDigitalView.h
//  kpkd
//
//  Created by zyy on 2018/5/22.
//  Copyright © 2018年 kptech. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 自定义键盘，默认高度 ASIZE(201)
@interface KeyBoardDigitalView : NSObject

@property (nonatomic, weak, readonly) UITextField * toTextView;
@property (nonatomic, strong, readonly) UIView * keyMainView;           // 键盘View

@property (nonatomic, weak) UIView * headView;        // 顶部的视图
@property (nonatomic, weak) UIView * footView;        // 底部的视图 存放删除和保存按钮

@property (nonatomic, weak) UIView * upToView;        // 把视图 移动到键盘顶部，如果view 包含了textview就只能移动

@property (nonatomic, strong) UIImage * delKey;        // 删除键图片
@property (nonatomic, strong) UIImage * pickupKey;           // 收起键

+ (UIButton *)FootSaveButton:(CGRect)bFrame;           // 获取通用保存按钮 （配合了键盘）

+ (instancetype)getInstance;

- (void)setKeyBoardInputView:(UITextField *)textField;

@end
