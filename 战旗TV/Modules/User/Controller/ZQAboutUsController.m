//
//  ZQAboutUsController.m
//  战旗TV
//
//  Created by 印聪 on 2017/1/6.
//  Copyright © 2017年 monster. All rights reserved.
//

#import "ZQAboutUsController.h"
#import "ZQSettingCell.h"
@interface ZQAboutUsController ()<UITableViewDataSource , UITableViewDelegate>

@property (nonatomic , strong)UITableView *aboutTableView;

@property (nonatomic , strong)NSArray *aboutArray;

@end

@implementation ZQAboutUsController


#pragma mark -- Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"关于我们";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.aboutTableView];
    [self setHeaderView];
}


- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    self.aboutTableView.frame = self.view.bounds;
    
}

#pragma mark -- private method
- (void)setHeaderView{
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 150)];
    headerView.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:249/255.0 alpha:1.0];
    
    //290 x 152
    UIImageView *logoImageView = [[UIImageView alloc]init];
    logoImageView.image = [UIImage imageNamed:@"login_logo"];
    logoImageView.bounds = CGRectMake(0, 0, 293 * 0.4, 152 * 0.4);
    logoImageView.center = headerView.center;
    [headerView addSubview:logoImageView];
    
    self.aboutTableView.tableHeaderView = headerView;
    
}


#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.aboutArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cellIdentifier";
    ZQSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[ZQSettingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.settingDict = self.aboutArray[indexPath.row];
    cell.subTitleFont = [UIFont systemFontOfSize:12];
    return cell;
}

#pragma mark -- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.row == 2) {
        
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"公众号复制成功" message:@"店家右上角+号，“添加朋友”，粘贴并搜索，即可关注" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [alertVC dismissViewControllerAnimated:YES completion:nil];
        }];
        UIAlertAction *wxAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alertVC addAction:cancelAction];
        [alertVC addAction:wxAction];
        [self presentViewController:alertVC animated:YES completion:nil];
    }
    
}


#pragma mark -- getters and setters
- (UITableView *)aboutTableView{
    if (_aboutTableView == nil) {
        _aboutTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _aboutTableView.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:249/255.0 alpha:1.0];
        _aboutTableView.dataSource = self;
        _aboutTableView.delegate = self;
        _aboutTableView.tableFooterView = [[UIView alloc]init];
    }
    return _aboutTableView;
}

- (NSArray *)aboutArray{
    if (_aboutArray == nil) {
        _aboutArray = @[@{@"title":@"版本",@"subTitle":@"V3.2.5"},
                        @{@"title":@"评价我们",@"arrow":@YES},
                        @{@"title":@"关注我们",@"arrow":@YES,@"arrowText":@"官方微信号：战旗直播平台"}];
        
    }
    return _aboutArray;
}


@end
