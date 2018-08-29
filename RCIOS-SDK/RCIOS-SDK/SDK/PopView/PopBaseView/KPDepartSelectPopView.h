//
//  KPDepartSelectPopView.h
//  kpkd
//
//  Created by lkr on 2018/5/25.
//  Copyright © 2018年 kptech. All rights reserved.
//

#import "PopBaseView.h"
#import "KPDepartment.h"


typedef void(^ConfirmDepart)(KPDepartment * toDepartment);

@interface KPDepartSelectPopView : PopBaseView

- (instancetype)initWithTitle:(NSString*)title FromDepartment:(KPDepartment *)department andDepartments:(NSArray *)departments cancelBtnTitle:(NSString*)cancelBtnTitle okBtnTitle:(NSString*)okBtnTitle  makeSure:(ConfirmDepart)makeSure cancel:(Cancel)cancel;

@end
