//
//  AppDelegate+Init.m
//  RCIOS-SDK
//
//  Created by gzkp on 2018/10/17.
//  Copyright © 2018年 RC. All rights reserved.
//

#import "AppDelegate+Init.h"
#import "PLeakSniffer.h"


@implementation AppDelegate (Init)

- (void)initVendors
{
    [[PLeakSniffer sharedInstance] installLeakSniffer];
    [[PLeakSniffer sharedInstance] addIgnoreList:@[@"MySingletonController"]];
    
}



@end
