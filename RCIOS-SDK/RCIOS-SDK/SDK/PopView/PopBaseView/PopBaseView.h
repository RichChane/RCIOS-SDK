//
//  PopBaseView.h
//  RCIOS-SDK
//
//  Created by gzkp on 2018/8/22.
//  Copyright © 2018年 RC. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^Cancel)(void);
typedef void(^MakeSure)(void);

@interface PopBaseView : UIView

@property (nonatomic,strong) UIView *topView;
@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,copy) Cancel cancel;
@property (nonatomic,copy) MakeSure makeSure;

- (instancetype)initWithCancelBtnTitle:(NSString*)cancelBtnTitle okBtnTitle:(NSString*)okBtnTitle;
- (void)refreshCenterView:(UIView *)topView contentView:(UIView *)contentView;

-(void)showPopView;

//action
-(void)clickCancleBtn:(UIButton*)sender;
-(void)clickSureBtn:(UIButton*)sender;

@end
