//
//  RCTableView.m
//  RCIOS-SDK
//
//  Created by gzkp on 2019/2/22.
//  Copyright © 2019年 RC. All rights reserved.
//

#import "RCTableView.h"
#import <MJRefresh/MJRefresh.h>
#import "RCMJRefreshNormalHeader.h"

@implementation RCTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    
    if (self) {
        
        
        MJRefreshHeader *header = [RCMJRefreshNormalHeader headerWithRefreshingBlock:^{
            
        }];
        
        header.frame = CGRectMake(0, 0, SCREEN_WIDTH, 100);
        
        self.mj_header = header;
    }
    
    return self;
}





@end
