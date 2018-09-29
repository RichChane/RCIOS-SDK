//
//  ShareBottomPopView.h
//  kp
//
//  Created by gzkp on 2017/11/8.
//  Copyright © 2017年 kptech. All rights reserved.
//

#import "BottomPopView.h"


typedef void(^ClickBtnAction)(NSInteger index);

@interface ShareBottomPopView : BottomPopView

@property (nonatomic,copy) ClickBtnAction clickBtnAction;


- (instancetype)initTextArray:(NSArray*)textArray imageArray:(NSArray*)imageArray clickBtnAction:(ClickBtnAction)clickBtnAction;


@end
