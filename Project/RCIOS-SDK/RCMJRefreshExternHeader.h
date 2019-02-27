//
//  RCMJRefreshNormalHeader.h
//  RCIOS-SDK
//
//  Created by gzkp on 2019/2/23.
//  Copyright © 2019年 RC. All rights reserved.
//

#import "RCMJRefreshHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface RCMJRefreshExternHeader : RCMJRefreshHeader

@property (weak, nonatomic, readonly) UIImageView *arrowView;
/** 菊花的样式 */
@property (assign, nonatomic) UIActivityIndicatorViewStyle activityIndicatorViewStyle;

- (void)addExternView:(UIView *)externView;

@end

NS_ASSUME_NONNULL_END
