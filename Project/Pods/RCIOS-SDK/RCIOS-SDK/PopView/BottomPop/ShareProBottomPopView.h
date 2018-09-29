//
//  ShareProBottomPopView.h
//  kp
//
//  Created by gzkp on 2018/6/4.
//  Copyright © 2018年 kptech. All rights reserved.
//

#import "BottomPopView.h"


typedef void(^ClickBtnAction)(NSInteger index);

@interface ShareProBottomPopView : BottomPopView

@property (nonatomic,copy) ClickBtnAction clickBtnAction;


- (instancetype)initTextArray:(NSArray*)textArray imageArray:(NSArray*)imageArray clickBtnAction:(ClickBtnAction)clickBtnAction;


@end
