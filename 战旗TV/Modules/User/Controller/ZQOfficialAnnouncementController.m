//
//  ZQOfficialAnnouncementController.m
//  战旗TV
//
//  Created by 印聪 on 2017/1/11.
//  Copyright © 2017年 monster. All rights reserved.
//

#import "ZQOfficialAnnouncementController.h"
#import "OMSegmentedControl.h"
#import "ZQOfficialAllController.h"
#import "ZQNoticeController.h"
#import "ZQActiveController.h"
#import "ZQNewsController.h"
#import "ZQInterviewController.h"
@interface ZQOfficialAnnouncementController ()<UIScrollViewDelegate , OMSegmentedControlDelegate>

@property (nonatomic , strong)OMSegmentedControl *segmentControl;
@property (nonatomic , strong)UIScrollView *officialScrollView;

@property (nonatomic , strong)ZQOfficialAllController *allVC;
@property (nonatomic , strong)ZQNoticeController *noticeVC;
@property (nonatomic , strong)ZQActiveController *activeVC;
@property (nonatomic , strong)ZQNewsController *newsVC;
@property (nonatomic , strong)ZQInterviewController *interviewVC;

@end

@implementation ZQOfficialAnnouncementController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"官方公告";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self.view addSubview:self.segmentControl];
    [self.view addSubview:self.officialScrollView];
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    self.segmentControl.frame = CGRectMake(0, 0, self.view.bounds.size.width, 40);
    self.officialScrollView.frame = CGRectMake(0, CGRectGetMaxY(self.segmentControl.frame), self.view.bounds.size.width, self.view.bounds.size.height - CGRectGetMaxY(self.segmentControl.frame));
    
    self.allVC.view.frame = self.officialScrollView.bounds;
    self.noticeVC.view.frame = CGRectMake(CGRectGetMaxX(self.allVC.view.frame), 0, self.officialScrollView.bounds.size.width, self.officialScrollView.bounds.size.height);
    self.activeVC.view.frame = CGRectMake(CGRectGetMaxX(self.noticeVC.view.frame), 0, self.officialScrollView.bounds.size.width, self.officialScrollView.bounds.size.height);
    self.newsVC.view.frame = CGRectMake(CGRectGetMaxX(self.activeVC.view.frame), 0, self.officialScrollView.bounds.size.width, self.officialScrollView.bounds.size.height);
    self.interviewVC.view.frame = CGRectMake(CGRectGetMaxX(self.newsVC.view.frame), 0, self.officialScrollView.bounds.size.width, self.officialScrollView.bounds.size.height);
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

#pragma mark -- UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat offsetX = scrollView.contentOffset.x;
    NSInteger page = offsetX/scrollView.bounds.size.width;
    self.segmentControl.selectedSegmentIndex = page;
}

#pragma mark -- OMSegmentedControlDelegate
- (void)segmentControl:(OMSegmentedControl *)segControl didSelectSegmentIndex:(NSInteger)segmentIndex{
    
    self.officialScrollView.contentOffset = CGPointMake(self.officialScrollView.bounds.size.width * segmentIndex, 0);
    
}


#pragma mark -- getters and setters
- (OMSegmentedControl *)segmentControl{
    if (_segmentControl == nil) {
        _segmentControl = [[OMSegmentedControl alloc]initWithSegMode:OMSegmentedControlModeShowAll segItemMode:OMSegmentedControlItemModeSlipeBottom];
        _segmentControl.normalBackgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:249/255.0 alpha:1.0];
        _segmentControl.selectedBackgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:249/255.0 alpha:1.0];
        _segmentControl.selectedTextColor = [UIColor colorWithRed:88/255.0 green:195/255.0 blue:252/255.0 alpha:1.0];
        _segmentControl.slipeColor = [UIColor colorWithRed:88/255.0 green:195/255.0 blue:252/255.0 alpha:1.0];
        _segmentControl.normalTextColor = [UIColor blackColor];
        _segmentControl.font = [UIFont systemFontOfSize:12];
        [_segmentControl items:@[@"全部",@"公告",@"活动",@"新闻",@"访谈"] key:nil];
        _segmentControl.segmentControlDelegate = self;
    }
    return _segmentControl;
}


- (UIScrollView *)officialScrollView{
    if (_officialScrollView == nil) {
        _officialScrollView = [[UIScrollView alloc]init];
        _officialScrollView.backgroundColor = [UIColor whiteColor];
        _officialScrollView.showsVerticalScrollIndicator = NO;
        _officialScrollView.showsHorizontalScrollIndicator = NO;
        _officialScrollView.pagingEnabled = YES;
        _officialScrollView.delegate = self;
        _officialScrollView.contentSize = CGSizeMake(self.view.bounds.size.width * 5, 0);
        
        [_officialScrollView addSubview:self.allVC.view];
        [_officialScrollView addSubview:self.noticeVC.view];
        [_officialScrollView addSubview:self.activeVC.view];
        [_officialScrollView addSubview:self.newsVC.view];
        [_officialScrollView addSubview:self.interviewVC.view];
    }
    return _officialScrollView;
}

- (ZQOfficialAllController *)allVC{
    if (_allVC == nil) {
        _allVC = [[ZQOfficialAllController alloc]init];
    }
    return _allVC;
}

- (ZQNoticeController *)noticeVC{
    if (_noticeVC == nil) {
        _noticeVC = [[ZQNoticeController alloc]init];
    }
    return _noticeVC;
}

- (ZQActiveController *)activeVC{
    if (_activeVC == nil) {
        _activeVC = [[ZQActiveController alloc]init];
    }
    return _activeVC;
}

- (ZQNewsController *)newsVC{
    if (_newsVC == nil) {
        _newsVC = [[ZQNewsController alloc]init];
    }
    return _newsVC;
}

- (ZQInterviewController *)interviewVC{
    if (_interviewVC == nil) {
        _interviewVC = [[ZQInterviewController alloc]init];
    }
    return _interviewVC;
}


@end
