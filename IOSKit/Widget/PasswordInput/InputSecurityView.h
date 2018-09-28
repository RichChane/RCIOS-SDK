//
//  InputSecurityView.h
//  kp
//
//  Created by gzkp on 2018/4/11.
//  Copyright © 2018年 kptech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RCIOS-SDK/BaseData.h>
#import <RCIOS-SDK/GeneralCore.h>

@interface InputSecurityView : UIView

/* 传空为默认 */
- (void)setSecurityImage:(UIImage *)image;

/* 传空为不输入*/
- (void)setText:(NSString *)text;

@end
