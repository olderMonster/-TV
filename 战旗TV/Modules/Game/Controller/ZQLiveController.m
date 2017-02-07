//
//  ZQLiveController.m
//  战旗TV
//
//  Created by 印聪 on 2017/1/6.
//  Copyright © 2017年 monster. All rights reserved.
//

#import "ZQLiveController.h"
#import "OMPlayerView.h"
#import "OMSegmentedControl.h"
#import "ZQAnchorController.h"
#import "ZQLiveRankController.h"
@interface ZQLiveController ()<OMPlayerViewDelegate , OMSegmentedControlDelegate , UIScrollViewDelegate>

@property (nonatomic , strong)OMPlayerView *liveView;
@property (nonatomic , strong)OMSegmentedControl *segControl;
@property (nonatomic , strong)NSArray *pannelArray;
@property (nonatomic , strong)UIScrollView *infoScrollView;
@property (nonatomic , strong)UIButton *checkInButton; //签到按钮
@property (nonatomic , strong)ZQAnchorController *anchorVC; //主播
@property (nonatomic , strong)ZQLiveRankController *rankVC; //排行榜

@end

@implementation ZQLiveController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //这里需要根据主播是否在直播的状态来确定是否播放
    
    [self.view addSubview:self.liveView];
    [self.view addSubview:self.segControl];
    [self.view addSubview:self.infoScrollView];
    [self.view addSubview:self.checkInButton];
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
 
    self.liveView.frame = CGRectMake(0, 20, self.view.bounds.size.width, self.view.bounds.size.width * 9 / 16);
    CGFloat itemWidth = self.view.bounds.size.width / (self.pannelArray.count + 1);
    self.segControl.frame = CGRectMake(0,  CGRectGetMaxY(self.liveView.frame), itemWidth * self.pannelArray.count, 30);
    self.checkInButton.frame = CGRectMake(CGRectGetMaxX(self.segControl.frame), self.segControl.frame.origin.y, itemWidth, self.segControl.bounds.size.height);
    self.infoScrollView.frame = CGRectMake(0, CGRectGetMaxY(self.segControl.frame), self.view.bounds.size.width, self.view.bounds.size.height - CGRectGetMaxY(self.segControl.frame));
    self.anchorVC.view.frame = self.infoScrollView.bounds;
    self.rankVC.view.frame = CGRectMake(self.view.bounds.size.width * 3, 0, self.infoScrollView.bounds.size.width, self.infoScrollView.bounds.size.height);
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
    
    //保持手机高亮
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
    //关闭手机高亮
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
}


- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (BOOL)shouldAutorotate{
    return NO;
}


- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskLandscapeLeft;
}

#pragma mark -- UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat offsetX = scrollView.contentOffset.x;
    NSInteger page = offsetX / scrollView.bounds.size.width;
    self.segControl.selectedSegmentIndex = page;
}

#pragma mark -- OMSegmentedControlDelegate
- (void)segmentControl:(OMSegmentedControl *)segControl didSelectSegmentIndex:(NSInteger)segmentIndex{
    self.infoScrollView.contentOffset = CGPointMake(self.view.bounds.size.width * segmentIndex, 0);
}

#pragma mark -- OMPlayerViewDelegate
- (void)back{
    [self.liveView stop];
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark -- getters and setters
- (OMPlayerView *)liveView{
    if (_liveView == nil) {
        NSString *url = [NSString stringWithFormat:@"http://dlhls.cdn.zhanqi.tv/zqlive/%@.m3u8",self.roomInfo[@"videoId"]];
        _liveView = [[OMPlayerView alloc]initWithUrlString:url];
        _liveView.delegate = self;
    }
    return _liveView;
}


- (OMSegmentedControl *)segControl{
    if (_segControl == nil) {
        _segControl = [[OMSegmentedControl alloc]initWithSegMode:OMSegmentedControlModeShowAll segItemMode:OMSegmentedControlItemModeSlipeBottom];
        _segControl.selectedTextColor = [UIColor colorWithRed:88/255.0 green:195/255.0 blue:252/255.0 alpha:1.0];
        _segControl.slipeColor = [UIColor colorWithRed:88/255.0 green:195/255.0 blue:252/255.0 alpha:1.0];
        _segControl.font = [UIFont systemFontOfSize:12];
        [_segControl items:self.pannelArray key:nil];
        _segControl.segmentControlDelegate = self;
        _segControl.showBottomBoder = YES;
        _segControl.borderWidth = 2;
    }
    return _segControl;
}

- (UIButton *)checkInButton{
    if (_checkInButton == nil) {
        _checkInButton = [UIButton buttonWithType: UIButtonTypeCustom];
        _checkInButton.backgroundColor = [UIColor colorWithRed:88/255.0 green:195/255.0 blue:252/255.0 alpha:1.0];
        [_checkInButton setTitle:@"签到" forState:UIControlStateNormal];
        [_checkInButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _checkInButton.titleLabel.font = [UIFont systemFontOfSize:12];
    }
    return _checkInButton;
}

- (UIScrollView *)infoScrollView{
    if (_infoScrollView == nil) {
        
        _infoScrollView = [[UIScrollView alloc]init];
        _infoScrollView.backgroundColor = [UIColor whiteColor];
        _infoScrollView.contentSize = CGSizeMake(self.view.bounds.size.width * self.pannelArray.count, 0);
        _infoScrollView.showsVerticalScrollIndicator = NO;
        _infoScrollView.showsHorizontalScrollIndicator = NO;
        _infoScrollView.delegate = self;
        _infoScrollView.pagingEnabled = YES;
        
        [_infoScrollView addSubview:self.anchorVC.view];
        [_infoScrollView addSubview:self.rankVC.view];
    }
    return _infoScrollView;
    return _infoScrollView;
}


- (ZQAnchorController *)anchorVC{
    if (_anchorVC == nil) {
        _anchorVC = [[ZQAnchorController alloc]init];
        _anchorVC.roomId = self.roomInfo[@"id"];
        _anchorVC.anchorId = self.roomInfo[@"uid"];
    }
    return _anchorVC;
}

- (ZQLiveRankController *)rankVC{
    if (_rankVC == nil) {
        _rankVC = [[ZQLiveRankController alloc]init];
        _rankVC.roomId = self.roomInfo[@"id"];
    }
    return _rankVC;
}


- (NSArray *)pannelArray{
    if (_pannelArray == nil) {
        _pannelArray = @[@"主播",@"聊天",@"活动",@"排行榜"];
    }
    return _pannelArray;
}

@end
