//
//  ZQRecreationController.m
//  战旗TV
//
//  Created by 印聪 on 2016/12/28.
//  Copyright © 2016年 monster. All rights reserved.
//

#import "ZQEntertainController.h"

#import "OMSegmentedControl.h"
#import "ZQBaiBianZhuBoController.h"
#import "ZQDaRenController.h"
#import "ZQQiMiaoDreamController.h"
#import "ZQEntainmentLiveController.h"

@interface ZQEntertainController ()<OMSegmentedControlDelegate,UIScrollViewDelegate , ZQBaiBianZhuBoControllerDelegate , ZQDaRenControllerDelegate , ZQQiMiaoDreamControllerDelegate>

@property (nonatomic , strong)OMSegmentedControl *segControl;
@property (nonatomic , strong)UIScrollView *entainmentScrollView;
@property (nonatomic , strong)ZQBaiBianZhuBoController *baibianVC;
@property (nonatomic , strong)ZQDaRenController *daRenVC;
@property (nonatomic , strong)ZQQiMiaoDreamController *qiMiaoVC;

@end

@implementation ZQEntertainController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self initNavgationBar];
    
    [self.view addSubview:self.segControl];
    [self.view addSubview:self.entainmentScrollView];
    
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    self.segControl.frame = CGRectMake(0, 0, self.view.bounds.size.width, 30);
    self.entainmentScrollView.frame = CGRectMake(0, CGRectGetMaxY(self.segControl.frame), self.view.bounds.size.width, self.view.bounds.size.height - CGRectGetMaxY(self.segControl.frame) - 44);
    self.baibianVC.view.frame = self.entainmentScrollView.bounds;
    self.daRenVC.view.frame = CGRectMake(CGRectGetMaxX(self.baibianVC.view.frame), 0, self.entainmentScrollView.bounds.size.width, self.entainmentScrollView.bounds.size.height);
    self.qiMiaoVC.view.frame = CGRectMake(CGRectGetMaxX(self.daRenVC.view.frame), 0, self.entainmentScrollView.bounds.size.width, self.entainmentScrollView.bounds.size.height);
}


#pragma mark -- private method
- (void)initNavgationBar{
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"nav2_search"] forState:UIControlStateNormal];
    leftBtn.frame = CGRectMake(0, 0, 20, 20);
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"nav2_history"] forState:UIControlStateNormal];
    rightBtn.frame = CGRectMake(0, 0, 20, 20);
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    //设置titleView
    //137 x 72
    UIImageView *logoImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"nav2_logo"]];
    logoImageView.frame = CGRectMake(0, 0, 68.5, 36);
    self.navigationItem.titleView = logoImageView;
    
}

- (void)goToLiveRoom:(NSArray *)rooms showIndex:(NSInteger)index{
    
    ZQEntainmentLiveController *liveVC = [[ZQEntainmentLiveController alloc]init];
    liveVC.liveRooms = rooms;
    liveVC.currentShowIndex = index;
    [self presentViewController:liveVC animated:YES completion:nil];
    
}



#pragma mark -- OMSegmentedControlDelegate
- (void)segmentControl:(OMSegmentedControl *)segControl didSelectSegmentIndex:(NSInteger)segmentIndex{
    self.entainmentScrollView.contentOffset = CGPointMake(self.view.bounds.size.width * segmentIndex, 0);
}



#pragma mark -- ZQBaiBianZhuBoControllerDelegate
- (void)baiBianZHuoBoLiving:(NSArray *)rooms index:(NSInteger)index{
//    [self goToLiveRoom:rooms showIndex:index];
    
    ZQEntainmentLiveController *liveVC = [[ZQEntainmentLiveController alloc]init];
    liveVC.cellType = ZQEntainmentLiveCellTypeBaiBianZhuBo;
    liveVC.liveRooms = rooms;
    liveVC.currentShowIndex = index;
    [self presentViewController:liveVC animated:YES completion:nil];
    
}


#pragma mark -- ZQDaRenControllerDelegate
- (void)meiPaiDaRenLiving:(NSArray *)rooms index:(NSInteger)index{
//    [self goToLiveRoom:rooms showIndex:index];
    
    ZQEntainmentLiveController *liveVC = [[ZQEntainmentLiveController alloc]init];
    liveVC.cellType = ZQEntainmentLiveCellTypeDaRenMeiPai;
    liveVC.liveRooms = rooms;
    liveVC.currentShowIndex = index;
    [self presentViewController:liveVC animated:YES completion:nil];
}


#pragma mark -- ZQQiMiaoDreamControllerDelegate
- (void)qiMiaoMengGongChangLiving:(NSArray *)rooms index:(NSInteger)index{
//    [self goToLiveRoom:rooms showIndex:index];
    
    ZQEntainmentLiveController *liveVC = [[ZQEntainmentLiveController alloc]init];
    liveVC.cellType = ZQEntainmentLiveCellTypeBaiBianZhuBo;
    liveVC.liveRooms = rooms;
    liveVC.currentShowIndex = index;
    [self presentViewController:liveVC animated:YES completion:nil];
    
}


#pragma mark -- UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat contentX = scrollView.contentOffset.x;
    NSInteger index = contentX / scrollView.bounds.size.width;
    self.segControl.selectedSegmentIndex = index;
}

#pragma mark -- getters and setters
- (OMSegmentedControl *)segControl{
    if (_segControl == nil) {
        _segControl = [[OMSegmentedControl alloc]initWithSegMode:OMSegmentedControlModeShowAll segItemMode:OMSegmentedControlItemModeSlipeBottom];
        
        _segControl.selectedTextColor = [UIColor colorWithRed:88/255.0 green:195/255.0 blue:252/255.0 alpha:1.0];
        _segControl.normalTextColor = [UIColor blackColor];
        _segControl.slipeColor = [UIColor colorWithRed:88/255.0 green:195/255.0 blue:252/255.0 alpha:1.0];
        [_segControl items:@[@"百变主播",@"达人美拍",@"奇妙梦工厂"] key:nil];
        _segControl.segmentControlDelegate = self;
        
    }
    return _segControl;
}


- (UIScrollView *)entainmentScrollView{
    if (_entainmentScrollView == nil) {
        _entainmentScrollView = [[UIScrollView alloc]init];
        _entainmentScrollView.backgroundColor = [UIColor whiteColor];
        _entainmentScrollView.contentSize = CGSizeMake(self.view.bounds.size.width * 3, 0);
        _entainmentScrollView.showsVerticalScrollIndicator = NO;
        _entainmentScrollView.showsHorizontalScrollIndicator = NO;
        _entainmentScrollView.pagingEnabled = YES;
        _entainmentScrollView.delegate = self;
        
        [_entainmentScrollView addSubview:self.baibianVC.view];
        [_entainmentScrollView addSubview:self.daRenVC.view];
        [_entainmentScrollView addSubview:self.qiMiaoVC.view];
    }
    return _entainmentScrollView;
}


- (ZQBaiBianZhuBoController *)baibianVC{
    if (_baibianVC == nil) {
        _baibianVC = [[ZQBaiBianZhuBoController alloc]init];
        _baibianVC.delegate = self;
    }
    return _baibianVC;
}

- (ZQDaRenController *)daRenVC{
    if (_daRenVC == nil) {
        _daRenVC = [[ZQDaRenController alloc]init];
        _daRenVC.delegate = self;
    }
    return _daRenVC;
}

- (ZQQiMiaoDreamController *)qiMiaoVC{
    if (_qiMiaoVC == nil) {
        _qiMiaoVC = [[ZQQiMiaoDreamController alloc]init];
        _qiMiaoVC.delegate = self;
    }
    return _qiMiaoVC;
}

@end
