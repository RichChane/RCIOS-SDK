//
//  KPEditUintPopView.h
//  kpkd
//
//  Created by gzkp on 2017/7/26.
//  Copyright © 2017年 kptech. All rights reserved.
//

//  用于 新增、编辑 商品单位
#import "PopBaseView.h"

typedef void(^Confirm)(NSString *unitTitle,double number,BOOL isDefaultUnit);
typedef void(^Delete)(void);


@interface KPEditUintPopView : PopBaseView

@property (nonatomic,assign) NSTextAlignment contentAligment;
@property (nonatomic,assign) NSTextAlignment titleAligment;


- (instancetype)initWithTitle:(NSString*)title unitTitle:(NSString*)unitTitle number:(double)number baseUnitTitle:(NSString*)baseUnitTitle isDefaultUnit:(BOOL)isDefaultUnit cancelBtnTitle:(NSString*)cancelBtnTitle okBtnTitle:(NSString*)okBtnTitle  makeSure:(ConfirmV3)makeSure cancel:(Cancel)cancel delete:(Delete)deleteAction;

- (void)showPopView:(UIView *)view;

@end
