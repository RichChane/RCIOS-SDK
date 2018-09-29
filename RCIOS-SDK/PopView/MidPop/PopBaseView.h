//
//  PopBaseView.h
//  RCIOS-SDK
//
//  Created by gzkp on 2018/8/22.
//  Copyright © 2018年 RC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RCIOS-SDK/BaseData.h>
#import <RCIOS-SDK/GeneralCore.h>
#import <RCIOS-SDK/KPTextField.h>
#import "NSString+Size.h"
#import "UIFactory.h"

#define POPShow @"POPShow"
#define POPDismiss @"POPDismiss"

typedef enum : NSUInteger {
    KPPopTypeNormal,
    KPPopTypeExplain,
    
} KPPopType;

typedef void(^Cancel)(void);
typedef void(^MakeSure)(void);
typedef void(^ConfirmV3)(NSString *unitTitle,double number,BOOL isDefaultUnit);
typedef void(^ConfirmV2)(NSString *code,int32_t type);
typedef void(^ConfirmV1)(id objc);

@interface PopBaseView : UIView

@property (nonatomic,strong) UIView *topView;
@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,strong) UIButton *cancelBtn;
@property (nonatomic,strong) UIButton *okBtn;
@property (nonatomic,assign) KPPopType popType;
@property (nonatomic,copy) Cancel cancel;
@property (nonatomic,copy) MakeSure makeSure;
@property (nonatomic,copy) ConfirmV1 confirmV1;
@property (nonatomic,copy) ConfirmV2 confirmV2;
@property (nonatomic,copy) ConfirmV3 confirmV3;

- (instancetype)initWithCancelBtnTitle:(NSString*)cancelBtnTitle okBtnTitle:(NSString*)okBtnTitle;
- (void)refreshCenterView:(UIView *)topView contentView:(UIView *)contentView;

-(void)showPopView;

//action
-(void)clickCancleBtn:(UIButton*)sender;
-(void)clickSureBtn:(UIButton*)sender;

@end
