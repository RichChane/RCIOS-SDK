//
//  DoubleDatePickerView.h
//  FMDB
//
//  Created by gzkp on 2018/11/30.
//

#import <UIKit/UIKit.h>
#import "NSCalendar+Util.h"
#import "RankEnum.h"
#import "PickerPopBaseView.h"

/**
 
 dateSpace : 各种数据
 @"BottomBtn":Array - 控件底部按钮
 @"BeginTimer":BeginTimer - 起始时间
 @"EndTimer":int - 结束时间
 */
typedef void(^dateSelectBlock)(NSDictionary * dateSpace);

@interface DoubleDatePickerView : PickerPopBaseView

@property (nullable, nonatomic, strong) NSDate *maximumDate;
@property (nullable, nonatomic, strong) NSDate *minimumDate;

/**
 
 dateSpace : 各种数据
 @"BottomBtn":Array - 控件底部按钮
 
 
 */
- (id)initWithDateSpace:(NSMutableDictionary *)dateSpace block:(dateSelectBlock)block;

- (void)show;

- (void)removeSelf;

@end
