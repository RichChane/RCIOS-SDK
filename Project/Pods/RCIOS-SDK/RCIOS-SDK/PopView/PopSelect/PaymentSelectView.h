//
//  PaymentSelectView.h
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

typedef enum : NSUInteger {
    POPShowFromBottom,
    POPShowFromTop,
    POPShowFromCenter,
} POPShowType;


typedef void(^SelectPayType)(NSInteger tag);

@interface PaymentSelectView : UIView

@property (nonatomic,copy) SelectPayType selectType;
@property (nonatomic,assign) CGFloat originX;
@property (nonatomic,assign) CGFloat originY;
@property (nonatomic,assign) POPShowType popType;

- (id)initWithSelectArr:(NSArray *)selectArr selectIndex:(NSInteger)selectIndex;

- (id)initWithSelectArr:(NSArray *)selectArr selectIndex:(NSInteger)selectIndex title:(NSString *)title rowNum:(NSInteger)rowNum;

- (id)initWithOriginY:(CGFloat)originY SelectArr:(NSArray *)selectArr selectIndex:(NSInteger)selectIndex title:(NSString *)title rowNum:(NSInteger)rowNum;

- (id)initWithOriginY:(CGFloat)originY SelectArr:(NSArray *)selectArr selectIndex:(NSInteger)selectIndex title:(NSString *)title rowNum:(NSInteger)rowNum hasCancelBtn:(BOOL)hasCancelBtn;

-(void)showPopView;

-(void)dismissPopView;

@end

