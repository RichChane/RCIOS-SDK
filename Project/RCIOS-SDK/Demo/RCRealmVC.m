//
//  RCRealmVC.m
//  RCIOS-SDK
//
//  Created by gzkp on 2018/11/8.
//  Copyright © 2018年 RC. All rights reserved.
//

#import "RCRealmVC.h"
#import <Realm/Realm.h>



@implementation RCRealmVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = WHITE_COLOR;
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    // 获取 Realm 文件的父目录
    NSString *folderPath = realm.configuration.fileURL.URLByDeletingLastPathComponent.path;
    
    // 禁用此目录的文件保护
    [[NSFileManager defaultManager] setAttributes:@{NSFileProtectionKey: NSFileProtectionNone}
                                     ofItemAtPath:folderPath error:nil];
    
    
}

@end
