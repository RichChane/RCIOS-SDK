//
//  KPNormalPopView.m
//  RCIOS-SDK
//
//  Created by gzkp on 2018/8/22.
//  Copyright © 2018年 RC. All rights reserved.
//

#import "WPNormalPopView.h"
#import "UIFactory.h"

@interface WPNormalPopView()

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) M80AttributedLabel *contentAttriLabel;


@end

static const CGFloat normalWith = 270;
static const CGFloat normalHeight = 85;
static const CGFloat leftDis = 15;

@implementation WPNormalPopView

{
    NSString *_title;
    CGSize _titleSize;
    NSString *_content;
    CGSize _contentSize;
    NSString *_alertTitle;
    CGSize _alertSize;
    
    //attris
    NSArray *_contents;
    NSArray *_colors;
    CGSize _contentAttriSize;
}

#pragma mark - init
- (instancetype)initWithTitle:(NSString*)title content:(NSString*)content cancelBtnTitle:(NSString*)cancelBtnTitle okBtnTitle:(NSString*)okBtnTitle  makeSure:(MakeSure)makeSure cancel:(Cancel)cancel
{
    return [self initWithTitle:title content:content alertTitle:nil cancelBtnTitle:cancelBtnTitle okBtnTitle:okBtnTitle makeSure:makeSure cancel:cancel];
}

- (instancetype)initWithTitle:(NSString*)title cancelBtnTitle:( NSString*)cancelBtnTitle okBtnTitle:(NSString*)okBtnTitle  makeSure:(MakeSure)makeSure cancel:(Cancel)cancel
{
    return [self initWithTitle:title content:nil alertTitle:nil cancelBtnTitle:cancelBtnTitle okBtnTitle:okBtnTitle makeSure:makeSure cancel:cancel];
}

- (instancetype)initWithTitle:(NSString*)title content:(NSString*)content alertTitle:(NSString *)alertTitle cancelBtnTitle:(NSString*)cancelBtnTitle okBtnTitle:(NSString*)okBtnTitle  makeSure:(MakeSure)makeSure cancel:(Cancel)cancel
{
    self = [super initWithCancelBtnTitle:cancelBtnTitle okBtnTitle:okBtnTitle];
    if (self) {
        
        self.cancel = cancel;
        self.makeSure = makeSure;
        _title = title;
        _content = content;
        _alertTitle = alertTitle;
        
        CGFloat titleHeight= 0;
        if (_title && ![_title isEqualToString:@""])
        {
            _titleSize = [title sizeWithFont:FontSize(17) maxSize:CGSizeMake(normalWith - leftDis*2, 0)];
            titleHeight = _titleSize.height;
        }
        
        if (_content && ![_content isEqualToString:@""])
        {
            _contentSize = [content sizeWithFont:FontSize(17) maxSize:CGSizeMake(normalWith - leftDis*2, 0)];
        }
        
        CGFloat alertHeight = 0;
        if (_alertTitle && _alertTitle.length) {
            _alertSize = [_alertTitle sizeWithFont:FontSize(15) maxSize:CGSizeMake(normalWith - leftDis*2, 0)];
            alertHeight = _alertSize.height + 15;
            _alertSize.height = alertHeight;
        }
        

        [self createItems];
        [self refreshCenterView:self.topView contentView:self.contentView];
        
    }
    return self;
    
}
//富文本展示
- (instancetype)initAttriWithTitle:(NSString*)title contents:(NSArray*)contents colors:(NSArray *)colors cancelBtnTitle:( NSString*)cancelBtnTitle okBtnTitle:(NSString*)okBtnTitle  makeSure:(MakeSure)makeSure cancel:(Cancel)cancel
{
    self = [super initWithCancelBtnTitle:cancelBtnTitle okBtnTitle:okBtnTitle];
    if (self) {
        
        self.cancel = cancel;
        self.makeSure = makeSure;
        _title = title;
        _contents = contents;
        _colors = colors;
        
        
        CGFloat titleHeight= 0;
        if (_title && ![_title isEqualToString:@""])
        {
            _titleSize = [title sizeWithFont:FontSize(17) maxSize:CGSizeMake(normalWith - leftDis*2, 0)];
            titleHeight = _titleSize.height;
        }
        
        CGFloat contentHeight = 0;
        if (_contents && _contents.count )
        {
            NSString *text = @"";
            for (NSString *content in contents) {
                text = [NSString stringWithFormat:@"%@%@",text,content];
            }
            _contentAttriSize = [text sizeWithFont:FontSize(17) maxSize:CGSizeMake(normalWith - leftDis*2, 0)];
            contentHeight = _contentAttriSize.height + 20;
        }
        
        
        
        [self createItems];
        [self refreshCenterView:self.topView contentView:self.contentView];
        //[self refreshContentFrame:normalWith height:normalHeight - 30 + titleHeight + contentHeight];//富文本的展示有点小
    }
    return self;
}

#pragma mark - createItems
- (void)createItems
{
    self.contentView = [UIView  new];
    self.topView = [UIView new];
    
    CGFloat labelWidth = normalWith - leftDis*2;
    CGFloat nowY = 0;
    if (_alertTitle && _alertTitle.length) {
        
        UIView *alertBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, normalWith, _alertSize.height)];
        alertBgView.backgroundColor = kUIColorFromRGB(0xFA533D);
        [self.topView addSubview:alertBgView];
        
        UILabel *alertLabel = [[UILabel alloc]initWithFrame:CGRectMake(leftDis, 0, labelWidth, _alertSize.height)];
        alertLabel.textAlignment = NSTextAlignmentCenter;
        alertLabel.font = FontSize(15);
        alertLabel.textColor = [UIColor whiteColor];
        alertLabel.text = _alertTitle;
        alertLabel.numberOfLines = 0;
        [alertBgView addSubview:alertLabel];
        nowY = CGRectGetMaxY(alertBgView.frame);
    }
    
    if (_title && ![_title isEqualToString:@""])
    {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftDis, nowY+15, labelWidth, _titleSize.height)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = FontSize(17);
        _titleLabel.textColor = kUIColorFromRGB(0x282b34);
        _titleLabel.text = _title;
        _titleLabel.numberOfLines = 0;
        [self.topView addSubview:_titleLabel];
        nowY = CGRectGetMaxY(_titleLabel.frame);
    }
    
    self.topView.frame = CGRectMake(0, 0, normalWith, nowY+15);
    
    nowY = 0.0;
    if (_content && ![_content isEqualToString:@""])
    {
        
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftDis, nowY, labelWidth, _contentSize.height)];
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        _contentLabel.font = FontSize(17);
        _contentLabel.textColor = kUIColorFromRGB(0x282b34);
        _contentLabel.text = _content;
        _contentLabel.numberOfLines = 0;
        [self.contentView addSubview:_contentLabel];
        nowY = CGRectGetMaxY(_contentLabel.frame)+15;
    }
    if (_contents && _contents.count){
        
        NSMutableArray *fontArray = [NSMutableArray array];
        for (int i = 0; i < _contents.count; i ++) {
            [fontArray addObject:FontSize(17)];
        }
        _contentAttriLabel = [UIFactory createAttributedLabelWithFrame:CGRectMake(leftDis, nowY+15, labelWidth, _contentAttriSize.height) fontArray:fontArray textArray:_contents colorArray:_colors numberOfLines:0 backgroudColor:nil];
        _contentAttriLabel.textAlignment = kCTTextAlignmentCenter;
        [self.contentView addSubview:_contentAttriLabel];
        nowY = CGRectGetMaxY(_contentAttriLabel.frame)+15;
    }

    
    self.contentView.frame = CGRectMake(0, 0, normalWith, nowY);
}

#pragma mark - set&get
- (void)setContentAligment:(NSTextAlignment)contentAligment
{
    _contentLabel.textAlignment = contentAligment;
}

- (void)setTitleAligment:(NSTextAlignment)titleAligment
{
    _titleLabel.textAlignment = titleAligment;
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
