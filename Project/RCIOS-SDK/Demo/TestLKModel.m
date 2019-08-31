//
//  TestLKModel.m
//  RCIOS-SDK
//
//  Created by gzkp on 2018/11/10.
//  Copyright © 2018年 RC. All rights reserved.
//

#import "TestLKModel.h"

@implementation TestLKModel

// 创建数据和表（所有的数据库和表都得用这个方法创建）
+(LKDBHelper *)getUsingLKDBHelper
{
    static LKDBHelper* db;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //        NSString* dbpath = [NSHomeDirectory() stringByAppendingPathComponent:@"asd/asd.db"];
        //        db = [[LKDBHelper alloc]initWithDBPath:dbpath];
        db = [[LKDBHelper alloc]initWithDBName:@"MainDB"];
    });
    return db;
}
//手动or自动 绑定sql列
+(NSDictionary *)getTableMapping
{
    return nil;
    //    return @{@"name":LKSQL_Mapping_Inherit,
    //             @"MyAge":@"age",
    //             @"img":LKSQL_Mapping_Inherit,
    //             @"MyDate":@"date",
    //
    //             // version 2 after add
    //             @"color":LKSQL_Mapping_Inherit,
    //
    //             //version 3 after add
    //             @"address":LKSQL_Mapping_UserCalculate,
    //             @"error":LKSQL_Mapping_Inherit
    //             };
}
//主键
+(NSString *)getPrimaryKey
{
    return @"name";
}

/////复合主键  这个优先级最高
+(NSArray *)getPrimaryKeyUnionArray
{
    return @[@"name",@"age"];
}
//表名
//+(NSString *)getTableName
//{
//    return @"自定义表名";
//}

+ (id)createModel
{
    //初始化数据模型  init object
    TestLKModel* test = [[TestLKModel alloc]init];
    test.name = @"zhan san";
    test.age = 16;

    //外键  foreign key
    LKTestForeign* foreign = [[LKTestForeign alloc]init];
    foreign.address = @":asdasdasdsadasdsdas";
    foreign.postcode  = 123341;
    foreign.addid = 213214;

    test.address = foreign;


    ///复杂对象 complex object
    test.blah = @[@"1",@"2",@"3"];
    test.blah = @[@"0",@[@1],@{@"2":@2},foreign];
    test.hoho = @{@"array":test.blah,@"foreign":foreign,@"normal":@123456,@"date":[NSDate date]};

    ///other
    test.isGirl = YES;
    test.like = 'I';
    test.img = [UIImage imageNamed:@"41.png"];
    test.date = [NSDate date];
    test.color = [UIColor orangeColor];
    test.error = @"nil";

    test.score = [[NSDate date] timeIntervalSince1970];

    test.data = [@"hahaha" dataUsingEncoding:NSUTF8StringEncoding];

    return test;
}

@end


@implementation LKTestForeignSuper
// 创建表用到
+ (LKDBHelper *)getUsingLKDBHelper
{
    return [TestLKModel getUsingLKDBHelper];
}

+(NSString *)getPrimaryKey
{
    return @"addid";
}
+(NSString *)getTableName
{
    return @"LKTestAddress";
}
@end

@implementation LKTestForeign
@end

