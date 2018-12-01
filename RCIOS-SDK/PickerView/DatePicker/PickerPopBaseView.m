//
//  PickerPopBaseView.m
//  FMDB
//
//  Created by gzkp on 2018/12/1.
//

#import "PickerPopBaseView.h"
#import "UIView+YYAdd.h"
#import "BaseData.h"


@interface PickerPopBaseView()




@end



@implementation PickerPopBaseView


- (void)showInView:(UIView *)superView
{
    [superView addSubview:self];
    self.size = superView.size;
    self.origin = CGPointZero;
    if (self.popDirection == PopDirectionBottom) {
//        CGRect frameContent =  self.contentView.frame;
//        frameContent.origin.y =superView.height-self.contentView.height;
//        self.frame = frameContent;
    }else if (self.popDirection == PopDirectionTop){
//        CGRect frameContent =  self.contentView.frame;
//        frameContent.origin.y = _distanceOrigin;
//        self.frame = frameContent;
        
        
    }else {
        
        CGRect frameContent =  self.contentView.frame;
        frameContent.origin.y -= (self.height+self.contentView.height)/2;
        self.frame = frameContent;
    }
    
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self];
    
    if (self.popDirection == PopDirectionBottom) {
        self.contentView.frame = CGRectMake(0, self.contentView.height, self.contentView.width, self.contentView.height);
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            [self.layer setOpacity:1.0];
            self.contentView.frame = CGRectMake(0, 0, self.contentView.width, self.contentView.height);
        } completion:^(BOOL finished) {
        }];
    }else if (self.popDirection == PopDirectionTop){
        
        self.backgroundColor = [UIColor clearColor];
        CGRect frameContent =  self.contentView.frame;
        frameContent.origin.y = _distanceOrigin;
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, _distanceOrigin, self.width, self.height-_distanceOrigin)];
        bgView.backgroundColor = RGBA(0, 0, 0, 102.0/255);
        [self addSubview:bgView];
        [self sendSubviewToBack:bgView];
        [bgView addSubview:self.contentView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectedCancel)];
        [bgView addGestureRecognizer:tap];
        
        self.contentView.frame = CGRectMake(0, -self.contentView.height, self.contentView.width, self.contentView.height);
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            [self.layer setOpacity:1.0];
            self.contentView.frame = CGRectMake(0, 0, self.contentView.width, self.contentView.height);
        } completion:^(BOOL finished) {
        }];
        
    }else {
        
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            [self.layer setOpacity:1.0];
            self.contentView.frame = CGRectMake(0, 0, self.contentView.width, self.contentView.height);
        } completion:^(BOOL finished) {
        }];
    }
    
}

- (void)show
{
    [self showInView:[UIApplication sharedApplication].keyWindow];
    
}


- (void)removeSelf
{
    if (self.contentMode == PopDirectionBottom) {
        CGRect frameContent =  self.contentView.frame;
        frameContent.origin.y += self.contentView.height;
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            [self.layer setOpacity:0.0];
            self.contentView.frame = frameContent;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }else if (self.contentMode == PopDirectionTop){
        
        CGRect frameContent =  self.contentView.frame;
        frameContent.origin.y = -CGRectGetMaxY(self.contentView.frame);
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            [self.layer setOpacity:1.0];
            self.contentView.frame = frameContent;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
        
    }else {
        CGRect frameContent =  self.contentView.frame;
        frameContent.origin.y += (SCREEN_HEIGHT+self.contentView.height)/2;
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            [self.layer setOpacity:0.0];
            self.contentView.frame = frameContent;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
    
    
}

- (void)selectedCancel
{
    [self removeSelf];
    
}

@end
