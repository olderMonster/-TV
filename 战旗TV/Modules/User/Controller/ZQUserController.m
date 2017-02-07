//
//  ZQUserController.m
//  战旗TV
//
//  Created by 印聪 on 2016/12/28.
//  Copyright © 2016年 monster. All rights reserved.
//

#import "ZQUserController.h"
#import "ZQUserCell.h"
#import "ZQSettingController.h"
#import "ZQOfficialAnnouncementController.h"
#import "ZQLoginController.h"
#import "YCNavigationViewController.h"
#define kUserHeaderBgImageHeight (self.view.bounds.size.width * 350/750)
#define kUserHeaderHeight (self.view.bounds.size.width * 350/750 + self.view.bounds.size.width * 0.2 * 0.5 + 60)

@interface ZQUserController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property (nonatomic , strong)UITableView *userTableView;

@property (nonatomic , strong)UIView *headerView;
@property (nonatomic , strong)UIImageView *bgImageView;
@property (nonatomic , strong)UIImageView *avatarImageView;
@property (nonatomic , strong)UILabel *statusLabel; //登录状态
@property (nonatomic , strong)UILabel *goldenCoinsLabel;  //金币
@property (nonatomic , strong)UILabel *zqCoinsLabel;      //战旗币

@property (nonatomic , strong)NSMutableArray *userArray;

@end

@implementation ZQUserController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.userTableView];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout  = UIRectEdgeNone;
    
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    
    self.userTableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 44);
    
    self.headerView.frame = CGRectMake(0, -kUserHeaderHeight, self.view.bounds.size.width, kUserHeaderHeight);
    self.bgImageView.frame = CGRectMake(0, 0, self.headerView.bounds.size.width, kUserHeaderBgImageHeight);
    self.avatarImageView.bounds = CGRectMake(0, 0, self.headerView.bounds.size.width * 0.2, self.headerView.bounds.size.width * 0.2);
    self.avatarImageView.center = CGPointMake(self.headerView.center.x, CGRectGetMaxY(self.bgImageView.frame));
    self.statusLabel.frame = CGRectMake(0, CGRectGetMaxY(self.avatarImageView.frame) + 10, self.headerView.bounds.size.width, 20);
    self.goldenCoinsLabel.frame = CGRectMake(0, CGRectGetMaxY(self.statusLabel.frame) + 10, self.headerView.bounds.size.width * 0.5, 15);
    self.zqCoinsLabel.frame = CGRectMake(CGRectGetMaxX(self.goldenCoinsLabel.frame), self.goldenCoinsLabel.frame.origin.y, self.goldenCoinsLabel.bounds.size.width, self.goldenCoinsLabel.bounds.size.height);
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.navigationBarHidden = YES;

}


#pragma mark -- UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //总的偏移量
    CGFloat offsetY = scrollView.contentOffset.y;

    //相对屏幕向下的偏移量
    CGFloat offsetH = -(kUserHeaderHeight + offsetY);
    
    if (offsetH < 0){
        //向上滑动的时候不做任何操作
        return;
    }
    
    
    //修改headerView的位置以及高度（位置一定要变）
    CGRect frame = self.headerView.frame;
    frame.size.height = kUserHeaderHeight + offsetH;
    frame.origin.y = -kUserHeaderHeight - offsetH;
    self.headerView.frame = frame;

    
    CGRect imageFrame = self.bgImageView.frame;
    imageFrame.size.height = kUserHeaderBgImageHeight + offsetH;
    imageFrame.size.width = imageFrame.size.height * frame.size.width / kUserHeaderBgImageHeight ;
    imageFrame.origin.x = -(imageFrame.size.width - frame.size.width) * 0.5;
    self.bgImageView.frame = imageFrame;
    
    //头像的位置跟随背景图
    CGRect avatarFrame = self.avatarImageView.frame;
    avatarFrame.origin.y = imageFrame.size.height - avatarFrame.size.height * 0.5;
    self.avatarImageView.frame = avatarFrame;
    
    //状态的位置跟随头像
    CGRect statusFrame = self.statusLabel.frame;
    statusFrame.origin.y = CGRectGetMaxY(avatarFrame) + 10;
    self.statusLabel.frame = statusFrame;
    
    //金币的位置跟随状态
    CGRect goldenFrame = self.goldenCoinsLabel.frame;
    goldenFrame.origin.y = CGRectGetMaxY(statusFrame) + 10;
    self.goldenCoinsLabel.frame = goldenFrame;
    
    //战旗币的位置跟随金币
    CGRect zqCoinsFrame = self.zqCoinsLabel.frame;
    zqCoinsFrame.origin.y = goldenFrame.origin.y;
    self.zqCoinsLabel.frame = zqCoinsFrame;

}


#pragma mark -- UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.userArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.userArray[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cellIdentifier";
    ZQUserCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[ZQUserCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.item = self.userArray[indexPath.section][indexPath.row];
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
    if (section == self.userArray.count - 1) {
        return 10;
    }
    return 0.01;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.section == 0) {
        ZQLoginController *loginVC = [[ZQLoginController alloc]init];
        YCNavigationViewController *nav = [[YCNavigationViewController alloc]initWithRootViewController:loginVC];
        [self presentViewController:nav animated:YES completion:nil];
    }
    
    if (indexPath.section == 2) {
        if (indexPath.row == 1) {
            [self.navigationController pushViewController:[[ZQOfficialAnnouncementController alloc]init] animated:YES];
        }
    }
    
    if (indexPath.section == 3) {
        [self.navigationController pushViewController:[[ZQSettingController alloc]init] animated:YES];
    }
    
}


#pragma mark -- getters and setters
- (UITableView *)userTableView{
    if (_userTableView == nil) {
        _userTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _userTableView.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:249/255.0 alpha:1.0];
        _userTableView.dataSource = self;
        _userTableView.delegate = self;
        _userTableView.tableFooterView = [[UIView alloc] init];
        
        [_userTableView addSubview:self.headerView];
        _userTableView.contentInset = UIEdgeInsetsMake(kUserHeaderHeight, 0, 0, 0);
    }
    return _userTableView;
}


- (UIView *)headerView{
    if (_headerView == nil) {
        _headerView = [[UIView alloc]init];
        _headerView.backgroundColor = [UIColor whiteColor];
        
        [_headerView addSubview:self.bgImageView];
        [_headerView addSubview:self.avatarImageView];
        [_headerView addSubview:self.statusLabel];
        [_headerView addSubview:self.goldenCoinsLabel];
        [_headerView addSubview:self.zqCoinsLabel];
    }
    return _headerView;
}


- (UIImageView *)bgImageView{
    if (_bgImageView == nil) {
        _bgImageView = [[UIImageView alloc]init];
        _bgImageView.image = [UIImage imageNamed:@"bg_gerenzhongxin"];
        _bgImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _bgImageView;
}


- (UIImageView *)avatarImageView{
    if (_avatarImageView == nil) {
        _avatarImageView = [[UIImageView alloc]init];
        _avatarImageView.image = [UIImage imageNamed:@"default_avatar"];
        
        _avatarImageView.layer.masksToBounds = YES;
        _avatarImageView.layer.cornerRadius = self.view.bounds.size.width * 0.2 * 0.5;
        _avatarImageView.layer.borderColor = [UIColor whiteColor].CGColor;
        _avatarImageView.layer.borderWidth = 1;
        
    }
    return _avatarImageView;
}



- (UILabel *)statusLabel{
    if (_statusLabel == nil) {
        _statusLabel = [[UILabel alloc]init];
        _statusLabel.text = @"未登录";
        _statusLabel.font = [UIFont systemFontOfSize:13];
        _statusLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _statusLabel;
}

- (UILabel *)goldenCoinsLabel{
    if (_goldenCoinsLabel == nil) {
        _goldenCoinsLabel = [[UILabel alloc]init];
        _goldenCoinsLabel.font = [UIFont systemFontOfSize:10];
        _goldenCoinsLabel.textAlignment = NSTextAlignmentCenter;
        NSMutableAttributedString *coinAttrStr = [[NSMutableAttributedString alloc]initWithString:@"金币 --" attributes:@{NSFontAttributeName:_goldenCoinsLabel.font}];
        [coinAttrStr addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0,2)];
        [coinAttrStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:88/255.0 green:195/255.0 blue:252/255.0 alpha:1.0] range:NSMakeRange(2, coinAttrStr.length - 2)];
        _goldenCoinsLabel.attributedText = coinAttrStr;
    }
    return _goldenCoinsLabel;
}


- (UILabel *)zqCoinsLabel{
    if (_zqCoinsLabel == nil) {
        _zqCoinsLabel = [[UILabel alloc]init];
        _zqCoinsLabel.font = [UIFont systemFontOfSize:10];
        _zqCoinsLabel.textAlignment = NSTextAlignmentCenter;
        NSMutableAttributedString *zqAttrStr = [[NSMutableAttributedString alloc]initWithString:@"战旗币 --" attributes:@{NSFontAttributeName:_goldenCoinsLabel.font}];
        [zqAttrStr addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0,3)];
        //    [zqAttrStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(3, zqAttrStr.length - 3)];
        _zqCoinsLabel.attributedText = zqAttrStr;
    }
    return _zqCoinsLabel;
}







- (NSMutableArray *)userArray{
    if (_userArray == nil) {
        
        NSDictionary *liveDict =     @{@"imageName":@"ic_woyaozhibo",@"title":@"我要直播",@"titleColor":[UIColor colorWithRed:88/255.0 green:195/255.0 blue:252/255.0 alpha:1.0]};
        
        NSDictionary *taskDict =     @{@"imageName":@"ic_renwu",@"title":@"每日任务"};
        NSDictionary *historyDict =  @{@"imageName":@"ic_guankanlishi",@"title":@"观看历史"};
        NSDictionary *activityDict = @{@"imageName":@"ic_zuijinhuodong",@"title":@"最近活动"};
        
        NSDictionary *msgDict =      @{@"imageName":@"ic_sixin",@"title":@"私信",@"new":@YES};
        NSDictionary *noticeDict =   @{@"imageName":@"ic_guanfanggonggao",@"title":@"官方公告"};
        
        NSDictionary *settingDict =  @{@"imageName":@"ic_shezhi",@"title":@"设置",@"newMsg":@NO};
        
        _userArray = [NSMutableArray arrayWithArray:@[@[liveDict],@[taskDict,historyDict,activityDict],@[msgDict,noticeDict],@[settingDict]]];
        
    }
    return _userArray;
}



@end
