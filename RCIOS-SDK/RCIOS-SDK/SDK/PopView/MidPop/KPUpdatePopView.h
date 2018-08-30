//
//  KPUpdatePopView.h
//  RCIOS-SDK
//
//  Created by gzkp on 2018/8/22.
//  Copyright © 2018年 RC. All rights reserved.
//

#import "PopBaseView.h"

@interface KPUpdatePopView : PopBaseView

- (instancetype)initWithTitle:(NSString*)mainTitle subTitle:(NSString *)subTitle topImage:(UIImage *)topImage content:(NSString*)content cancelBtnTitle:(NSString*)cancelBtnTitle okBtnTitle:(NSString*)okBtnTitle  makeSure:(MakeSure)makeSure cancel:(Cancel)cancel;

@end
