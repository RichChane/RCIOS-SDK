//
//  DoubleDatePickerView.m
//  FMDB
//
//  Created by gzkp on 2018/11/30.
//

#import "DoubleDatePickerView.h"
#import "UIFactory.h"
#import "DateFormatString.h"
#import "NSCalendar+ST.h"
#import "UIView+YYAdd.h"
#import "NSString+Size.h"
#import "RCSDKHeader.h"

@interface DoubleDatePickerView()

@property (nonatomic ,strong)UIDatePicker * datePicker;
@property (nonatomic ,strong)NSMutableDictionary * dateSpace;
@property (nonatomic ,copy) dateSelectBlock block;

@property (nonatomic ,strong)UILabel      * beginDateLabel;
@property (nonatomic ,strong)UILabel      * endDateLabel;
@property (nonatomic ,strong)UIView       * beginLine;
@property (nonatomic ,strong)UIView       * endLine;
@property (nonatomic ,assign)BOOL           beginLabelSelect;

@end


@implementation DoubleDatePickerView


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/**
 
 dateSpace : 各种数据
 @"BottomBtn":Array - 控件底部按钮
 
 */
- (id)initWithDateSpace:(NSMutableDictionary *)dateSpace block:(dateSelectBlock)block
{
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    if(self){
        self.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.5];
        self.block = block;
        self.dateSpace = dateSpace;
        [self createUI];
        //[self showSelf];
        self.beginLabelSelect = YES;
        self.clipsToBounds = YES;
        
    }
    return self;
}

- (void)setBeginLabelSelect:(BOOL)beginLabelSelect
{
    _beginLabelSelect = beginLabelSelect;
    _beginDateLabel.textColor = !beginLabelSelect?[[UIColor blackColor] colorWithAlphaComponent:1]:kUIColorFromRGB(0xFF675E);
    _endDateLabel.textColor = beginLabelSelect?[[UIColor blackColor] colorWithAlphaComponent:1]:kUIColorFromRGB(0xFF675E);
    _beginLine.backgroundColor = !beginLabelSelect?kUIColorFromRGB(0x979797):kUIColorFromRGB(0xFF675E);
    _endLine.backgroundColor = beginLabelSelect?kUIColorFromRGB(0x979797):kUIColorFromRGB(0xFF675E);
    
    NSString * key = beginLabelSelect?BeginTimer:EndTimer;
    double time = [[self.dateSpace objectForKey:key] doubleValue]/1000;
    NSDate * date = (time==0?[NSDate date]:[NSDate dateWithTimeIntervalSince1970:time]);
    if(!beginLabelSelect){
        _datePicker.minimumDate = [NSDate dateWithTimeIntervalSince1970:[[self.dateSpace objectForKey:BeginTimer] doubleValue]/1000];
    }else{
        _datePicker.minimumDate = [NSDate dateWithTimeIntervalSince1970:[[self.dateSpace objectForKey:BeginTimer] doubleValue]/1000];
        //        _datePicker.minimumDate = [NSDate dateWithTimeIntervalSince1970:[[SessionManager getInstance] getCorporation].createTime / 1000];
    }
    
    [_datePicker setDate:date];
    
}

- (void)createUI
{
    self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, (SCREEN_HEIGHT-450)/2, SCREEN_WIDTH, 415)];
    self.contentView.backgroundColor = kUIColorFromRGB(0xffffff);

    UIView *topBtnView = [self createTopBtn];
    [self.contentView addSubview:topBtnView];
    
    
    // 分隔线
    UIView *seperatLine = [self createCustomLine];
    seperatLine.frame = CGRectMake(0, topBtnView.bottom, seperatLine.width, seperatLine.height);
    [self.contentView addSubview:seperatLine];
    
    _beginDateLabel = [UIFactory createLabelWithText:0 textColor:[[UIColor blackColor] colorWithAlphaComponent:1] font:FontSize(16)];
    _endDateLabel = [UIFactory createLabelWithText:0 textColor:[[UIColor blackColor] colorWithAlphaComponent:1] font:FontSize(16)];
    _beginDateLabel.top = _endDateLabel.top = seperatLine.bottom+22;
    _beginDateLabel.width = _endDateLabel.width = ASIZE(124);
    _beginDateLabel.textAlignment = _endDateLabel.textAlignment = NSTextAlignmentCenter;
    _beginDateLabel.left = ASIZE(23);
    _endDateLabel.left = SCREEN_WIDTH-_beginDateLabel.left-_endDateLabel.width;
    
    _beginLine = [[UIView alloc] initWithFrame:CGRectMake(0, _beginDateLabel.bottom+5, _beginDateLabel.width, ASIZE(1))];
    _endLine = [[UIView alloc] initWithFrame:CGRectMake(0, _beginDateLabel.bottom+5, _beginDateLabel.width, ASIZE(1))];
    _beginLine.backgroundColor = _endLine.backgroundColor = kUIColorFromRGB(0x979797);
    _beginLine.centerX = _beginDateLabel.centerX;
    _endLine.centerX = _endDateLabel.centerX;
    [_beginDateLabel addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dateLabelPressed:)]];
    [_endDateLabel addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dateLabelPressed:)]];
    _beginDateLabel.userInteractionEnabled = _endDateLabel.userInteractionEnabled = YES;
    [self.contentView addSubview:_beginLine];
    [self.contentView addSubview:_endLine];
    [self.contentView addSubview:_endDateLabel];
    [self.contentView addSubview:_beginDateLabel];
    
    UILabel * centerLabel = [UIFactory createLabelWithText:ML(@"至") textColor:_beginDateLabel.textColor font:_beginDateLabel.font];
    centerLabel.center = CGPointMake(SCREEN_WIDTH/2, _beginDateLabel.centerY);
    [self.contentView addSubview:centerLabel];
    
    _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, _beginLine.bottom+22, SCREEN_WIDTH, 150)];
    _datePicker.datePickerMode = UIDatePickerModeDate;
    _datePicker.maximumDate = [NSDate date];
    _datePicker.minimumDate = self.minimumDate;
    [_datePicker addTarget:self action:@selector(datepickerChange) forControlEvents:UIControlEventValueChanged];
    [self.contentView addSubview:_datePicker];
    
    [self reloadDateLabel];

    UIButton *cancelBtn = [UIButton new];
    [cancelBtn setTitle:ML(@"取消") forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(removeSelf) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [cancelBtn setTitleColor:kUIColorFromRGB(0x000000) forState:UIControlStateNormal];
    cancelBtn.frame = CGRectMake(0, _datePicker.bottom+30, SCREEN_WIDTH*0.35, 41);
    [self.contentView addSubview:cancelBtn];
    
    UIButton *button = [UIButton new];
    [button setBackgroundColor:kUIColorFromRGB(0xFC9F06)];
    [button setTitle:ML(@"保 存") forState:UIControlStateNormal];
    [button addTarget:self action:@selector(sureBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [button.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.frame = CGRectMake(cancelBtn.right, _datePicker.bottom+30, SCREEN_WIDTH-cancelBtn.width-15, 41);
    [self.contentView addSubview:button];
    button.layer.cornerRadius = 4;

    
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)]];
    
}

#pragma mark - 分割线
- (UIView *)createCustomLine
{
    
    NSString *text = ML(@"自定义时间");
    
    UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 75, 25)];
    textLabel.text = text;
    textLabel.font = [UIFont systemFontOfSize:15];
    textLabel.textColor = kUIColorFromRGB(0xA3A3A3);
    [textLabel sizeToFit];
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, textLabel.height)];
    textLabel.frame = CGRectMake((bgView.width-textLabel.width)/2, 0, textLabel.width, textLabel.height);
    [bgView addSubview:textLabel];
    
    
    UIView *leftLine = [[UIView alloc]initWithFrame:CGRectMake(20, (textLabel.height-1)/2, (SCREEN_WIDTH-textLabel.width-40*2)/2, 1)];
    leftLine.backgroundColor = GC.LINE;
    [bgView addSubview:leftLine];
    

    UIView *rightLine = [[UIView alloc]initWithFrame:CGRectMake(textLabel.right+20, (textLabel.height-1)/2, (SCREEN_WIDTH-textLabel.width-40*2)/2, 1)];
    rightLine.backgroundColor = GC.LINE;
    [bgView addSubview:rightLine];
    
    return bgView;
    
}
#pragma mark - 顶部按钮
- (UIView *)createTopBtn
{
    CGFloat itemWidth = (SCREEN_WIDTH-22*2-15*2)/3;
    CGFloat itemHeight = ASIZE(40);
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 90)];
    
    UIButton *btn1 = [self createSelectBtn:ML(@"近30天")];
    btn1.frame = CGRectMake(22, 30, itemWidth, itemHeight);
    [bgView addSubview:btn1];
    btn1.tag = 100;
    
    UIButton *btn2 = [self createSelectBtn:ML(@"近半年")];
    btn2.frame = CGRectMake(CGRectGetMaxX(btn1.frame)+15, 30, itemWidth, itemHeight);
    [bgView addSubview:btn2];
    btn2.tag = 101;
    
    UIButton *btn3 = [self createSelectBtn:ML(@"近一年")];
    btn3.frame = CGRectMake(CGRectGetMaxX(btn2.frame)+15, 30, itemWidth, itemHeight);
    [bgView addSubview:btn3];
    btn3.tag = 102;
    
    return bgView;
}

- (UIButton *)createSelectBtn:(NSString *)title
{
    UIButton *btn1 = [UIButton new];
    [btn1 setTitle:title forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(selectDefineDate:) forControlEvents:UIControlEventTouchUpInside];
    [btn1.titleLabel setFont:FontSize(15)];
    [btn1 setTitleColor:kUIColorFromRGB(0x000000) forState:UIControlStateNormal];
    btn1.layer.cornerRadius = 4;
    btn1.layer.borderColor = GC.LINE.CGColor;
    btn1.layer.borderWidth = 1;
    
    
    return btn1;
}

- (void)reloadDateLabel
{
    NSString * beginDateSeconds = [DateFormatString DateToFormatStrings:[[self.dateSpace objectForKey:BeginTimer] stringValue]];
    NSString * endDateSeconds = [DateFormatString DateToFormatStrings:[[self.dateSpace objectForKey:EndTimer] stringValue]];
    _beginDateLabel.text = [self.dateSpace objectForKey:BeginTimer]?beginDateSeconds:ML(@"请选择起始日期");
    _endDateLabel.text = [self.dateSpace objectForKey:EndTimer]?endDateSeconds:ML(@"请选择结束日期");
    _beginDateLabel.textColor = [[UIColor blackColor] colorWithAlphaComponent:[self.dateSpace objectForKey:BeginTimer]?0.9:0.5];
    _endDateLabel.textColor = [[UIColor blackColor] colorWithAlphaComponent:[self.dateSpace objectForKey:EndTimer]?0.9:0.5];
    self.beginLabelSelect = self.beginLabelSelect;
}

#pragma mark - action
- (void)dateLabelPressed:(UITapGestureRecognizer *)tap
{
    self.beginLabelSelect = (tap.view==_beginDateLabel);
    if(!self.beginLabelSelect&&![self.dateSpace objectForKey:EndTimer]){
        [self.dateSpace setObject:@([[NSDate date]timeIntervalSince1970]*1000) forKey:EndTimer];
        [self reloadDateLabel];
    }
}

- (void)sureBtnPressed
{
    if(self.dateSpace.allKeys.count<3){
        if(![self.dateSpace objectForKey:BeginTimer]){
            //[GMUtils showQuickTipWithText:@"请选择起始日期"];
        }else{
            //[GMUtils showQuickTipWithText:@"请选择结束日期"];
        }
        return;
    }
    if(self.block){
        NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSDate * beginDate = [NSDate dateWithTimeIntervalSince1970:[[self.dateSpace objectForKey:BeginTimer]doubleValue]/1000];
        NSString * beginString = [formatter stringFromDate:beginDate];
        NSDate * date = [formatter dateFromString:beginString];
        if(![date isEqual:beginDate]){
            [self.dateSpace setObject:@([date timeIntervalSince1970]*1000) forKey:BeginTimer];
        }
        NSDate * endDate = [NSDate dateWithTimeIntervalSince1970:[[self.dateSpace objectForKey:EndTimer]doubleValue]/1000];
        NSString * endString = [formatter stringFromDate:endDate];
        NSDate * dateEnd = [formatter dateFromString:endString];
        dateEnd = [NSDate dateWithTimeInterval:24*3600-1 sinceDate:dateEnd];
        if(![dateEnd isEqual:endDate]){
            [self.dateSpace setObject:@([dateEnd timeIntervalSince1970]*1000) forKey:EndTimer];
        }
        [self.dateSpace setObject:@"" forKey:DateKey];
        self.block(self.dateSpace);
        [self removeSelf];
    }
}

- (void)selectDefineDate:(UIButton *)sender
{

    if (self.block) {
        int perDays = 0;
        NSString *keyTitle = @"";
        
        if (sender.tag == 100) {
            perDays = 30;
            keyTitle = ML(@"近30天");
            
        }else if (sender.tag == 101){
            perDays = 183;
            keyTitle = ML(@"近半年");
            
        }else if (sender.tag == 102){
            perDays = 365;
            keyTitle = ML(@"近一年");
            
        }
        NSDate *minDate = [NSDate date];
        
        int64_t minCtime = (minDate.timeIntervalSince1970 - perDays*24*60*60)*1000;
        int64_t maxCtime = minDate.timeIntervalSince1970 * 1000;
        
        [self.dateSpace setObject:@(minCtime) forKey:BeginTimer];
        [self.dateSpace setObject:@(maxCtime) forKey:EndTimer];
        
        [self.dateSpace setObject:keyTitle forKey:DateKey];
        
        self.block(self.dateSpace);
        [self removeSelf];
    }

}

- (void)datepickerChange
{
    NSDate * newDate = _datePicker.date;
    NSString * key = self.beginLabelSelect?BeginTimer:EndTimer;
    [self.dateSpace setObject:@([newDate timeIntervalSince1970]*1000) forKey:key];
    [self reloadDateLabel];
}

- (void)modelViewWillShow:(NSNotification *)noti
{
    if(noti.object!=self){
        [self removeSelf];
    }
}

- (void)tap:(UITapGestureRecognizer *)tap
{
    CGPoint point = [tap locationInView:self];
    if(!CGRectContainsPoint(self.contentView.frame, point)){
        [self removeSelf];
    }
}

//#pragma mark - show
//- (void)showSelf
//{
//    self.superview.userInteractionEnabled = NO;
//    [UIView animateWithDuration:0.25 animations:^{
//        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
//        self.contentView.top = 0;
//    } completion:^(BOOL finished) {
//        self.superview.userInteractionEnabled = YES;
//    }];
//}
//
//- (void)removeSelf
//{
//    [self removeFromSuperview];
//
//    //    self.superview.userInteractionEnabled = NO;
//    //    [UIView animateWithDuration:0.25 animations:^{
//    //        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
//    //        self.contentView.top = -self.contentView.height;
//    //    } completion:^(BOOL finished) {
//    //        self.superview.userInteractionEnabled = YES;
//    //        [self removeFromSuperview];
//    //    }];
//}
//
//- (void)show
//{
//    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    [window addSubview:self];
//
//}

@end
