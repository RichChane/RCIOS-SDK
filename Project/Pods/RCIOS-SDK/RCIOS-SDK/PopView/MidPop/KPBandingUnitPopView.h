//
//  KPBandingUnitPopView.h
//  kpkd
//
//  Created by gzkp on 2017/8/10.
//  Copyright © 2017年 kptech. All rights reserved.
//

#import "PopBaseView.h"

typedef void(^SelectUnitBlock)(int selectIndex);

@interface KPBandingUnitPopView : PopBaseView

@property (nonatomic,copy) SelectUnitBlock selectUnit;
@property (nonatomic,assign) int selectIndex;

- (instancetype)initWithTitle:(NSString*)title content:(NSString*)content unitArr:(NSArray*)unitArr selectUnit:(SelectUnitBlock)selectUnit;


@end
