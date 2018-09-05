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
        _title = @"";
        
    }
    return self;
    
}

- (void)createContentView
{
    UIControl *tapControl = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [tapControl addTarget:self action:@selector(dismissPopView) forControlEvents:UIControlEventTouchUpInside];
    tapControl.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.5];
    [self addSubview:tapControl];
    
    NSInteger arrayIndex = (self.bottomPopType == KPBottomPopTypeNormal)? _selectArr.count:6;
    CGFloat selectGroupViewHeight = ItemHeight*arrayIndex;
    CGFloat ContentViewHeight = selectGroupViewHeight + ItemHeight + 5;
    UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, ContentViewHeight)];
    _contentView = contentView;
    contentView.backgroundColor = CLEAR_COLOR;
    [self addSubview:contentView];
    
    CGFloat itemOriginY = 0.0;
    if (self.bottomPopType == KPBottomPopTypeNormal) {
        
        UIButton *cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, selectGroupViewHeight + 5, SCREEN_WIDTH, ItemHeight)];
        cancelBtn.backgroundColor = WHITE_COLOR;
        [cancelBtn setTitle:ML(@"取消") forState:UIControlStateNormal];
        [cancelBtn setTitleColor:GC.CBlack forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(dismissPopView) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:cancelBtn];
        
    }else if (self.bottomPopType == KPBottomPopTypeHistory){
        
        UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ItemHeight+5)];
        topView.backgroundColor = WHITE_COLOR;
        [contentView addSubview:topView];
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, topView.frame.size.height-0.5, SCREEN_WIDTH, 0.5)];
        line.backgroundColor = GC.LINE;
        [topView addSubview:line];
        
        
        CGSize cancelTitleSize = [ML(@"取消") sizeWithFont:FontSize(17) maxSize:CGSizeMake(0, 0)];
        UIButton *cancelBtn = [UIFactory createbtnWithRect:CGRectMake(0, 0, cancelTitleSize.width+30, topView.frame.size.height) target:self select:@selector(dismissPopView)];
        [cancelBtn setTitle:ML(@"取消") forState:UIControlStateNormal];
        [cancelBtn setTitleColor:kUIColorFromRGBAlpha(0x000000, 0.5) forState:UIControlStateNormal];
        [topView addSubview:cancelBtn];
        
        UILabel *titleLabel = [UIFactory createLabelWithText:self.title textColor:GC.CBlack font:FontSize(18)];
        titleLabel.frame = CGRectMake(CGRectGetMaxX(cancelBtn.frame), 0, SCREEN_WIDTH-CGRectGetMaxX(cancelBtn.frame)*2, topView.frame.size.height);
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [topView addSubview:titleLabel];
    
        itemOriginY = CGRectGetMaxY(topView.frame);
    }
    
    _selectGroupArr = [NSMutableArray array];
    UIScrollView *selectGroupView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, itemOriginY, SCREEN_WIDTH, selectGroupViewHeight)];
    selectGroupView.backgroundColor = GC.CWhite;
    [contentView addSubview:selectGroupView];
    selectGroupView.contentSize = CGSizeMake(SCREEN_WIDTH, _selectArr.count*ItemHeight);
    for (int i = 0; i < _selectArr.count ; i ++) {
        
        NSString *itemTitle = _selectArr[i];
        
        
        UIButton *itemBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, i*ItemHeight, SCREEN_WIDTH, ItemHeight)];
        itemBtn.tag = i + 100;
        itemBtn.backgroundColor = WHITE_COLOR;
        [itemBtn addTarget:self action:@selector(didSelect:) forControlEvents:UIControlEventTouchUpInside];
        if (self.bottomPopType == KPBottomPopTypeNormal) {
            [itemBtn setTitle:itemTitle forState:UIControlStateNormal];
            [itemBtn setTitleColor:GC.CBlack forState:UIControlStateNormal];
        }else if (self.bottomPopType == KPBottomPopTypeHistory){
            
            //CGSize titleSize = [itemTitle sizeWithFont:FontSize(17) maxSize:CGSizeMake(SCREEN_WIDTH-dis_LEFTSCREEN*2, ItemHeight)];
            UILabel *itemLabel = [UIFactory createLabelWithText:itemTitle textColor:GC.CBlack font:FontSize(17)];
            itemLabel.frame = CGRectMake(dis_LEFTSCREEN, 0, SCREEN_WIDTH-dis_LEFTSCREEN*2, ItemHeight);
            [itemBtn addSubview:itemLabel];
        }
        

        
        if (i < _selectArr.count-1) {
            UIView *line = [UIView new];
            line.backgroundColor = GC.LINE;
            line.frame = CGRectMake(0, itemBtn.frame.size.height-0.5, itemBtn.frame.size.width, 0.5);
            [itemBtn addSubview:line];
        }
        
        [selectGroupView addSubview:itemBtn];
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
    
    [self createContentView];
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
