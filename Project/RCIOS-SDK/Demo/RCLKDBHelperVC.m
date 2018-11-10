//
//  RCLKDBHelperVC.m
//  RCIOS-SDK
//
//  Created by gzkp on 2018/11/10.
//  Copyright © 2018年 RC. All rights reserved.
//

#import "RCLKDBHelperVC.h"
#import "TestLKModel.h"
#import "LKBaseModel.h"

@interface RCLKDBHelperVC ()

@end

@implementation RCLKDBHelperVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.view.backgroundColor = [UIColor whiteColor];

    
    UITextView* textview = [[UITextView alloc]init];
    textview.frame = CGRectMake(15, 80 + 30, self.view.bounds.size.width - 30, self.view.bounds.size.height-60-80);
    textview.textColor = [UIColor blackColor];
    textview.delegate =self;
    [self.view addSubview:textview];
    
    [self test];
}

- (void)test
{
    // table
    LKDBHelper *dbHelper = [TestLKModel getUsingLKDBHelper];
    
//    [TestLKModel getCreateTableSQL];
//    [TestLKModelForeign getCreateTableSQL];
    
    // model
    TestLKModel *test = [TestLKModel createModel];
    
    //同步 插入第一条 数据   synchronous insert the first
    [test saveToDB];
 
    
    //更改主键继续插入   Insert the change after the primary key
    test.age = 17;
    [dbHelper insertToDB:test];
    
    //事物  transaction
    [dbHelper executeForTransaction:^BOOL(LKDBHelper *helper) {
        
        test.name = @"1";
        BOOL success = [helper insertToDB:test];
        
        test.name = @"2";
        success = [helper insertToDB:test];
        
        //重复主键   duplicate primary key
        test.name = @"1";
        test.rowid = 0;     //no new object,should set rowid:0
        BOOL insertSucceed = [helper insertWhenNotExists:test];
        
        //insert fail
        if(insertSucceed == NO)
        {
            ///rollback
            return NO;
        }
        else
        {
            ///commit
            return YES;
        }
    }];
    
    
    
    sleep(1);
    
    test.name = @"li si";
    [dbHelper insertToDB:test callback:^(BOOL isInsert) {
        
    }];
    
    
    
    /**
     //查询   search
     **/
    NSMutableArray* searchResultArray = nil;
    
    [TestLKModel searchWithSQL:@"select * from @t,TestLKModelAddress"];
    
    ///同步搜索 执行sql语句 把结果变为TestLKModel对象
    ///Synchronous search executes the SQL statement put the results into a TestLKModel object
    searchResultArray = [dbHelper searchWithSQL:@"select * from @t" toClass:[TestLKModel class]];
    for (id obj in searchResultArray) {
       
    }
    
    
    ///搜索所有值     search all
    searchResultArray = [TestLKModel searchWithWhere:nil orderBy:nil offset:0 count:100];
    for (id obj in searchResultArray) {
        //NSLog(@"%@",[obj printAllPropertys]);
    }
    
    
    ///只获取name那列的值   search with column 'name' results
    NSArray* nameArray = [TestLKModel searchColumn:@"name" where:nil orderBy:nil offset:0 count:0];
    
    
    
    ///
    
    sleep(2);
    
    
    
    //异步 asynchronous
    [dbHelper search:[TestLKModel class] where:nil orderBy:nil offset:0 count:100 callback:^(NSMutableArray *array) {
        
        //NSLog(@"异步搜索 结束,  async search end");
        for (NSObject* obj in array) {
            //NSLog(@"%@",[obj printAllPropertys]);
        }
        
        sleep(1);
        
        ///修改    update object
        TestLKModel* test2 = [array objectAtIndex:0];
        test2.name = @"wang wu";
        
        [dbHelper updateToDB:test2 where:nil];
        
        //NSLog(@"修改完成 , update completed ");
        
        ///all
        array =  [dbHelper search:[TestLKModel class] where:nil orderBy:nil offset:0 count:100];
        for (NSObject* obj in array) {
            //NSLog(@"%@",[obj printAllPropertys]);
        }
        
        
        ///delete
        test2.rowid = 0;
        BOOL ishas = [dbHelper isExistsModel:test2];
        if(ishas)
        {
            //删除    delete
            [dbHelper deleteToDB:test2];
        }
        
        //NSLog(@"删除完成, delete completed");
        sleep(1);
        
        ///all
        array =  [dbHelper search:[TestLKModel class] where:nil orderBy:nil offset:0 count:100];
        for (NSObject* obj in array) {
            //NSLog(@"%@",[obj printAllPropertys]);
        }
        
        //NSLog(@"示例 结束  example finished\n\n");
        
        
        
        //Expansion: Delete the picture is no longer stored in the database record
        //NSLog(@"扩展:  删除已不再数据库中保存的 图片记录 \n expansion: Delete the picture is no longer stored in the database record");
        //目前 已合并到LKDBHelper 中  就先写出来 给大家参考下
        
        [LKDBHelper clearNoneImage:[TestLKModel class] columns:[NSArray arrayWithObjects:@"img",nil]];
    }];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
