//
//  KPTextField.h
//  kpkd
//
//  Created by gzkp on 2017/9/4.
//  Copyright © 2017年 kptech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KPTextField : UITextField<UITextFieldDelegate>

@property (nonatomic,assign) double tagNum;
@property (nonatomic,strong) NSString *tagId;


@end
