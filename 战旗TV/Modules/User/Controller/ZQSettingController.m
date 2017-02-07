//
//  ZQSettingController.m
//  战旗TV
//
//  Created by 印聪 on 2017/1/6.
//  Copyright © 2017年 monster. All rights reserved.
//

#import "ZQSettingController.h"
#import "ZQSettingCell.h"
#import "ZQBarrageSettingController.h"
#import "ZQAboutUsController.h"
@interface ZQSettingController ()<UITableViewDataSource , UITableViewDelegate>

@property (nonatomic , strong)UITableView *settingTableView;
@property (nonatomic , strong)NSMutableArray *settingMArray;

@end

@implementation ZQSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"设置";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.settingTableView];
    
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    self.settingTableView.frame = self.view.bounds;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
}

#pragma mark -- private method
- (void)selectDecodingMethod{
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *softAction = [UIAlertAction actionWithTitle:@"软解(推荐设置)" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSMutableArray *tmpArray = [NSMutableArray arrayWithArray:self.settingMArray[0]];
        NSMutableDictionary *tmpDict = [NSMutableDictionary dictionaryWithDictionary:tmpArray[1]];
        tmpDict[@"subTitle"] = @"软解";
        [tmpArray replaceObjectAtIndex:1 withObject:tmpDict];
        [self.settingMArray replaceObjectAtIndex:0 withObject:tmpArray];
        [self.settingTableView reloadData];
    }];
    
    UIAlertAction *hardwareAction = [UIAlertAction actionWithTitle:@"硬解" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSMutableArray *tmpArray = [NSMutableArray arrayWithArray:self.settingMArray[0]];
        NSMutableDictionary *tmpDict = [NSMutableDictionary dictionaryWithDictionary:tmpArray[1]];
        tmpDict[@"subTitle"] = @"硬解";
        [tmpArray replaceObjectAtIndex:1 withObject:tmpDict];
        [self.settingMArray replaceObjectAtIndex:0 withObject:tmpArray];
        [self.settingTableView reloadData];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alertVC addAction:softAction];
    [alertVC addAction:hardwareAction];
    [alertVC addAction:cancelAction];
    
    [self presentViewController:alertVC animated:YES completion:nil];
}

#pragma mark -- UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.settingMArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.settingMArray[section] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cellIdentifier";
    ZQSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[ZQSettingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.settingDict = self.settingMArray[indexPath.section][indexPath.row];
    return cell;
}

#pragma mark -- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.section == 0){
        if (indexPath.row == 0) {
            [self.navigationController pushViewController:[[ZQBarrageSettingController alloc]init] animated:YES];
        }
        if (indexPath.row == 1) {
            [self selectDecodingMethod];
        }
    }
    
    if (indexPath.section == 1){
        if (indexPath.row == 2){
            [self.navigationController pushViewController:[[ZQAboutUsController alloc]init] animated:YES];
        }
    }
    
}


- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]init];
    headerView.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:249/255.0 alpha:1.0];
    return headerView;
}

#pragma mark -- getters and setters
- (UITableView *)settingTableView{
    if (_settingTableView == nil) {
        _settingTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _settingTableView.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:249/255.0 alpha:1.0];
        _settingTableView.dataSource = self;
        _settingTableView.delegate = self;
        _settingTableView.tableFooterView = [[UIView alloc]init];
    }
    return _settingTableView;
}


- (NSMutableArray *)settingMArray{
    if (_settingMArray == nil) {
        
        NSArray *tmpArray = @[@[@{@"title":@"弹幕设置",@"arrow":@YES},
                                @{@"title":@"解码方式",@"subTitle":@"软解"},
                                @{@"title":@"清除系统缓存",@"subTitle":@"0.0B"},
                                @{@"title":@"非WIFI环境下播放提醒",@"switch":@YES,@"open":@YES},
                                @{@"title":@"美拍全屏模式",@"switch":@YES,@"open":@YES}],
                              @[@{@"title":@"在线客服",@"arrow":@YES},
                                @{@"title":@"网络诊断",@"arrow":@YES},
                                @{@"title":@"关于我们",@"arrow":@YES}]];
        _settingMArray = [NSMutableArray arrayWithArray:tmpArray];
    }
    return _settingMArray;
}


@end
