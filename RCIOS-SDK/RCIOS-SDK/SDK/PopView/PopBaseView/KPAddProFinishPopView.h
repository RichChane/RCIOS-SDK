//
//  KPAddProFinishPopView.h
//  kpkd
//
//  Created by gzkp on 2017/8/11.
//  Copyright © 2017年 kptech. All rights reserved.
//

#import "PopBaseView.h"



typedef void(^ClickBtnAction)(NSInteger index);


@interface KPAddProFinishPopView : PopBaseView

@property (nonatomic,copy) ClickBtnAction clickBtnAction;

- (instancetype)initTextArray:(NSArray*)textArray imageArray:(NSArray*)imageArray clickBtnAction:(ClickBtnAction)clickBtnAction;

@end
