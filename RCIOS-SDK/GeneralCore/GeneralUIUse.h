//
//  GeneralUIUse.h
//  Pods
//
//  Created by gzkp on 2018/10/19.
//

#import <UIKit/UIkit.h>



@interface GeneralUIUse : NSObject

/**
 部署上线段
 
 @param l_view 控件
 @param l_color 线段颜色
 @param ori_l 左偏移
 @param oti_r 右偏移
 */
+ (void)AddLineUp:(UIView *)l_view Color:(UIColor *)l_color LeftOri:(CGFloat)ori_l RightOri:(CGFloat)oti_r;


/**
 部署左线段
 
 @param l_view 控件
 @param l_color 线段颜色
 @param ori_up 左偏移
 @param ori_down 右偏移
 */
+ (void)AddLineLeft:(UIView *)l_view Color:(UIColor *)l_color UpOri:(CGFloat)ori_up DownOri:(CGFloat)ori_down;


@end


