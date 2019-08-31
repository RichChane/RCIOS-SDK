//
//  TestLKModel.h
//  RCIOS-SDK
//
//  Created by gzkp on 2018/11/10.
//  Copyright © 2018年 RC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LKTestForeignSuper : NSObject
@property(copy,nonatomic)NSString* address;
@property int postcode;
@end

@interface LKTestForeign : LKTestForeignSuper
@property NSInteger addid;
@end


@interface TestLKModel : NSObject

@property(copy,nonatomic)NSString* name;
@property NSUInteger  age;
@property BOOL isGirl;

@property(strong,nonatomic)LKTestForeign* address;
@property(strong,nonatomic)NSArray* blah;
@property(strong,nonatomic)NSDictionary* hoho;

@property char like;

#ifdef __IPHONE_OS_VERSION_MIN_REQUIRED
@property(strong,nonatomic) UIImage* img;
@property(strong,nonatomic)UIColor* color;
@property CGRect frame1;
#else
@property(strong,nonatomic) NSImage* img;
@property(strong,nonatomic) NSColor* color;
@property NSRect frame1;
#endif

@property(strong,nonatomic) NSDate* date;

@property(copy,nonatomic)NSString* error;

//new add
@property CGFloat score;

@property(strong,nonatomic)NSData* data;

@property CGRect frame;

@property CGRect size;
@property CGPoint point;
@property NSRange range;

//+ (LKDBHelper *)shareTestModelDB;
+ (id)createModel;

@end



NS_ASSUME_NONNULL_END
