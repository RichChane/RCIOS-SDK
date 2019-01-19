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
        
        _myTabBar = [[RCTabBar alloc] initWithFrame:CGRectMake(0, 500, [UIScreen mainScreen].bounds.size.width, GC.tabBarHeight) buttonImages:bArr ShowHeight:GC.tabBarHeight];
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    //    [self.view addSubview:_sideBar];
    [self.view setBackgroundColor:GC.BG];
    
    for (NSInteger i = 0; i < [viewControllers count]; i++) {
        [self addChildViewController:viewControllers[i]];
    }
    self.selectIndex = 0;
    
    //[self hidesTabBar:NO animated:YES];
    [self.view addSubview:_myTabBar];
    
    
    
    [self layoutControllerSubViews];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    _myTabBar = nil;
    viewControllers = nil;
}

- (void)layoutControllerSubViews{

    CGRect rFrame = [UIScreen mainScreen].bounds;
    rFrame.origin.y = GC.topBarNowHeight - GC.topBarNormalHeight;
    rFrame.size.height -= (GC.topBarNowHeight - GC.topBarNormalHeight);
    [self.view setFrame:rFrame];
    _myTabBar.frame = CGRectMake(0, self.view.height-GC.tabBarHeight, [UIScreen mainScreen].bounds.size.width, GC.tabBarHeight);
    
    if (rFrame.origin.y > 1) {
        // 兼容通话时变更高度        // 在通话时，nav的偏移量会从64变为44 不是 88，所以高度要缩小20     // iphonex,不会执行
        rFrame = self.view.bounds;
        rFrame.size.height -= 20;
        for (NSInteger i = 0; i < [viewControllers count]; i++) {
            id vc = viewControllers[i];
            if ([vc isKindOfClass:[UINavigationController class]]) {
                [((UINavigationController *)vc).view setFrame:rFrame];
                
            }else if ([vc isKindOfClass:[UIViewController class]]){
                [((UIViewController *)vc).view setFrame:rFrame];
            }
        }
        
    } else {
        for (NSInteger i = 0; i < [viewControllers count]; i++) {
            id vc = viewControllers[i];
            if ([vc isKindOfClass:[UINavigationController class]]) {
                [((UINavigationController *)vc).view setFrame:self.view.bounds];
                
            }else if ([vc isKindOfClass:[UIViewController class]]){
                [((UIViewController *)vc).view setFrame:self.view.bounds];
            }
        }
    }
    
    if ([self.selectedNowController respondsToSelector:@selector(viewWillAppear:)]) {
        [self.selectedNowController performSelector:@selector(viewWillAppear:) withObject:nil afterDelay:0.1];
    }
}

#pragma mark - Private methods
- (void)displayViewAtIndex:(NSUInteger)index
{
    if (_selectIndex == index) {
        
    }else{
        lastIndex = _selectIndex;     // 记录上次
        _selectIndex = index;
    }
    
    id navVC = [viewControllers objectAtIndex:_selectIndex];
    if (navVC && [((GeneralViewController *)navVC).view isDescendantOfView:self.view]){
        // 已经加载过试图
        GeneralViewController *gvController = nil;
        if (navVC && [navVC isKindOfClass:[UINavigationController class]]) {
            if ([[navVC viewControllers] count] > 1) {
                [navVC popToRootViewControllerAnimated:NO];
            }
            
            gvController = (GeneralViewController *)[navVC visibleViewController];
            
        } else {
            gvController = navVC;
        }
        
        if (gvController && [gvController respondsToSelector:@selector(viewWillAppear:)])
            [gvController viewWillAppear:NO];
        
    }else{
        // 未加载试图
        [self.view addSubview:((GeneralViewController *)navVC).view];
    }
    
    for (UIView *view_ in [self.view subviews]) {
        if (view_ != ((GeneralViewController *)navVC).view && view_ != _myTabBar) {
            [view_ removeFromSuperview];
        }
    }
    
    [self.view bringSubviewToFront:((GeneralViewController *)navVC).view];
    if (ballView) {
        [self.view bringSubviewToFront:ballView];
    }
    [self.view bringSubviewToFront:_myTabBar];
    
    //    [selectedVC.view setAlpha:1.0];
    //    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut
    //                     animations:^{
    //                         [selectedVC.view setAlpha:1];
    //                     }
    //                     completion:^(BOOL finished){
    //                     }
    //     ];
}


- (void)hidesTabBar:(BOOL)yesOrNO animated:(BOOL)animated
{
    if (yesOrNO == YES)
    {
        if (_myTabBar.frame.origin.y == self.view.frame.size.height)
            return;
//        else{
//            CGRect frame = _myTabBar.frame;
//            frame.origin.y = self.view.frame.size.height;
//            _myTabBar.frame = frame;
//        }
    }
    else
    {
        if (_myTabBar.frame.origin.y == self.view.frame.size.height - GC.tabBarOriginalHeight)
            return;
//        else{
//            CGRect frame = _myTabBar.frame;
//            frame.origin.y = self.view.frame.size.height - GC.tabBarOriginalHeight;
//            _myTabBar.frame = frame;
//
//        }
    }
    
    if (animated == YES)
    {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             if (yesOrNO == YES)
                                 _myTabBar.frame = CGRectMake(_myTabBar.frame.origin.x, self.view.frame.size.height, _myTabBar.frame.size.width, _myTabBar.frame.size.height);
                             else
                                 _myTabBar.frame = CGRectMake(_myTabBar.frame.origin.x, self.view.frame.size.height - GC.tabBarOriginalHeight, _myTabBar.frame.size.width, _myTabBar.frame.size.height);
                         }
                         completion:^(BOOL finished){
                             
                         }
         ];
    }
    else
    {
        if (yesOrNO == YES)
            _myTabBar.frame = CGRectMake(_myTabBar.frame.origin.x, self.view.frame.size.height, _myTabBar.frame.size.width, _myTabBar.frame.size.height);
        else
            _myTabBar.frame = CGRectMake(_myTabBar.frame.origin.x, self.view.frame.size.height - GC.tabBarOriginalHeight, _myTabBar.frame.size.width, _myTabBar.frame.size.height);
    }
}


- (GeneralViewController *)selectedNowController
{
    id vc = [viewControllers objectAtIndex:_selectIndex];
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [[(UINavigationController *)vc viewControllers] lastObject];
    }else{
        return vc;
    }
    
}

-(void)setSelectIndex:(NSUInteger)index
{
    [self tabBar:_myTabBar didSelectIndex:index];
}
- (void)backLastIndex{
    if (lastIndex == _selectIndex)
        return;
    
    self.selectIndex = lastIndex;
}

- (void)removeViewControllerAtIndex:(NSUInteger)index
{
    if (index >= [viewControllers count])
        return;
    // Remove view from superview.
    UINavigationController *nav = [viewControllers objectAtIndex:index];
    [[nav view] removeFromSuperview];
    [nav removeFromParentViewController];
    // Remove viewcontroller in array.
    [viewControllers removeObjectAtIndex:index];
    // Remove tab from tabbar.
    [_myTabBar removeTabAtIndex:index];
}
- (void)removeAllController{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    for (NSInteger i = [viewControllers count] - 1; i >= 0; i--) {
        [self removeViewControllerAtIndex:i];
    }
}
#pragma mark - tabBar delegates
- (void)tabBar:(RCTabBar *)tabBar didSelectIndex:(NSInteger)index
{
    
    [self displayViewAtIndex:index];
    
    [_myTabBar selectTabAtIndex:_selectIndex];
}
// 添加红的监控
- (void)addBallTag:(UIView *)item{
    if (ballView) {
        [ballView attach:item];
    }
}
- (void)cleanAllBall{
    if (ballView) {
        [ballView cleanAllItem];
    }
    
//    if ([MainHandle Share].ballBack) {
//        [MainHandle Share].ballBack();
//    }
}

@end
