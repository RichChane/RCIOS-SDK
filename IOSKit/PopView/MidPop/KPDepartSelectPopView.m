//
//  KPDepartSelectPopView.m
//  kpkd
//
//  Created by lkr on 2018/5/25.
//  Copyright © 2018年 kptech. All rights reserved.
//

#import "KPDepartSelectPopView.h"
#import "NSString+Size.h"
#import "DownSelectView.h"

@interface KPDepartSelectPopView()<DownSelectDelegate>

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton * selectButton;
@property (nonatomic,copy) ConfirmDepart confirmDepart;

@property (nonatomic, strong) KPDepartment * department;
@property (nonatomic, strong) NSMutableArray * departments;
@property (nonatomic, assign) NSInteger selectIndex;
@property (nonatomic, strong) NSMutableArray * sortDepartments;

@end

static const CGFloat normalWith = 270;
static const CGFloat leftDis = 15;;

@implementation KPDepartSelectPopView
{
    NSString *_title;
}

/// department可能为nil  nil表示仓库被停用 改为默认仓
- (instancetype)initWithTitle:(NSString*)title FromDepartment:(KPDepartment *)department andDepartments:(NSArray *)departments cancelBtnTitle:(NSString*)cancelBtnTitle okBtnTitle:(NSString*)okBtnTitle  makeSure:(ConfirmDepart)makeSure cancel:(Cancel)cancel
{
    self = [super initWithCancelBtnTitle:cancelBtnTitle okBtnTitle:okBtnTitle];
    if (self) {
        
        self.cancel = cancel;
        self.confirmDepart = makeSure;
        _title = title;
        _department = department;
        _departments = [NSMutableArray arrayWithArray:departments];
        
        
        [self createData];
        [self createItems];
        
        [self refreshCenterView:self.topView contentView:self.contentView];
        //[self refreshContentFrame:normalWith height:172];
    }
    return self;
}

- (void)createData {
 
    _sortDepartments = [NSMutableArray array];
    
    for (KPDepartment * department in _departments) {

        [_sortDepartments addObject:department];
     
    }
    
    for (NSInteger i = 0; i < _sortDepartments.count; i++) {
        KPDepartment * department = _sortDepartments[i];
        if (!_department) {
            if (0 == department.departmentId) {
                _department = department;
                _selectIndex = i;
            }
        }else if (_department && _department.departmentId == department.departmentId) {
            _selectIndex = i;
        }
    }
    
    if (!_department && _sortDepartments.count > 0) {
        _department = _sortDepartments[0];
        _selectIndex = 0;
    }
}

- (void)createItems
{
    CGFloat labelWidth = normalWith - leftDis*2;
    
    if (_title && ![_title isEqualToString:@""])
    {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftDis, 18, labelWidth, 25)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = FontSize(17);
        _titleLabel.textColor = kUIColorFromRGB(0x282b34);
        _titleLabel.text = _title;
        _titleLabel.numberOfLines = 0;
        [self.contentView addSubview:_titleLabel];
    }
    
    UIImage * image = ImageName(@"common_down");
    _selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _selectButton.frame = CGRectMake(24, 65, normalWith - 48, 45);
    _selectButton.layer.masksToBounds = YES;
    _selectButton.layer.cornerRadius = 4;
    _selectButton.layer.borderWidth = 0.5;
    _selectButton.layer.borderColor = kUIColorFromRGBAlpha(0x000000, 0.2).CGColor;
    [_selectButton setTitle:_department.name forState:UIControlStateNormal];
    [_selectButton setTitleColor:kUIColorFromRGB(0x888888) forState:UIControlStateNormal];
    [_selectButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    _selectButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_selectButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_selectButton];
    
    UIImageView * imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = CGRectMake(_selectButton.frame.size.width - 40, _selectButton.frame.size.height/2 - 13, 26, 26);
    [_selectButton addSubview:imageView];
    
    self.contentView.frame = CGRectMake(0, 0, normalWith, 175);
}

#pragma mark - sure&cancel btn
- (void)clickSureBtn:(UIButton *)sender
{
    if (self.confirmDepart) {
        self.confirmDepart(_department);
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

#pragma mark - buttonAction
- (void)buttonAction:(UIButton *)sender {
    
    NSMutableArray * array = [[NSMutableArray alloc] init];
    for (KPDepartment * depart in _sortDepartments) {
        [array addObject:depart.name];
    }
    
    NSMutableArray * priceList = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < array.count; i++) {
        NSString *str = array[i];
        SelectToModel *lPri = [[SelectToModel alloc] initWithType:(ItemSelectTypeRadio)];
        lPri.modelSelect = ItemSelectUIModelDefault;
        lPri.msg = @1;
        if (_selectIndex == i) {
            [lPri selectModelToDo:YES];
        }
        lPri.name = str;
        
        [priceList addObject:lPri];
    }
    
    CGPoint point = [_selectButton convertPoint:CGPointMake(0, 0) toView:self];
    // 创建选择栏
    if (priceList && [priceList count]) {
        DownSelectView * selectView = [[DownSelectView alloc] initWithView:self];
        [selectView setTag:10000];
        selectView.downDelegate = self;
        selectView.selectedItemUI = kUIColorFromRGBAlpha(0x000000, 0.9);
        selectView.bgColor = [UIColor clearColor];
        selectView.layer.shadowColor = kUIColorFromRGB(0x000000).CGColor;
        selectView.layer.shadowOffset = CGSizeMake(2, 2);
        selectView.layer.shadowOpacity = 0.5;
        selectView.layer.shadowRadius = 5;

        [selectView openSelectFrame:CGRectMake(point.x, point.y, _selectButton.frame.size.width, SCREEN_HEIGHT - point.y) ItemHeight:49 List:priceList];
    }
    
}

- (void)tapAction:(UITapGestureRecognizer *)sender {
    DownSelectView * selectView = [self viewWithTag:10000];
    if (selectView) {
        [selectView hideSelect];
    }
}

#pragma mark - DownSelectDelegate
- (void)downSelectView:(id)selectView Data:(id)typeData FromModel:(BOOL)isFromModel {
    
    if ([selectView isKindOfClass:[DownSelectView class]]) {
        SelectToModel * model = (SelectToModel *)typeData;
        NSString * title = model.name;
        [_selectButton setTitle:title forState:UIControlStateNormal];
        for (NSInteger i = 0; i < _sortDepartments.count; i++) {
            KPDepartment * depart = _sortDepartments[i];
            if ([title isEqualToString:depart.name]) {
                _selectIndex = i;
                _department = depart;
            }
        }
    }
}

- (void)colseView {
    
}

@end
