//
//  RCPopDemoVC.m
//  RCIOS-SDK
//
//  Created by gzkp on 2018/8/22.
//  Copyright © 2018年 RC. All rights reserved.
//

#import "RCPopDemoVC.h"
#import "WPNormalPopView.h"
#import "KPUpdatePopView.h"
#import "KPEditTextPopView.h"
#import "KPRedAlertPopView.h"
#import "KPAddProFinishPopView.h"
#import "KPBandingUnitPopView.h"
#import "KPDepartSelectPopView.h"
#import "KPEditUintPopView.h"
// bottompop
#import "ShareBottomPopView.h"
#import "ShareProBottomPopView.h"
// top
#import "PaymentSelectView.h"


@interface RCPopDemoVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,assign) int bandUnitIndex;

@end

@implementation RCPopDemoVC
{
    NSArray *dataSourceArray;

    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    dataSourceArray = @[@"WPNormalPopView-0",@"WPNormalPopView-1",@"WPNormalPopView-2",@"WPNormalPopView-3",@"WPNormalPopView-4",@"KPUpdatePopView-5",@"KPEditTextPopView-6",@"KPEditTextPopView-7",@"KPRedAlertPopView-8",@"KPRedAlertPopView-9",@"KPAddProFinishPopView-10",@"KPBandingUnitPopView-11",@"KPDepartSelectPopView-12",@"KPEditUintPopView-13",@"ShareProBottomPopView-14",@"PaymentSelectView-15",@"PaymentSelectView-16"];
    
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    
    
}


#pragma mark - UITableViewDelegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentify = @"SDK-POP";
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", dataSourceArray[indexPath.row]];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataSourceArray.count;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        WPNormalPopView *popView = [[WPNormalPopView alloc]initWithTitle:@"普通弹框" content:@"普通弹框的内容不是很多也就一两行。。。。是的就一两行吧好像还差几个字？再加点吧。。。。" cancelBtnTitle:@"取消" okBtnTitle:@"确认" makeSure:^{
            
        } cancel:^{
            
        }];
        [popView showPopView];
    }else if (indexPath.row == 1){
        WPNormalPopView *popView = [[WPNormalPopView alloc] initWithTitle:nil content:@"版本过低，请更新最新版本" cancelBtnTitle:nil okBtnTitle:@"确认" makeSure:^{
            
        } cancel:^{
            
        }];
        [popView showPopView];
        
    }else if (indexPath.row == 2){
        WPNormalPopView *popView = [[WPNormalPopView alloc]initWithTitle:nil content:@"普通弹框的内容不是很多也就一两行。。。。是的就一两行吧好像还差几个字？再加点吧。。。。" cancelBtnTitle:@"取消" okBtnTitle:@"确认" makeSure:^{
            
        } cancel:^{
            
        }];
        [popView showPopView];
        
    }else if (indexPath.row == 3){
        WPNormalPopView *popView = [[WPNormalPopView alloc]initWithTitle:@"普通弹框" content:@"普通弹框的内容不是很多也就一两行。。。。是的就一两行吧好像还差几个字？再加点吧。。。。" alertTitle:@"警告内容！" cancelBtnTitle:@"取消" okBtnTitle:@"确认" makeSure:^{
            
        } cancel:^{
            
        }];
        [popView showPopView];
        
    }else if (indexPath.row == 4){
        WPNormalPopView *popView = [[WPNormalPopView alloc]initAttriWithTitle:@"多属性字符弹框" contents:@[@"普通弹框的内容不是很多也就一两行",@"。。。。",@"是的就一两行吧",@"好像还差几个字？",@"再加点吧。。。。"] colors:@[kUIColorFromRGB(0x000000),[UIColor redColor],kUIColorFromRGB(0x939395),kUIColorFromRGB(0x112233),kUIColorFromRGB(0x831829)] cancelBtnTitle:@"取消" okBtnTitle:@"确认" makeSure:^{
            
        } cancel:^{
            
        }];
        [popView showPopView];
        
    }else if (indexPath.row == 5){
        KPUpdatePopView *popView = [[KPUpdatePopView alloc]initWithTitle:nil subTitle:nil topImage:ImageName(@"boss_update_notic") content:@"【优化需求】iOS-PopView 1.0\n1，重构PopView弹窗控件\n2，目前项目中有多种PopView，继承和重用机制都不太完美\n3，本次重构目的将PopView基类做得更易于拓展，细分多种弹窗控件的模块，简化初始化接口\n4，做一个弹窗视图的文档便于开发者理解和使用" cancelBtnTitle:@"取消" okBtnTitle:@"确认" makeSure:^{
            
        } cancel:^{
            
        }];
        [popView showPopView];
        
    }else if (indexPath.row == 6){
        KPEditTextPopView *popView = [[KPEditTextPopView alloc]initWithTitle:@"请输入" placeHoldTitle:@"请输入" content:@"" rightText:nil cancelBtnTitle:@"取消" okBtnTitle:@"确认" makeSure:^(NSString *title) {
            
        } cancel:^{
            
        }];
        
        [popView showPopView];
        
    }else if (indexPath.row == 7){
        KPEditTextPopView *popView = [[KPEditTextPopView alloc]initWithTitle:@"请输入" placeHoldTitle:@"请输入" content:@"" rightText:@"个" cancelBtnTitle:@"取消"  okBtnTitle:@"确认" makeSure:^(NSString *title) {
            
        } cancel:^{
            
        }];
        
        [popView showPopView];
        
    }else if (indexPath.row == 8){
        KPRedAlertPopView *popView = [[KPRedAlertPopView alloc]initWithImage:ImageName(@"warnning") title:@"xxx将成为尘世集团的管理员，你将会变为老板角色。" content:@"该操作不可逆，请谨慎操作。" cancelBtnTitle:@"取消" okBtnTitle:@"确定更换" makeSure:^(NSString *code, int32_t type) {
            
        } cancel:^{
            
        }];
        popView.alertPopType = 1;
        popView.account = @"xxx";
        [popView showPopView];
        
    }else if (indexPath.row == 9){
        KPRedAlertPopView *popView = [[KPRedAlertPopView alloc]initWithImage:ImageName(@"popup_bell") title:@"当前软件版本过低，请升级到最新版！" content:nil cancelBtnTitle:nil okBtnTitle:@"立即更新" makeSure:^(NSString *code, int32_t type) {
            
        } cancel:^{
            
        }];
        [popView showPopView];
        
    }else if (indexPath.row == 10){
        NSArray *textArray = @[@"保存成功！",@"继续新增",@"复制新增",@"返回列表"];
        UIImage *image1 = [UIImage imageNamed:@"popup_ok"];
        UIImage *image2 = [UIImage imageNamed:@"still_add_item"];
        UIImage *image3 = [UIImage imageNamed:@"copy_add_newitem"];
        UIImage *image4 = [UIImage imageNamed:@"back_to_list"];
        
        NSArray *imageArray = @[image1,image2,image3,image4];
        
        KPAddProFinishPopView *popView = [[KPAddProFinishPopView alloc]initTextArray:textArray imageArray:imageArray clickBtnAction:^(NSInteger index) {
            
            
        }];
        [popView showPopView];
        
    }else if (indexPath.row == 11){
        
        @RCWeak(self)
        KPBandingUnitPopView *popView = [[KPBandingUnitPopView alloc]initWithTitle:ML(@"绑定单位") content:ML(@"即下单时扫该条码后选中的单位") unitArr:@[@"1",@"2",@"3"] selectUnit:^(int selectIndex) {
            @RCStrong(self)
            self.bandUnitIndex = selectIndex;
            
        }];
        [popView setSelectIndex:self.bandUnitIndex];
        
        [popView showPopView];
        
        
    }else if (indexPath.row == 12){
        
        KPDepartSelectPopView * popView = [[KPDepartSelectPopView alloc] initWithTitle:ML(@"确定出库扣减库存？") FromDepartment:nil andDepartments:[KPDepartment createDepartments] cancelBtnTitle:ML(@"取消") okBtnTitle:ML(@"确认") makeSure:^(KPDepartment *toDepartment) {
            
        } cancel:^{
            
        }];
        
        [popView showPopView];
        
        
    }else if(indexPath.row == 13){
        
        KPEditUintPopView *popView = [[KPEditUintPopView alloc]initWithTitle:ML(@"编辑单位") unitTitle:@"箱" number:0.5  baseUnitTitle:@"个" isDefaultUnit:YES cancelBtnTitle:@"删除" okBtnTitle:ML(@"确定") makeSure:^(NSString *unitTitle, double number, BOOL isDefaultUnit) {
            
        } cancel:^{
            
            
        } delete:^{
            
        }];
        [popView showPopView];
        
    }else if(indexPath.row == 14){
        
        ShareProBottomPopView *popView = [[ShareProBottomPopView alloc]initTextArray:ShareArray imageArray:@[ImageName(@"share_weixin"),ImageName(@"share_firend")] clickBtnAction:^(NSInteger index) {
            
        }];
        
        [popView showPopView];
        
    }else if(indexPath.row == 15){
        
        PaymentSelectView *selectView = [[PaymentSelectView alloc]initWithSelectArr:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7"] selectIndex:0];
        [selectView showPopView];
        selectView.selectType = ^(NSInteger tag) {
            
            
        };
    }else if(indexPath.row == 16){
        
        PaymentSelectView *selectView = [[PaymentSelectView alloc]initWithSelectArr:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7"] selectIndex:0];
        selectView.popType = POPShowFromTop;
        selectView.originY = self.navigationController.navigationBar.frame.size.height + [[UIApplication sharedApplication] statusBarFrame].size.height;
        [selectView showPopView];
        selectView.selectType = ^(NSInteger tag) {
            
            
        };
    }
    

    else{
        WPNormalPopView *popView = [[WPNormalPopView alloc]initWithTitle:nil content:nil cancelBtnTitle:@"取消" okBtnTitle:@"确认" makeSure:^{
            
        } cancel:^{
            
        }];
        [popView showPopView];
        
    }
    
}




@end
