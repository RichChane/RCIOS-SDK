//
//  DownSelectView.m
//  kpkd
//
//  Created by zhang yyuan on 2017/8/28.
//  Copyright © 2017年 kptech. All rights reserved.
//

#import "DownSelectView.h"

@implementation SelectToModel

- (instancetype)initWithType:(ItemSelectType)type
{
    self = [super init];
    if (self) {
        _typeSelect = type;
        
        if (_typeSelect == ItemSelectTypeMultiselect) {
            _tagSelecte = 0;
        }
    }
    return self;
}

- (void)selectModelToDo:(BOOL)is_select{
    if (is_select) {
        if (_typeSelect == ItemSelectTypeMultiselect) {
            if (_isSelected) {
                if (_tagSelecte) {
                    if (_tagSelecte == 1) {
                        _tagSelecte = 2;
                    }else{
                        _tagSelecte = 1;
                    }
                }else{
                    _tagSelecte = 1;
                }
            }else{
                _tagSelecte = 1;
            }
        }
        
    }else{
        if (_typeSelect == ItemSelectTypeMultiselect) {
            _tagSelecte = 0;
        }
    }
    _isSelected = is_select;
}

@end


#pragma mark - DownSelectView
@interface DownSelectView() {
    CGFloat itemHeight;
    
    UIScrollView *bgView;
    
    NSArray *selectList;
    
    UITapGestureRecognizer *tapGesturRecognizer;
}

@end

@implementation DownSelectView

- (instancetype)initWithView:(UIView *)view {
    if (!view) {
        return nil;
    }
    
    self = [super initWithFrame:view.bounds];
    if (self) {
        
        [self setBackgroundColor:[UIColor clearColor]];
        
        tapGesturRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeDo)];
        [self addGestureRecognizer:tapGesturRecognizer];
        
        _isAutoPop = YES;
        
        bgView = nil;
        selectList = nil;
        
        _selectedItemUI = kUIColorFromRGB(0xFC9F06);
        _bgColor = kUIColorFromRGBAlpha(0x000000, 0.6);
        _defSize = 16;
        
        [view addSubview:self];
    }
    return self;
}

- (UIButton *)defaultItem:(SelectToModel *)one Numb:(NSInteger)i Width:(CGFloat)width{
    UIButton *itemBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, itemHeight * i, width, itemHeight)];
    [itemBtn addTarget:self action:@selector(selectToDo:) forControlEvents:UIControlEventTouchUpInside];
    [itemBtn.titleLabel setFont:FontSize(_defSize)];
    itemBtn.backgroundColor = GC.CWhite;
    [itemBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    itemBtn.tag = 100 + i;
    
    [itemBtn setTitleColor:kUIColorFromRGB(0x3D4245) forState:UIControlStateNormal];
    [itemBtn setTitleColor:_selectedItemUI forState:UIControlStateSelected];
    [itemBtn setTitle:one.name forState:UIControlStateNormal];
    [itemBtn setTitle:one.name forState:UIControlStateSelected];
    
    if (one.typeSelect == ItemSelectTypeRadio) {
        
        [itemBtn setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [itemBtn setImageEdgeInsets:UIEdgeInsetsMake((itemBtn.frame.size.height - 20)/2, itemBtn.frame.size.width - 40, (itemBtn.frame.size.height - 20)/2, 0)];
        
        [itemBtn setImage:ImageName(@"common_check") forState:UIControlStateSelected];
        [itemBtn setImage:ImageName(@"common_check_white") forState:UIControlStateNormal];
        
    } else if (one.typeSelect == ItemSelectTypeMultiselect) {
        
        [itemBtn setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [itemBtn setImageEdgeInsets:UIEdgeInsetsMake((itemBtn.frame.size.height - 20)/2, itemBtn.frame.size.width - 40, (itemBtn.frame.size.height - 20)/2, 0)];
        
        [itemBtn setImage:ImageName(@"common_arrange_none") forState:UIControlStateNormal];
        if (one.tagSelecte == 2) {
            [itemBtn setImage:ImageName(@"common_arrange_down") forState:UIControlStateSelected];
        } else if (one.tagSelecte == 1) {
            [itemBtn setImage:ImageName(@"common_arrange") forState:UIControlStateSelected];
        }
        
    }
    
    if (one.isSelected) {
        [itemBtn setSelected:YES];
    }else{
        [itemBtn setSelected:NO];
    }
    
    return itemBtn;
}

- (UIButton *)modelItem_2:(SelectToModel *)one Numb:(NSInteger)i{
    UIButton *itemBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, itemHeight * i, bgView.frame.size.width, itemHeight)];
    [itemBtn setBackgroundColor:GC.CWhite];
    [itemBtn addTarget:self action:@selector(selectToDo:) forControlEvents:UIControlEventTouchUpInside];
    itemBtn.tag = 100 + i;
    
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(ASIZE(15), 0, ASIZE(150), itemHeight)];
    [name setBackgroundColor:[UIColor clearColor]];
    [name setFont:FontSize(_defSize)];
    [name setText:one.name];
    [itemBtn addSubview:name];

    if ([one.name isEqualToString:ML(@"上次价")]) {
        name.frame = CGRectMake(ASIZE(15), ASIZE(9), ASIZE(70), ASIZE(18));
    }
    
    if (one.msg[SelectPriceKey]) {
        UILabel *price = [[UILabel alloc] initWithFrame:CGRectMake(ASIZE(90), ASIZE(16.5), bgView.frame.size.width - ASIZE(105), ASIZE(22))];
        [price setBackgroundColor:[UIColor clearColor]];
        [price setTextColor:kUIColorFromRGB(0x333333)];
        [price setFont:FontSize(20)];
        price.textAlignment = NSTextAlignmentRight;
        //[price setText:[GeneralUse StrmethodComma:one.msg[SelectPriceKey] FloatingNumber:PricePrecision]];
        [itemBtn addSubview:price];
        
        if ([one.name isEqualToString:ML(@"上次价")]) {
            price.frame = CGRectMake(ASIZE(90), ASIZE(10.5), bgView.frame.size.width - ASIZE(105), ASIZE(22));
        }
    }
    if (one.msg[SelectStockNumb]) {
        UILabel *price = [[UILabel alloc] initWithFrame:CGRectMake(ASIZE(90), ASIZE(16.5), bgView.frame.size.width - ASIZE(105), ASIZE(22))];
        [price setBackgroundColor:[UIColor clearColor]];
        [price setTextColor:kUIColorFromRGB(0x333333)];
        [price setFont:FontSize(20)];
        price.textAlignment = NSTextAlignmentRight;
        [price setText:one.msg[SelectStockNumb]];
        [itemBtn addSubview:price];
    }
    if (one.msg[SelectStockKey]) {
        UILabel *stock = [[UILabel alloc] initWithFrame:CGRectMake(ASIZE(110), ASIZE(34), bgView.frame.size.width - ASIZE(125), ASIZE(16.5))];
        [stock setBackgroundColor:[UIColor clearColor]];
        [stock setTextAlignment:NSTextAlignmentRight];
        [stock setTextColor:kUIColorFromRGB(0x9B9B9B)];
        [stock setFont:FontSize(12)];
        [stock setText:[NSString stringWithFormat:@"x %@",one.msg[SelectStockKey]]];
        [itemBtn addSubview:stock];
    }
    if (one.msg[SelectTimeKey]) {
        UILabel *stock = [[UILabel alloc] initWithFrame:CGRectMake(ASIZE(15), ASIZE(34), ASIZE(100), ASIZE(16.5))];
        [stock setBackgroundColor:[UIColor clearColor]];
        [stock setTextAlignment:NSTextAlignmentLeft];
        [stock setTextColor:kUIColorFromRGB(0x9B9B9B)];
        [stock setFont:FontSize(12)];
        [stock setText:one.msg[SelectTimeKey]];
        [itemBtn addSubview:stock];
    }
    
    if (one.typeSelect == ItemSelectTypeRadio_2) {
        
        [itemBtn setImage:ImageName(@"common_tabcheck_clean") forState:UIControlStateNormal];
        [itemBtn setImage:ImageName(@"common_tabcheck") forState:UIControlStateSelected];
        
        [itemBtn setImageEdgeInsets:UIEdgeInsetsMake(itemBtn.frame.size.height - itemBtn.imageView.bounds.size.height, itemBtn.frame.size.width - itemBtn.imageView.bounds.size.width, 0, 0)];
    } else if (one.typeSelect == ItemSelectTypeRadio) {
        
        [itemBtn setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [itemBtn setImageEdgeInsets:UIEdgeInsetsMake((itemBtn.frame.size.height - 20)/2, itemBtn.frame.size.width - 40, (itemBtn.frame.size.height - 20)/2, 0)];
        
        [itemBtn setImage:ImageName(@"common_check") forState:UIControlStateSelected];
        [itemBtn setImage:ImageName(@"common_check_white") forState:UIControlStateNormal];
        
    }
    
    if (one.isSelected) {
        [itemBtn setSelected:YES];
    }else{
        [itemBtn setSelected:NO];
    }
    
    return itemBtn;
}

#pragma mark - action

- (void)openSelectOrgY:(CGFloat)org_y ItemHeight:(CGFloat)iHeight List:(NSArray<SelectToModel *> *)list {
    [self openSelectFrame:CGRectMake(0, org_y, self.frame.size.width, self.frame.size.height - org_y) ItemHeight:iHeight List:list];
}

- (void)openSelectFrame:(CGRect)frame ItemHeight:(CGFloat)iHeight List:(NSArray<SelectToModel *> *)list {
    if (!(list && [list count])) {
        return ;
    }
    
    itemHeight = iHeight;
    
    selectList = [list copy];
    
    if (bgView) {
        return;
    }
    
    bgView = [[UIScrollView alloc]initWithFrame:frame];
    bgView.contentSize = CGSizeMake(bgView.frame.size.width, itemHeight * selectList.count);
    bgView.backgroundColor = _bgColor;
    [self addSubview:bgView];
    
    for (int i = 0; i < selectList.count; i ++) {
        SelectToModel *one = selectList[i];
        UIButton *itemBtn = nil;
        
        if (one.modelSelect == ItemSelectUIModelDefault) {
            itemBtn = [self defaultItem:one Numb:i Width:bgView.frame.size.width];
            
        } else if (one.modelSelect == ItemSelectUIModel_2) {
            itemBtn = [self modelItem_2:one Numb:i];
            
        }
        [bgView addSubview:itemBtn];
        
        if (i != (selectList.count - 1)) {
//            [GeneralUIUse AddLineDown:itemBtn Color:GC.LINE LeftOri:dis_LEFTSCREEN RightOri:0];
        }
    }
    
    if (bgView) {
        CGRect bgFrame = bgView.frame;
        CGFloat height = bgView.frame.size.height;
        bgFrame.size.height = 0;
        [bgView setFrame:bgFrame];
        bgFrame.size.height = height;
        
        [self setAlpha:0];
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             
                             [bgView setFrame:bgFrame];
                             
                             [self setAlpha:1];
                             
                         }
                         completion:^(BOOL finished) {
                             
                         }
         
         ];
    }
}

- (void)hideSelect{
    if (bgView) {
        
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             
                             [self setAlpha:0];
                             
                         }
                         completion:^(BOOL finished) {
                             [self removeFromSuperview];
                         }
         
         ];
    }
}

////////////////////////////////////////////
- (void)selectToDo:(UIButton*)sender
{
    NSInteger selectedNum = sender.tag - 100;
    SelectToModel *_chooseModel = selectList[selectedNum];
    
    if (_chooseModel.isSelected && _chooseModel.typeSelect != ItemSelectTypeMultiselect) {
        // 过滤重复点击
        if (_isAutoPop) {
            [self closeDo];
        }
        
        return;
    }
    
    for (NSInteger i = 0; i < [selectList count]; i++) {
        UIButton *item = [bgView viewWithTag:100 + i];
        if (item == sender) {
            [item setSelected:YES];
        }else{
            [item setSelected:NO];
        }
        
        if (_chooseModel == selectList[i]) {
            [selectList[i] selectModelToDo:YES];
        }else{
            [selectList[i] selectModelToDo:NO];
        }
    }
    
    if (_downDelegate && [_downDelegate respondsToSelector:@selector(downSelectView:Data:FromModel:)]) {
        [_downDelegate downSelectView:self Data:_chooseModel FromModel:YES];
    }
    
    if (_isAutoPop) {
        [self hideSelect];
    }
}

- (void)closeDo{
    if (tapGesturRecognizer) {
        [self removeGestureRecognizer:tapGesturRecognizer];
        tapGesturRecognizer = nil;
    }
    
    [self hideSelect];
    if (_downDelegate && [_downDelegate respondsToSelector:@selector(colseView)]) {
        [_downDelegate colseView];
    }
}

@end


#pragma mark - SortSelect
@interface SortSelect() {
    UIScrollView *sortScroll;
    
    NSArray<SelectToModel *> *sortModelArr;
    
    BOOL needDownDouble;        // 是否需要双击
    BOOL isDownDouble;
    
    UIView *navView;
}

@end

@implementation SortSelect

- (instancetype)initWithFrame:(CGRect)frame ShowData:(NSArray<SelectToModel *> *)showData
{
    if (!(showData && [showData count])) {
        return nil;
    }
    sortModelArr = showData;
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:WHITE_COLOR];
        
        sortScroll = [[UIScrollView alloc] initWithFrame:self.bounds];
        [sortScroll setBackgroundColor:[UIColor clearColor]];
        [sortScroll setShowsVerticalScrollIndicator:NO];
        [sortScroll setShowsHorizontalScrollIndicator:NO];
        
        
        [self addSubview:sortScroll];
    }
    return self;
}

- (void)beginShow{
    
    // 先渲染UI，记录UI宽度
    CGFloat btn_width = 0;
    CGFloat btn_start_x = 0;
    
    UIButton *firstBtn = nil;
    BOOL isFirstFire = NO;
    
    for (NSInteger i = 0; i < [sortModelArr count]; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, sortScroll.frame.size.width, sortScroll.frame.size.height)];
        [btn setBackgroundColor:[UIColor clearColor]];
        [btn.titleLabel setFont:FontSize(15)];
        [btn setTitleColor:GC.CBlack forState:UIControlStateNormal];
        [btn setTitleColor:kUIColorFromRGB(0xFC9F06) forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(reorderSelectToDo:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTag:(i + 100)];
        [btn setTitle:sortModelArr[i].name forState:UIControlStateNormal];
        [btn setTitle:sortModelArr[i].name forState:UIControlStateSelected];
        [sortScroll addSubview:btn];
        //[GeneralUIUse AutoCalculationView:btn MaxFrame:btn.frame];
        
        if (sortModelArr[i].typeSelect == ItemSelectTypeMultiselect) {
            CGRect b_frame = btn.frame;
            b_frame.size.width += 60;
            b_frame.size.height = sortScroll.frame.size.height;
            [btn setFrame:b_frame];
            
            UIImageView *logoBtn = [[UIImageView alloc]initWithFrame:CGRectMake(btn.frame.size.width - 25, (btn.frame.size.height - 20)/2, 20, 20)];
            [logoBtn setTag:1000];
            [btn addSubview:logoBtn];
            
        } else if (sortModelArr[i].typeSelect == ItemSelectTypeRadio) {
            CGRect b_frame = btn.frame;
            b_frame.size.width += 40;
            b_frame.size.height = sortScroll.frame.size.height;
            [btn setFrame:b_frame];
        }
        
        btn_width += btn.frame.size.width;
        
        if (sortModelArr[i].isSelected) {
            firstBtn = btn;
            isFirstFire = sortModelArr[i].isFirstFire;
            sortModelArr[i].isFirstFire = NO;
        }
    }
    
    if (btn_width <= sortScroll.frame.size.width) {
        // 均分布局
        CGFloat more_width = (sortScroll.frame.size.width - btn_width) / [sortModelArr count];
        for (NSInteger i = 0; i < [sortModelArr count]; i++) {
            UIButton *btn = [self viewWithTag:(i + 100)];
            btn_start_x += more_width/2;
            if (btn) {
                CGRect b_frame = btn.frame;
                b_frame.origin.x = btn_start_x;
                [btn setFrame:b_frame];
            }
            
            btn_start_x += btn.frame.size.width + more_width/2;
        }
    }else{
        // 等距布局
        for (NSInteger i = 0; i < [sortModelArr count]; i++) {
            UIButton *btn = [self viewWithTag:(i + 100)];
            if (btn) {
                CGRect b_frame = btn.frame;
                b_frame.origin.x = btn_start_x;
                [btn setFrame:b_frame];
            }
            
            btn_start_x += btn.frame.size.width;
        }
        
        [sortScroll setContentSize:CGSizeMake(btn_width, self.frame.size.height)];
    }
    
    
    if (_isNav) {
        navView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 2, 16, 2)];
        [navView setBackgroundColor:kUIColorFromRGB(0xFC9F06)];
        [navView.layer setCornerRadius:1];
    }else{
        navView = nil;
    }
    
    if (isFirstFire) {
        [self reorderSelectToDo:firstBtn];
    }else{
        [self reorderSelectUI:firstBtn];
    }
}

#pragma mark 按钮事件
// 切换排序
- (void)reorderSelectToDo:(UIButton *)sender
{
    NSInteger selTag = sender.tag - 100;
    if ([sortModelArr count] <= selTag) {
        return;
    }
    
    SelectToModel *_chooseModel = sortModelArr[selTag];
    
    if (_chooseModel.isSelected && _chooseModel.typeSelect != ItemSelectTypeMultiselect) {
        // 过滤重复点击
        [self reorderSelectUI:sender];
        return;
    }
    
    for (NSInteger i = 0; i < [sortModelArr count]; i++) {
        UIButton *btn = [self viewWithTag:100 + i];
        if (btn == sender) {
            [btn setSelected:YES];
        }else{
            
            [(UIImageView *)[btn viewWithTag:1000] setImage:nil];
            [btn setSelected:NO];
        }
        
        if (_chooseModel == sortModelArr[i]) {
            [sortModelArr[i] selectModelToDo:YES];
        }else{
            [sortModelArr[i] selectModelToDo:NO];
        }
    }
    
    [self reorderSelectUI:sender];
    
    if (_downDelegate && [_downDelegate respondsToSelector:@selector(downSelectView:Data:FromModel:)]) {
        [_downDelegate downSelectView:self Data:_chooseModel FromModel:YES];
    }
}
- (void)reorderSelectUI:(UIButton *)sender{
    NSInteger selTag = sender.tag - 100;
    if ([sortModelArr count] <= selTag) {
        return;
    }
    
    [sender setSelected:YES];
    
    UIImageView *logo = [sender viewWithTag:1000];
    if (logo) {
        if (sortModelArr[selTag].tagSelecte == 1) {
            [logo setImage:ImageName(@"common_arrange_down")];
        } else {
            [logo setImage:ImageName(@"common_arrange")];
        }
    }
    
    if (navView) {
        CGRect navFrame = navView.frame;
        navFrame.origin.x = (sender.frame.size.width - navFrame.size.width) / 2;
        [navView setFrame:navFrame];
        [sender addSubview:navView];
    }
}

@end
