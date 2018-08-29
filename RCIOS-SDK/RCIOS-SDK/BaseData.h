//
//  BaseData.h
//  RCIOS-SDK
//
//  Created by gzkp on 2018/8/22.
//  Copyright © 2018年 RC. All rights reserved.
//

#ifndef BaseData_h
#define BaseData_h

// size
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define dis_LEFTSCREEN 15
#define ASIZE(x) x

// color
#define kUIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define kUIColorFromRGBAlpha(rgbValue,al) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:al]
#define RGB(r,g,b) [UIColor colorWithRed:r/255. green:g/255. blue:b/255. alpha:1]
#define LineColor RGB(221,221,221);
#define WHITE_COLOR [UIColor whiteColor]

// font
#define FontSize(x) [UIFont systemFontOfSize:x]

// init
#define ImageName(name)     [UIImage imageNamed:name]
#define ML(key) key

// weak - strong
#define RCWeak(o) autoreleasepool{} __weak typeof(o) o##Weak = o;
#define RCStrong(o) autoreleasepool{} __strong typeof(o) o = o##Weak;


#endif /* BaseData_h */
