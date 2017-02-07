//
//  ZQBarrageSettingController.m
//  战旗TV
//
//  Created by 印聪 on 2017/1/6.
//  Copyright © 2017年 monster. All rights reserved.
//

#import "ZQBarrageSettingController.h"
#import "ZQSettingCell.h"
#import "ZQBarrageAlphaCell.h"
#import "ZQBarrageSettingCell.h"
@interface ZQBarrageSettingController ()<UITableViewDataSource , UITableViewDelegate>

@property (nonatomic , strong)UITableView *barrSettingTableView;

@end

@implementation ZQBarrageSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"弹幕设置";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.barrSettingTableView];
    
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    self.barrSettingTableView.frame = self.view.bounds;
    
}


#pragma mark -- UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self == 0) {
        return 1;
    }
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellIdentifier = [NSString stringWithFormat:@"%ld%ld",(long)indexPath.section,(long)indexPath.row];
    if (indexPath.section == 0){
        ZQSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[ZQSettingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.settingDict = @{@"title":@"弹幕开关",@"switch":@YES,@"open":@YES};
        return cell;
    }else{
        
        if (indexPath.row == 0){
            ZQBarrageAlphaCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = [[ZQBarrageAlphaCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            }
            return cell;
        }else{
            
            
            if (indexPath.row == 1){
                ZQBarrageSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                if (cell == nil) {
                    cell = [[ZQBarrageSettingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                }
                cell.setDict =
                    @{
                    @"title":@"弹幕大小",
                    @"leftNormal":@"btn_setting_xiao_normal",@"leftSelected":@"btn_setting_zhong_highlight",
                    @"middleNormal":@"btn_setting_zhong_normal",@"middleSelected":@"btn_setting_zhong_highlight",
                    @"rightNormal":@"btn_setting_da_normal",@"rightSelected":@"btn_setting_da_highlight"
                    };
                return cell;
            }else{
                
                ZQBarrageSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                if (cell == nil) {
                    cell = [[ZQBarrageSettingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                }
                cell.setDict =
                    @{
                @"title":@"弹幕位置",
                @"leftNormal":@"btn_setting_shangfgang_normal",@"leftSelected":@"btn_setting_xiafang_highlight",
                @"middleNormal":@"btn_setting_quanping_normal",@"middleSelected":@"btn_setting_quanping_highlight",
                @"rightNormal":@"btn_setting_xiafang_normal",@"rightSelected":@"btn_setting_xiafang_highlight"
                    };
                return cell;
            }
            
            
        }
        
    }
  
}


#pragma mark -- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        if (indexPath.row == 0){
            return 80;
        }
        return 50;
    }
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}


- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]init];
    headerView.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:249/255.0 alpha:1.0];
    return headerView;
}

#pragma mark -- getters and setters
- (UITableView *)barrSettingTableView{
    if (_barrSettingTableView == nil) {
        _barrSettingTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _barrSettingTableView.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:249/255.0 alpha:1.0];
        _barrSettingTableView.dataSource = self;
        _barrSettingTableView.delegate = self;
    }
    return _barrSettingTableView;
}


@end
