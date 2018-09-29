//
//  WPNormalPopView.h
//  RCIOS-SDK
//
//  Created by gzkp on 2018/8/22.
//  Copyright © 2018年 RC. All rights reserved.
//

#import "PopBaseView.h"

@interface WPNormalPopView : PopBaseView

@property (nonatomic,strong) UILabel *contentLabel;
@property (nonatomic,assign) NSTextAlignment contentAligment;
@property (nonatomic,assign) NSTextAlignment titleAligment;


- (instancetype)initWithTitle:(NSString*)title content:(NSString*)content cancelBtnTitle:(NSString*)cancelBtnTitle okBtnTitle:(NSString*)okBtnTitle  makeSure:(MakeSure)makeSure cancel:(Cancel)cancel;

- (instancetype)initWithTitle:(NSString*)title content:(NSString*)content alertTitle:(NSString *)alertTitle cancelBtnTitle:(NSString*)cancelBtnTitle okBtnTitle:(NSString*)okBtnTitle  makeSure:(MakeSure)makeSure cancel:(Cancel)cancel;

//富文本展示
- (instancetype)initAttriWithTitle:(NSString*)title contents:(NSArray*)contents colors:(NSArray *)colors cancelBtnTitle:( NSString*)cancelBtnTitle okBtnTitle:(NSString*)okBtnTitle  makeSure:(MakeSure)makeSure cancel:(Cancel)cancel;

@end
