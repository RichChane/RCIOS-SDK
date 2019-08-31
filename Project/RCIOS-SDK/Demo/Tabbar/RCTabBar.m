//
//  RCTabBar.m
//  RCIOS-SDK
//
//  Created by gzkp on 2018/12/30.
//  Copyright © 2018年 RC. All rights reserved.
//

#import "RCTabBar.h"
#import "NumbTagView.h"

@implementation RCTabBar

- (id)initWithFrame:(CGRect)frame buttonImages:(NSArray *)imageArray ShowHeight:(CGFloat)sHeight
{
    _TC = [UIColor blackColor];
    
    showHeight = sHeight;
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        //        backgroundView = [[UIImageView alloc] initWithFrame:self.bounds];
        //        [backgroundView setBackgroundColor:[UIColor clearColor]];
        //        [self addSubview:backgroundView];
        
        for (NSInteger i = 0; i < MAXNEWPOINT; i++)
            newPoint[i] = nil;
        
        self.buttons = [NSMutableArray arrayWithCapacity:[imageArray count]];
        for (int i = 0; i < [imageArray count]; i++)
        {
            [self insertTabWithImageDic:[imageArray objectAtIndex:i] atIndex:i MaxTag:[imageArray count]];
        }
        
        //        [GeneralUIUse AddLineUp:self Color:kUIColorFromRGB(0xD9D9D9) LeftOri:0 RightOri:0];
        
    }
    return self;
}
- (void)setBackgroundImage:(UIImage *)img
{
    [backgroundView setImage:img];
}
- (void)tabBarButtonClicked:(id)sender
{
    UIButton *btn = sender;
    [self selectTabAtIndex:btn.tag - 100];
    if ([_delegate respondsToSelector:@selector(tabBar:didSelectIndex:)])
    {
        [_delegate tabBar:self didSelectIndex:btn.tag - 100];
    }
}
- (void)selectTabAtIndex:(NSInteger)index
{
    for (int i = 0; i < [self.buttons count]; i++)
    {
        UIButton *b = [self.buttons objectAtIndex:i];
        b.selected = NO;
    }
    UIButton *btn = [self.buttons objectAtIndex:index];
    btn.selected = YES;
}
- (void)removeTabAtIndex:(NSInteger)index
{
    // Remove button
    [(UIButton *)[self.buttons objectAtIndex:index] removeFromSuperview];
    [self.buttons removeObjectAtIndex:index];
    
    // Re-index the buttons
    CGFloat width = 320.0f / [self.buttons count];
    for (UIButton *btn in self.buttons)
    {
        if (btn.tag > index + 100)
        {
            btn.tag --;
        }
        btn.frame = CGRectMake(width * (btn.tag - 100), 0, width, self.frame.size.height);
    }
}
- (void)insertTabWithImageDic:(NSDictionary *)dict atIndex:(NSUInteger)index MaxTag:(NSUInteger)maxTag
{
    if (!dict) {
        return;
    }
    if (index > [self.buttons count] && maxTag <= index) {
        return;
    }
    
    UIImage *defaultImage = [dict objectForKey:TabBarDefault];
    UIImage *seletedImage = [dict objectForKey:TabBarSeleted];
    NSString *name = [dict objectForKey:TabBarName];
    if (!(defaultImage && seletedImage)) {
        return;
    }
    
    CGFloat width = defaultImage.size.width;
    CGFloat height = defaultImage.size.height ;
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake((self.frame.size.width / maxTag) * index, 0, self.frame.size.width / maxTag, 57.0f)];
    btn.showsTouchWhenHighlighted = YES;
    btn.tag = index + 100;
    
    if (width > btn.frame.size.width) {
        width = btn.frame.size.width;
    }
    if (height > btn.frame.size.height) {
        height = btn.frame.size.height;
    }
    
    [btn setImage:defaultImage forState:UIControlStateNormal];
    [btn setImage:seletedImage forState:UIControlStateSelected];
    
//    [btn.titleLabel setFont:[UIFont systemFontOfSize:12]];
//    [btn setTitle:ML(name) forState:UIControlStateNormal];
//    [btn setTitle:ML(name) forState:UIControlStateSelected];
//
//    [btn setTitleColor:_TC forState:UIControlStateNormal];
//    [btn setTitleColor:GC.MC forState:UIControlStateSelected];
    
    //    CGRect now_frame = [btn.titleLabel.text boundingRectWithSize:CGSizeMake(btn.frame.size.width, btn.frame.size.height)//限制最大的宽度和高度
    //                                                         options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading//采用换行模式
    //                                                      attributes:@{NSFontAttributeName:btn.titleLabel.font}//传人的字体字典
    //                                                         context:nil];
    //
    //    [btn setImageEdgeInsets:UIEdgeInsetsMake(3, (now_frame.size.width + height)/2, btn.frame.size.height - 3 - height, 0)];
    //    [btn setTitleEdgeInsets:UIEdgeInsetsMake(height + 5, 0, btn.frame.size.height - 5 - height - 7, (now_frame.size.width + height)/2 - 1)];
    

    // 由于iOS8中titleLabel的size为0，用上面这样设置有问题，修改一下即可
    //    btn.imageEdgeInsets = UIEdgeInsetsMake(-btn.titleLabel.intrinsicContentSize.height, 0, 0, -btn.titleLabel.intrinsicContentSize.width);
    //btn.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    [btn addTarget:self action:@selector(tabBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    newPoint[index] = [[UIView alloc]initWithFrame:CGRectMake(btn.frame.size.width - 18, 8, 8, 8)];
    [newPoint[index] setBackgroundColor:[UIColor redColor]];
    [newPoint[index].layer setCornerRadius:4.0];
    [newPoint[index] setHidden:YES];
    [btn addSubview:newPoint[index]];
    
    NumbTagView *numbView = [[NumbTagView alloc]initWithFrame:CGRectMake(btn.frame.size.width / 2 + 4, 5, 30, 16) BackgroundColor:kUIColorFromRGB(0xEC2121) TextColor:[UIColor whiteColor]];
    [numbView takeNumb:@"" Font:[UIFont systemFontOfSize:10]];
    [btn addSubview:numbView];
    
    if (index == [self.buttons count]) {
        // 添加
        [self.buttons addObject:btn];
    }else{
        [self.buttons insertObject:btn atIndex:index];
        if ([self viewWithTag:index + 100]) {
            [[self viewWithTag:index + 100] removeFromSuperview];
        }
    }
    [self addSubview:btn];
    
    
}

- (void)setToNewPoint:(NSInteger)which IsHid:(BOOL)toHid{
    if (which < MAXNEWPOINT) {
        if (newPoint[which]) {
            newPoint[which].hidden = toHid;
        }
    }
}
- (void)setToNew:(NSInteger)which Numb:(NSString *)numbStr CleanAll:(BOOL)isCleanAll{
    if (which < MAXNEWPOINT && [self.buttons count] > which) {
        UIButton *btn = [self.buttons objectAtIndex:which];
        
        NumbTagView *numbTab = nil;
        
        for (id obj in [btn subviews]) {
            if ([obj isKindOfClass:[NumbTagView class]]){
                
                numbTab = obj;
                break;
            }else if ([obj isKindOfClass:[UIView class]]) {
                for (id s_obj in [obj subviews]) {
                    if ([s_obj isKindOfClass:[NumbTagView class]]){
                        numbTab = s_obj;
                        break;
                    }
                }
                if (numbTab) {
                    break;
                }
            }
        }
        
        if (numbTab) {
            
            [numbTab takeNumb:numbStr Font:[UIFont systemFontOfSize:10]];
        }
    }
}
#pragma mark NumbTagDelegate
- (void)delBallDo:(NumbTagView *)item{
    // 清空所有红点
    if (_delegate && [_delegate respondsToSelector:@selector(cleanAllBall)]) {
        [_delegate cleanAllBall];
    }
}
@end
