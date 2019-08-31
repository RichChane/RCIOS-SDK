//
//  LittleImageBigControl.h
//  YBar
//
//  Created by Rich on 16/5/28.
//  Copyright © 2016年 Rich. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LittleImageBigControl : UIControl

+ (LittleImageBigControl*)createTopRightControlWithSize:(CGSize)size littleImage:(UIImage *)littleImage;

+ (LittleImageBigControl*)createControlWithSize:(CGSize)size imageName:(NSString *)imageName;

+ (LittleImageBigControl*)createControlWithBigFrame:(CGRect)bigFrame littleSize:(CGSize)littleSize imageName:(NSString *)imageName;

@end
