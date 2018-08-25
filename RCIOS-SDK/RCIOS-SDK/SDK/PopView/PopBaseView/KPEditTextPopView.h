//
//  KPEditTextPopView.h
//  kpkd
//
//  Created by gzkp on 2017/8/7.
//  Copyright © 2017年 kptech. All rights reserved.
//

#import "PopBaseView.h"

typedef void(^Confirm)(NSString *title);
typedef void(^Delete)(void);

typedef enum : NSUInteger {
    EditTag = 100,
    
    
} EditType;

typedef enum : NSUInteger {
    AddTag = 0,
    AddPayment = 1,
    
    
} AddType;

@interface KPEditTextPopView : PopBaseView

@property NSInteger textType;

@property (nonatomic,strong) UITextField *unitTextField;
@property (nonatomic,assign) NSTextAlignment contentAligment;
@property (nonatomic,assign) NSTextAlignment titleAligment;
@property (nonatomic,assign) EditType editType;
@property (nonatomic,assign) AddType addType;
@property (nonatomic,assign) NSInteger maxLength;
@property (nonatomic,strong) NSArray *verifyArray;

- (instancetype)initWithTitle:(NSString*)title placeHoldTitle:(NSString*)placeHoldTitle cancelBtnTitle:(NSString*)cancelBtnTitle content:(NSString *)content okBtnTitle:(NSString*)okBtnTitle makeSure:(Confirm)makeSure cancel:(Cancel)cancel;

- (instancetype)initWithTitle:(NSString*)title placeHoldTitle:(NSString*)placeHoldTitle cancelBtnTitle:(NSString*)cancelBtnTitle okBtnTitle:(NSString*)okBtnTitle rightText:(NSString *)rightText makeSure:(Confirm)makeSure cancel:(Cancel)cancel;

@end


