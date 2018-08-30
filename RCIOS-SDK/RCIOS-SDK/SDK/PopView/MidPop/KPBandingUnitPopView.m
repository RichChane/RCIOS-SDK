//
//  KPBandingUnitPopView.m
//  kpkd
//
//  Created by gzkp on 2017/8/10.
//  Copyright © 2017年 kptech. All rights reserved.
//

#import "KPBandingUnitPopView.h"

@interface KPBandingUnitPopView()

@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) NSArray<NSString*> *unitArr;
@property (nonatomic,strong) NSMutableArray *btnArray;

@end



@implementation KPBandingUnitPopView


- (instancetype)initWithTitle:(NSString*)title content:(NSString*)content unitArr:(NSArray*)unitArr selectUnit:(SelectUnitBlock)selectUnit
{
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    if (self) {
        

        self.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.5];
        _title = title;
        _content = content;
        _unitArr = unitArr;
        _selectUnit = selectUnit;
        
        [self createContent];
        
    }
    return self;
    
}

- (void)createContent
{
    CGFloat contentWidth = 268;
    CGFloat contentHeight = 150;
    UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, contentWidth, contentHeight)];
    contentView.backgroundColor = WHITE_COLOR;
    contentView.center = self.center;
    contentView.layer.cornerRadius = 4;
    [self addSubview:contentView];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 11, contentWidth, 25)];
    titleLabel.text = _title;
    titleLabel.textColor = kUIColorFromRGB(0x333333);
    titleLabel.font = FontSize(18);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [contentView addSubview:titleLabel];
    
    UILabel *contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(25, CGRectGetMaxY(titleLabel.frame) + 12.5, contentWidth - 50, 25)];
    contentLabel.text = _content;
    contentLabel.textColor = kUIColorFromRGB(0xCCCCCC);
    contentLabel.font = FontSize(15);
    [contentView addSubview:contentLabel];
    
    CGFloat distance = 18;
    CGFloat itemWidth = (contentWidth - distance*4)/3;
    CGFloat itemHeight = 42;
    _btnArray = [NSMutableArray new];
    
    CGFloat bgUnitViewWidth = itemWidth*_unitArr.count + distance*(_unitArr.count - 1);
    UIView *bgUnitView = [[UIView alloc]initWithFrame:CGRectMake((contentView.frame.size.width - bgUnitViewWidth)/2 , CGRectGetMaxY(contentLabel.frame) + 16, bgUnitViewWidth, itemHeight)];
    [contentView addSubview:bgUnitView];
    for (int i = 0; i < _unitArr.count; i ++) {

        UIButton *unitBtn = [[UIButton alloc]initWithFrame:CGRectMake(itemWidth*i + 18*i, 0, itemWidth, itemHeight)];
        [unitBtn setTitle:_unitArr[i] forState:UIControlStateNormal];
        [unitBtn setTitleColor:kUIColorFromRGB(0x3D4245) forState:UIControlStateNormal];
        unitBtn.titleLabel.font = FontSize(15);
        [bgUnitView addSubview:unitBtn];
        unitBtn.layer.cornerRadius = 4;
        unitBtn.layer.borderWidth = 1;
        unitBtn.layer.borderColor = kUIColorFromRGB(0x979797).CGColor;
        [unitBtn addTarget:self action:@selector(selectUnitAction:) forControlEvents:UIControlEventTouchUpInside];
        unitBtn.tag = 100 + i;
        [_btnArray addObject:unitBtn];
    }
    
//    self.unitId = _unitArr[0].unitId;
}

- (void)setSelectIndex:(int)selectIndex
{
    _selectIndex = selectIndex;
    for (int i = 0; i < _unitArr.count; i ++) {
        UIButton *btn = _btnArray[i];
        if (i == selectIndex) {
            btn.layer.borderColor = kUIColorFromRGB(0xFC9F06).CGColor;
            
        }else{
            btn.layer.borderColor = kUIColorFromRGB(0x979797).CGColor;
        }
    }
    
}


- (void)selectUnitAction:(UIButton *)sender
{
    for (UIButton *btn in _btnArray) {
        
        btn.layer.borderColor = kUIColorFromRGB(0x979797).CGColor;

    }
    
    sender.layer.borderColor = kUIColorFromRGB(0xFC9F06).CGColor;
    
    self.selectIndex = (int)sender.tag-100;
    
    if (_selectUnit) {
        _selectUnit(self.selectIndex);
    }
    [self  dismissPopView];
}

#pragma mark - action

-(void)showPopView{

    UIWindow* window = [UIApplication sharedApplication].delegate.window;
    [UIView animateWithDuration:1 animations:^{
        [window addSubview:self];
        
    }];
    
}

-(void)dismissPopView{
    
    
    [self removeFromSuperview];
}


- (void)tapScrollView
{
    [self  dismissPopView];
    
}



@end
