//
//  SelectGroupView.h
//  kp
//
//  Created by gzkp on 2017/6/8.
//  Copyright © 2017年 kptech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseData.h"
#import "GeneralCore.h"
#import "KPTextField.h"
#import "NSString+Size.h"
#import "UIFactory.h"

@interface SelectGroupView : UIView

- (instancetype)initWithFrame:(CGRect)frame  title:(NSString *)title;

- (void)setViewStatusNormal;

- (void)setViewStatusSelected;

- (void)addTarget:(id)target action:(nonnull SEL)action;

@end
