//
//  UpImgDownTextBtn.h
//  kpkd
//
//  Created by gzkp on 2017/8/11.
//  Copyright © 2017年 kptech. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    DireUpImage,
    DireDownImage,
    DireLeftImage,
    DireRightImage
} Direction;




@interface UpImgDownTextBtn : UIButton

- (id)initWithFrame:(CGRect)frame image:(UIImage *)image text:(NSString *)text direction:(Direction)direction;

- (void)setImageShow:(BOOL)isShow;

@end
