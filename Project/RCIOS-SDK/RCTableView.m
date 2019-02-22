//
//  RCTableView.m
//  RCIOS-SDK
//
//  Created by gzkp on 2019/2/22.
//  Copyright © 2019年 RC. All rights reserved.
//

#import "RCTableView.h"
#import <MJRefresh/MJRefresh.h>


@implementation RCTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    
    if (self) {
        
        self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
        }];
        
    }
    
    return self;
}



@end
