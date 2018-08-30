//
//  BottomPopView.h
//  kp
//
//  Created by gzkp on 2017/7/14.
//  Copyright © 2017年 kptech. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SelectPayType)(NSInteger tag);

@interface BottomPopView : UIView

@property (nonatomic,copy) SelectPayType selectType;

- (id)initWithSelectArr:(NSArray *)selectArr selectIndex:(NSInteger)selectIndex;

-(void)showPopView;

-(void)dismissPopView;



@end
