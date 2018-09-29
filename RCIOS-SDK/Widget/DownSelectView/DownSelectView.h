//
//  DownSelectView.h
//  kpkd
//
//  Created by zhang yyuan on 2017/8/28.
//  Copyright © 2017年 kptech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RCIOS-SDK/BaseData.h>
#import <RCIOS-SDK/GeneralCore.h>

#define SelectPriceKey      @"SelectPriceKey"
#define SelectStockKey      @"SelectStockKey"
#define SelectStockNumb      @"SelectStockNumb"
#define SelectQuantityUnitIdKey      @"SelectQuantityUnitIdKey"
#define SelectPriceUnitIdKey      @"SelectPriceUnitIdKey"
#define SelectDepartmentId      @"SelectDepartmentId"
#define SelectTimeKey      @"SelectTimeKey"

typedef NS_ENUM (NSInteger,ItemSelectType)  {
    ItemSelectTypeFree = 0,
    
    ItemSelectTypeRadio = 1,            // 打勾logo 单选
    ItemSelectTypeMultiselect,          // 向上、向下logo 多选
    
    ItemSelectTypeRadio_2 ,            // 右下角打勾 单选
    
};

typedef NS_ENUM (NSInteger,ItemSelectUIModel)  {
    ItemSelectUIModelFree = 0,
    
    ItemSelectUIModelDefault = 1,
    ItemSelectUIModel_2,          // 右侧 有双副标题
    
};


@protocol DownSelectDelegate;

@interface SelectToModel : NSObject

@property(readonly) ItemSelectType typeSelect;           // 选中模式

@property ItemSelectUIModel modelSelect;           // 显示模式

@property(readonly) BOOL isSelected;

@property BOOL isFirstFire;     // 是否首次刷新

@property NSInteger fromUI;             // 来自那个组件
@property NSInteger tagSelecte;             // 必须先调动 selectModelToDo: 否则tagSelect设置无效
@property (nonatomic, strong) NSString *name;           //
@property (nonatomic, strong) id msg;

@property (nonatomic, assign) int64_t staffId;


- (instancetype)initWithType:(ItemSelectType)type;

- (void)selectModelToDo:(BOOL)is_select;

@end


@interface DownSelectView : UIView

@property (weak, nonatomic) id<DownSelectDelegate> downDelegate;
@property BOOL isAutoPop;            // 自动隐藏界面

@property (nonatomic, strong) UIColor *selectedItemUI;           // 默认UI 颜色
@property (nonatomic, strong) UIColor *bgColor;           // 默认背景色
@property CGFloat defSize;              // 字体大小

- (instancetype)initWithView:(UIView *)view;

- (void)openSelectOrgY:(CGFloat)org_y ItemHeight:(CGFloat)iHeight List:(NSArray<SelectToModel *> *)list;
- (void)openSelectFrame:(CGRect)frame ItemHeight:(CGFloat)iHeight List:(NSArray<SelectToModel *> *)list;

- (void)hideSelect;



@end


@interface SortSelect : UIView

@property (weak, nonatomic) id<DownSelectDelegate> downDelegate;
@property BOOL isNav;       //是否需要底部导航线段

/**
 初始化界面
 
 @param frame 视图大小
 @param showData 一个存储 SelectToModel 数组，tag=1表示升序、tag=2表示降序
 @return 返回 UIView
 */
- (instancetype)initWithFrame:(CGRect)frame ShowData:(NSArray<SelectToModel *> *)showData;

- (void)beginShow;

@end

@protocol DownSelectDelegate <NSObject>

@optional

- (void)colseView;

@required

/**
 返回操作结果
 
 @param typeData 选中SelectToModel数据
 @param isFromModel 是否来自这里的点击回调
 */
- (void)downSelectView:(id)selectView Data:(id)typeData FromModel:(BOOL)isFromModel;

@end
