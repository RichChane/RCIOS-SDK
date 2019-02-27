//
//  RCTableView.m
//  RCIOS-SDK
//
//  Created by gzkp on 2019/2/22.
//  Copyright © 2019年 RC. All rights reserved.
//

#import "RCTableView.h"
#import <MJRefresh/MJRefresh.h>
#import "RCMJRefreshExternHeader.h"

@implementation RCTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    
    if (self) {
        
        
        RCMJRefreshExternHeader *header = [RCMJRefreshExternHeader headerWithRefreshingBlock:^{
            
        }];
        
        UIView *externView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
        externView.backgroundColor = [UIColor redColor];
        [header addExternView:externView];
        
        
        self.mj_header = header;
    }
    
    return self;
}





@end
