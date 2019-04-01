//
//  RCServiceFactory.m
//  RCIOS-SDK
//
//  Created by gzkp on 2019/3/30.
//  Copyright © 2019年 RC. All rights reserved.
//

#import "RCServiceFactory.h"
#import <CTMediator/CTMediator.h>

@interface RCServiceFactory ()

@property (nonatomic, strong) NSMutableDictionary *serviceStorage;

@end

@implementation RCServiceFactory

#pragma mark - getters and setters
- (NSMutableDictionary *)serviceStorage
{
    if (_serviceStorage == nil) {
        _serviceStorage = [[NSMutableDictionary alloc] init];
    }
    return _serviceStorage;
}

#pragma mark - life cycle
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static RCServiceFactory *sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[RCServiceFactory alloc] init];
    });
    return sharedInstance;
}

#pragma mark - public methods
- (id <RCServiceProtocol>)serviceWithIdentifier:(NSString *)identifier
{
    if (self.serviceStorage[identifier] == nil) {
        self.serviceStorage[identifier] = [self newServiceWithIdentifier:identifier];
    }
    return self.serviceStorage[identifier];
}

#pragma mark - private methods
- (id <RCServiceProtocol>)newServiceWithIdentifier:(NSString *)identifier
{
    return [[CTMediator sharedInstance] performTarget:identifier action:identifier params:nil shouldCacheTarget:NO];
}


@end
