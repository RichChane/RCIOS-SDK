//
//  GeneralCore.m
//  RCIOS-SDK
//
//  Created by gzkp on 2018/8/23.
//  Copyright © 2018年 RC. All rights reserved.
//

#import "GeneralCore.h"

@implementation GeneralCore

+ (GeneralCore *)getInstance

{
    static GeneralCore *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[self alloc]init];
        
        shareInstance.BG = kUIColorFromRGB(0xEFEFF4);
        shareInstance.LINE = RGB(221,221,221);
        shareInstance.MC = kUIColorFromRGB(0xFC9F06);
        //shareInstance.MC = kUIColorFromRGB(0xFF675E);
        
        shareInstance.CWhite = [UIColor whiteColor];
        shareInstance.CBlack = [UIColor blackColor];

        
    });
    
    return shareInstance;
    
}




@end
