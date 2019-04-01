//
//  RCAPIManagerDemoVC.m
//  RCIOS-SDK
//
//  Created by gzkp on 2019/3/30.
//  Copyright © 2019年 RC. All rights reserved.
//

#import "RCAPIManagerDemoVC.h"
#import "RCNetworkingDefines.h"
#import "DemoAPIManager.h"

@interface RCAPIManagerDemoVC ()<RCAPIManagerCallBackDelegate>

@property (nonatomic, strong) UIButton *startRequestButton;
@property (nonatomic, strong) DemoAPIManager *demoAPIManager;

@end

@implementation RCAPIManagerDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.startRequestButton];
    
    [self.startRequestButton sizeToFit];
    self.startRequestButton.center = self.view.center;
    
    
}

#pragma mark - RCAPIManagerCallBackDelegate
- (void)managerCallAPIDidSuccess:(RCAPIBaseManager *)manager
{
    NSLog(@"%@", [manager fetchDataWithReformer:nil]);
}

- (void)managerCallAPIDidFailed:(RCAPIBaseManager *)manager
{
    NSLog(@"%@", [manager fetchDataWithReformer:nil]);
}

#pragma mark - event response
- (void)didTappedStartButton:(UIButton *)startButton
{
    [self.demoAPIManager loadData];
}

#pragma mark - getters and setters
- (DemoAPIManager *)demoAPIManager
{
    if (_demoAPIManager == nil) {
        _demoAPIManager = [[DemoAPIManager alloc] init];
        _demoAPIManager.delegate = self;
    }
    return _demoAPIManager;
}

- (UIButton *)startRequestButton
{
    if (_startRequestButton == nil) {
        _startRequestButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_startRequestButton setTitle:@"send request" forState:UIControlStateNormal];
        [_startRequestButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_startRequestButton addTarget:self action:@selector(didTappedStartButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _startRequestButton;
}

@end
