//
//  KPUpdatePopView.m
//  RCIOS-SDK
//
//  Created by gzkp on 2018/8/22.
//  Copyright © 2018年 RC. All rights reserved.
//

#import "KPUpdatePopView.h"

@interface KPUpdatePopView()


@end

@implementation KPUpdatePopView
{
    NSString *_mainTitle;
    NSString *_subTitle;
    UIImage *_topImage;
    
    NSString *_content;
    CGSize _contentSize;
    
    CGFloat _contentWidth;
    CGFloat _contentHeight;
}

#pragma mark - init
- (instancetype)initWithTitle:(NSString*)mainTitle subTitle:(NSString *)subTitle topImage:(UIImage *)topImage content:(NSString*)content cancelBtnTitle:(NSString*)cancelBtnTitle okBtnTitle:(NSString*)okBtnTitle  makeSure:(MakeSure)makeSure cancel:(Cancel)cancel
{
    
    self = [super initWithCancelBtnTitle:cancelBtnTitle okBtnTitle:okBtnTitle];
    
    if (self) {
        
        self.cancel = cancel;
        self.makeSure = makeSure;
        _mainTitle = mainTitle;
        _subTitle = subTitle;
        _content = content;
        _topImage = topImage;
        
        _contentWidth = SCREEN_WIDTH*640/750;
        
        if (_content && ![_content isEqualToString:@""])
        {
            _contentSize = [content sizeWithFont:FontSize(17) maxSize:CGSizeMake(_contentWidth - 25*2, 0)];
        }
        
        
        [self createItems];
        [self refreshCenterView:self.topView contentView:self.contentView];
        
    }
    return self;

}

#pragma mark - createItems
- (void)createItems
{
    self.contentView = [UIView new];
    self.topView = [UIView new];
    
    UIImageView *topBgImv = [[UIImageView alloc]initWithImage:_topImage];
    if (topBgImv.frame.size.width > (SCREEN_WIDTH-40)) {
        CGFloat imvHeight = topBgImv.frame.size.height*(SCREEN_WIDTH-40)/topBgImv.frame.size.width;
        topBgImv.frame = CGRectMake(0, 0, SCREEN_WIDTH-40, imvHeight);
    }
    [self.topView addSubview:topBgImv];
    self.topView.frame = topBgImv.frame;
    
    UITextView *contentTextView = [[UITextView alloc]initWithFrame:CGRectMake(25, 0, _contentWidth-25*2, topBgImv.frame.size.height/0.55)];
    [self.contentView addSubview:contentTextView];
    contentTextView.editable = NO;
    contentTextView.font = FontSize(14);
    contentTextView.textColor = GC.CBlack;
    contentTextView.text = _content;
    [self.contentView addSubview:contentTextView];
    self.contentView.frame = CGRectMake(0, 0, _contentWidth, contentTextView.frame.size.height+10);
}

#pragma mark - sure&cancel btn
- (void)clickSureBtn:(UIButton *)sender
{
    if (self.makeSure) {
        self.makeSure();
    }
    [super clickSureBtn:sender];
    
}

- (void)clickCancleBtn:(UIButton *)sender
{
    if (self.cancel) {
        self.cancel();
    }
    [super clickCancleBtn:sender];
    
}

@end
