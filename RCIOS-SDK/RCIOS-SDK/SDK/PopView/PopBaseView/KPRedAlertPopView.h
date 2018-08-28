//
//  KPRedAlertPopView.h
//  RCIOS-SDK
//
//  Created by gzkp on 2018/8/25.
//  Copyright © 2018年 RC. All rights reserved.
//

#import "PopBaseView.h"

@interface KPRedAlertPopView : PopBaseView

/*
 
 alertPopType
 0:普通alert
 1:更换管理员alert
 
 */
@property (nonatomic,assign) NSInteger alertPopType;
@property (nonatomic,strong) NSString *account;


- (instancetype)initWithImage:(UIImage *)image title:(NSString*)title content:(NSString *)content cancelBtnTitle:(NSString*)cancelBtnTitle okBtnTitle:(NSString*)okBtnTitle  makeSure:(ConfirmV2)makeSure cancel:(Cancel)cancel;

@end
