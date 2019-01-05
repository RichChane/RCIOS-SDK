//
//  RCTabbarController.m
//  RCIOS-SDK
//
//  Created by gzkp on 2019/1/4.
//  Copyright © 2019年 RC. All rights reserved.
//

#import "RCTabbarController.h"

@interface RCTabbarController ()

@end

@implementation RCTabbarController


/*
 
 layoutControllerSubViews 刷新view frame
 displayViewAtIndex 选择tab回调 展示vc
 
 */

- (id)initWithViewControllers:(NSArray *)vcs BarImage:(NSArray *)bArr BarBgImage:(UIImage *)img
{
    ballView = nil;
    
    if (!(vcs && bArr && [vcs count] == [bArr count])) {
        return nil;
    }
    self = [super init];
    if (self)
    {

        viewControllers = [NSMutableArray arrayWithArray:vcs];
        
        animateDriect = 0;
        _selectIndex = -1;
        
        _myTabBar = [[RCTabBar alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, GC.tabBarHeight) buttonImages:bArr ShowHeight:GC.tabBarHeight];
        _myTabBar.delegate = self;
        _myTabBar.backgroundColor = [UIColor whiteColor];
        //[GeneralUIUse AddLineUp:_myTabBar Color:kUIColorFromRGB(0xD4D4D4) LeftOri:0 RightOri:0];
        //        if (img) {
        //            [_myTabBar setBackgroundImage:img];
        //        }
        

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(layoutControllerSubViews) name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
}




@end
