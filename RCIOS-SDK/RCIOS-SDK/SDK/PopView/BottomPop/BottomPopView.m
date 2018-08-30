//
//  BottomPopView.m
//  kp
//
//  Created by gzkp on 2017/7/14.
//  Copyright © 2017年 kptech. All rights reserved.
//

#import "BottomPopView.h"

@interface BottomPopView()

@property (nonatomic,strong) NSArray *selectArr;
@property (nonatomic,strong) NSMutableArray *selectGroupArr;
@property (nonatomic,strong) UIView *contentView;

@end

static const CGFloat ItemHeight = 45;

@implementation BottomPopView
{
    
    NSInteger _selectIndex;
}

- (id)initWithSelectArr:(NSArray *)selectArr selectIndex:(NSInteger)selectIndex
{
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    if (self) {
    
        
        _selectArr = selectArr;
        _selectIndex = selectIndex;
        
        [self createContentView];
        
    }
    return self;
    
}

- (void)createContentView
{
    UIControl *tapControl = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [tapControl addTarget:self action:@selector(dismissPopView) forControlEvents:UIControlEventTouchUpInside];
    tapControl.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.5];
    [self addSubview:tapControl];
    

    CGFloat selectGroupViewHeight = ItemHeight*_selectArr.count ;
    CGFloat ContentViewHeight = selectGroupViewHeight + ItemHeight + 5;
    UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, ContentViewHeight)];
    _contentView = contentView;
    contentView.backgroundColor = CLEAR_COLOR;
    [self addSubview:contentView];
    
    UIButton *cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, selectGroupViewHeight + 5, SCREEN_WIDTH, ItemHeight)];
    cancelBtn.backgroundColor = WHITE_COLOR;
    [cancelBtn setTitle:ML(@"取消") forState:UIControlStateNormal];
    [cancelBtn setTitleColor:GC.CBlack forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(dismissPopView) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:cancelBtn];
    
    
    _selectGroupArr = [NSMutableArray array];
    UIView *selectGroupView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, selectGroupViewHeight)];
    selectGroupView.backgroundColor = GC.CBlack;
    [contentView addSubview:selectGroupView];
    for (int i = 0; i < _selectArr.count ; i ++) {
        
        UIButton *itemBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, i*ItemHeight, SCREEN_WIDTH, ItemHeight - 0.5)];
        itemBtn.tag = i + 100;
        [itemBtn setTitle:_selectArr[i] forState:UIControlStateNormal];
        [itemBtn setTitleColor:GC.CBlack forState:UIControlStateNormal];
        itemBtn.backgroundColor = WHITE_COLOR;
        [itemBtn addTarget:self action:@selector(didSelect:) forControlEvents:UIControlEventTouchUpInside];

        
        [contentView addSubview:itemBtn];
        [_selectGroupArr addObject:itemBtn];
    }
}

- (void)didSelect:(UIButton*)sender
{

    if (self.selectType) {
        self.selectType(sender.tag - 100);
    }
    [self dismissPopView];
}

#pragma mark - action

-(void)showPopView{
    @RCWeak(self)
    UIWindow* window = [UIApplication sharedApplication].delegate.window;
    [UIView animateWithDuration:0.3 animations:^{
        @RCStrong(self)
        [window addSubview:self];
        self.contentView.frame = CGRectMake(0, SCREEN_HEIGHT - self.contentView.frame.size.height, SCREEN_WIDTH, self.contentView.frame.size.height);
        
    }];
    
}

-(void)dismissPopView{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    @RCWeak(self)
    [UIView animateWithDuration:0.3 animations:^{
        @RCStrong(self)
        self.contentView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, self.contentView.frame.size.height);
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
    }];
    
}




@end
