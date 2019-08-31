//
//  GeneralUIUse.m
//  Pods
//
//  Created by gzkp on 2018/10/19.
//

#import "GeneralUIUse.h"

#define UpLineTag           78763
#define DownLineTag           78762

#define LeftLineTag           78764
#define RightLineTag           78765

@implementation GeneralUIUse

+ (void)AddLineUp:(UIView *)l_view Color:(UIColor *)l_color LeftOri:(CGFloat)ori_l RightOri:(CGFloat)oti_r{
    if (!l_view || !l_color)
        return;
    
    id down_line = nil;
    for (UIView *view_ in [l_view subviews]) {
        if (view_.tag == DownLineTag) {
            down_line = view_;
            break;
        }
    }
    if (down_line) {
        [down_line removeFromSuperview];
        down_line = nil;
    }
    
    id up_line = nil;
    for (UIView *view_ in [l_view subviews]) {
        if (view_.tag == UpLineTag) {
            up_line = view_;
            break;
        }
    }
    if (up_line && [up_line isKindOfClass:[UIView class]]) {
        [up_line setBackgroundColor:l_color];
        return;
    }
    
    up_line = [[UIView alloc]initWithFrame:CGRectMake(ori_l, 0, l_view.frame.size.width - ori_l - oti_r, 0.5)];
    [up_line setTag:UpLineTag];
    [up_line setBackgroundColor:l_color];
    [l_view addSubview:up_line];
}

+ (void)AddLineLeft:(UIView *)l_view Color:(UIColor *)l_color UpOri:(CGFloat)ori_up DownOri:(CGFloat)ori_down{
    if (!l_view || !l_color)
        return;
    
    id left_line = [l_view viewWithTag:LeftLineTag];
    if (left_line && [left_line isKindOfClass:[UIView class]]) {
        [left_line setBackgroundColor:l_color];
        return;
    }
    
    left_line = [[UIView alloc]initWithFrame:CGRectMake(0, ori_up, 0.5, l_view.frame.size.height - ori_up - ori_down)];
    [left_line setBackgroundColor:l_color];
    [left_line setTag:LeftLineTag];
    [l_view addSubview:left_line];
}


@end
