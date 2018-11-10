//
//  LKBaseModel.h
//  RCIOS-SDK
//
//  Created by gzkp on 2018/11/10.
//  Copyright © 2018年 RC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LKBaseModel : NSObject

@end

@interface NSObject(CreateSQL)
+(NSString*)getCreateTableSQL;
@end

NS_ASSUME_NONNULL_END
