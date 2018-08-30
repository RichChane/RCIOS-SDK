//
//  PaymentSelectView.m
//  kp
//
//  Created by gzkp on 2017/6/8.
//  Copyright © 2017年 kptech. All rights reserved.
//

#import "PaymentSelectView.h"
#import "SelectGroupView.h"


@interface PaymentSelectView()

@property (nonatomic,strong) NSArray *selectArr;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSMutableArray *selectGroupArr;
@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,strong) UIView *contentBgView;

@end

static const CGFloat BaseHeight = 55;
static const CGFloat ItemHeight = 45;

@implementation PaymentSelectView
{
    CGFloat _itemWidth;
    NSInteger _selectIndex;
    NSInteger _rowNum;
    BOOL _hasCancelBtn;
    CGRect _bgFrame;
}

- (id)initWithSelectArr:(NSArray *)selectArr selectIndex:(NSInteger)selectIndex
{
    return [self initWithOriginY:0 SelectArr:selectArr selectIndex:selectIndex title:ML(@"选择支付方式") rowNum:2];
    
}

- (id)initWithSelectArr:(NSArray *)selectArr selectIndex:(NSInteger)selectIndex title:(NSString *)title rowNum:(NSInteger)rowNum
{
    return [self initWithOriginY:0 SelectArr:selectArr selectIndex:selectIndex title:title rowNum:rowNum hasCancelBtn:NO];
    
}

- (id)initWithOriginY:(CGFloat)originY SelectArr:(NSArray *)selectArr selectIndex:(NSInteger)selectIndex title:(NSString *)title rowNum:(NSInteger)rowNum
{
    return [self initWithOriginY:originY SelectArr:selectArr selectIndex:selectIndex title:title rowNum:rowNum hasCancelBtn:NO];
    
}


- (id)initWithOriginY:(CGFloat)originY SelectArr:(NSArray *)selectArr selectIndex:(NSInteger)selectIndex title:(NSString *)title rowNum:(NSInteger)rowNum hasCancelBtn:(BOOL)hasCancelBtn
{
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    if (self) {
        
        _originY = originY;
        _itemWidth = (SCREEN_WIDTH - 57 - 15)/rowNum;
        _rowNum = rowNum;
        
        _selectArr = selectArr;
        _selectIndex = selectIndex;
        _title = title;
        
        _hasCancelBtn = hasCancelBtn;
        
        
        [self createContentView];

    }
    return self;
    
    
}

- (void)createContentView
{

    UIControl *tapControl = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [tapControl addTarget:self action:@selector(dismissPopView) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:tapControl];
    
    CGRect myRect =CGRectMake(0,0,SCREEN_WIDTH, _originY);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:tapControl.frame cornerRadius:0];
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithRoundedRect:myRect cornerRadius:0];
    [path appendPath:circlePath];
    [path setUsesEvenOddFillRule:YES];
    
    CAShapeLayer *fillLayer = [CAShapeLayer layer];
    fillLayer.path = path.CGPath;
    fillLayer.fillRule =kCAFillRuleEvenOdd;
    fillLayer.fillColor = [UIColor colorWithWhite:0.3 alpha:0.5].CGColor;
    fillLayer.opacity =0.5;
    [tapControl.layer addSublayer:fillLayer];
    
    
    
    
    //设置content高度
    NSInteger section = (_selectArr.count%_rowNum + _selectArr.count)/_rowNum;
    CGFloat selectGroupViewHeight = ItemHeight*section + 18*section;
    CGFloat groupViewHeight = selectGroupViewHeight;
    selectGroupViewHeight = (selectGroupViewHeight > (SCREEN_HEIGHT/2))? (SCREEN_HEIGHT/2) : selectGroupViewHeight;
    CGFloat ContentViewHeight;
    if (_hasCancelBtn) {
        ContentViewHeight = BaseHeight + selectGroupViewHeight + ItemHeight + 10;
    }else{
        ContentViewHeight = BaseHeight + selectGroupViewHeight;
    }
    
    
    UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, ContentViewHeight)];
    _contentView = contentView;
    contentView.backgroundColor = WHITE_COLOR;
    
    
    if (_hasCancelBtn) {
        UIView *cancelBgView = [[UIView alloc]initWithFrame:CGRectMake(0, ContentViewHeight - ItemHeight - 10, SCREEN_WIDTH, ItemHeight + 10)];
        cancelBgView.backgroundColor = GC.CBlack;
        [contentView addSubview:cancelBgView];
        
        UIButton *cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, ItemHeight)];
        cancelBtn.backgroundColor = WHITE_COLOR;
        [cancelBtn setTitle:ML(@"取消") forState:UIControlStateNormal];
        [cancelBtn setTitleColor:GC.CBlack forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(dismissPopView) forControlEvents:UIControlEventTouchUpInside];
        [cancelBgView addSubview:cancelBtn];
        
    }
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 55)];
    titleLabel.textColor = kUIColorFromRGB(0x3D4245);
    titleLabel.text = _title;
    titleLabel.font = FontSize(17);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [contentView addSubview:titleLabel];
    
    
    _selectGroupArr = [NSMutableArray array];
    
    CGFloat originY = 0.0;
    if (_title && _title.length ) {
        originY = 55;
    }else{
        originY = 35;
    }
    
    UIScrollView *selectGroupView = [[UIScrollView alloc]initWithFrame:CGRectMake(29, originY, SCREEN_WIDTH - 56, selectGroupViewHeight)];
    selectGroupView.contentSize = CGSizeMake(selectGroupView.frame.size.width, groupViewHeight);
    [contentView addSubview:selectGroupView];
    for (int i = 0; i < _selectArr.count ; i ++) {
        NSString *title;
        id objc = _selectArr[i];
        if ([objc isKindOfClass:[NSString class]]) {
            
            title = objc;
        }
//        else if ([objc isKindOfClass:[KPCorporation_Setting_PayType class]]){
//            title = ((KPCorporation_Setting_PayType *)objc).value;
//        }
        SelectGroupView *selectSingleView = [[SelectGroupView alloc]initWithFrame:CGRectMake(_itemWidth*(i%_rowNum) + 15*(i%_rowNum), ItemHeight*(i/_rowNum) + 18*(i/_rowNum), _itemWidth, ItemHeight) title:title];
        selectSingleView.tag = 100+i;
        [selectSingleView addTarget:self action:@selector(didSelect:)];
        [selectGroupView addSubview:selectSingleView];
        
        [_selectGroupArr addObject:selectSingleView];
        
        if (i == _selectIndex) {
            [selectSingleView setViewStatusSelected];
        }else
        {
            [selectSingleView setViewStatusNormal];
        }
    }
    
    // 内容视图的背景
    UIView *contentBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, contentView.frame.size.height)];
    _contentBgView = contentBgView;
    contentBgView.clipsToBounds = YES;
    [self addSubview:contentBgView];
    [contentBgView addSubview:contentView];
}

- (void)didSelect:(UIControl*)sender
{
    for (SelectGroupView *selectView in _selectGroupArr) {
        [selectView setViewStatusNormal];
        if (sender.tag == selectView.tag ) {
            [selectView setViewStatusSelected];
        }
    }
    if (self.selectType) {
        self.selectType(sender.tag - 100);
    }
    [self dismissPopView];
}

#pragma mark - action

- (void)showPopViewInView:(UIView *)inView
{
    
    //设置其实位置
    if (self.popType == POPShowFromTop) {
        self.contentView.frame = CGRectMake(0, -self.contentView.frame.size.height, SCREEN_WIDTH, self.contentView.frame.size.height);
        self.contentBgView.frame = CGRectMake(0, self.frame.origin.y+self.originY, SCREEN_WIDTH, self.contentView.frame.size.height);
    }else if (self.popType == POPShowFromBottom){
        self.contentView.frame = CGRectMake(0, self.contentView.frame.size.height, SCREEN_WIDTH, self.contentView.frame.size.height);
        self.contentBgView.frame = CGRectMake(0, SCREEN_HEIGHT - self.contentView.frame.size.height, SCREEN_WIDTH, self.contentView.frame.size.height);
    }
    
    @RCWeak(self)
    [UIView animateWithDuration:POPDuration animations:^{
        [inView addSubview:self];
        @RCStrong(self)
        if (self.popType == POPShowFromBottom) {
            self.contentView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.contentView.frame.size.height);
        }else if (self.popType == POPShowFromTop){
            self.contentView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.contentView.frame.size.height);
            
        }
        
    }];
    
}



-(void)showPopView{
    
    UIWindow* window = [UIApplication sharedApplication].delegate.window;
    [self showPopViewInView:window];
    
}

-(void)dismissPopView{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    @RCWeak(self)
    [UIView animateWithDuration:POPDuration animations:^{
        @RCStrong(self)
        //结束位置 - （为初始位置）
        if (self.popType == POPShowFromTop) {
            self.contentView.frame = CGRectMake(0, -self.contentView.frame.size.height, SCREEN_WIDTH, self.contentView.frame.size.height);
            
        }else if (self.popType == POPShowFromBottom){
            self.contentView.frame = CGRectMake(0, self.contentView.frame.size.height, SCREEN_WIDTH, self.contentView.frame.size.height);
            
        }
        
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
    }];
    
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
