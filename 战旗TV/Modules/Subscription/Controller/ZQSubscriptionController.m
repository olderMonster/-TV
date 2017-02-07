//
//  ZQSubscriptionController.m
//  战旗TV
//
//  Created by 印聪 on 2016/12/28.
//  Copyright © 2016年 monster. All rights reserved.
//

#import "ZQSubscriptionController.h"

#import "OMSegmentedControl.h"
#import "ZQSubsRecommendController.h"
#import "ZQSubsController.h"
#import "ZQSubsRankController.h"
#import "ZQLiveController.h"
@interface ZQSubscriptionController ()<UIScrollViewDelegate,OMSegmentedControlDelegate , ZQSubsRecommendControllerDelegate , ZQSubsControllerDelegate>

@property (nonatomic , strong)UIView *navigationBarView;
@property (nonatomic , strong)OMSegmentedControl *segmentControl;

@property (nonatomic , strong)UIScrollView *subsScrollView;
@property (nonatomic , strong)ZQSubsRecommendController *recommendVC;
@property (nonatomic , strong)ZQSubsController *subsVC;
@property (nonatomic , strong)ZQSubsRankController *rankVC;

@end

@implementation ZQSubscriptionController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.navigationBarView];
    [self.view addSubview:self.subsScrollView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
    
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    self.navigationBarView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 64);
    self.segmentControl.frame = CGRectMake(0, 20, self.view.bounds.size.width, 44);
    
    self.subsScrollView.frame = CGRectMake(0, CGRectGetMaxY(self.navigationBarView.frame), self.view.bounds.size.width, self.view.bounds.size.height - CGRectGetMaxY(self.navigationBarView.frame) - 44);
    self.recommendVC.view.frame = self.subsScrollView.bounds;
    self.subsVC.view.frame = CGRectMake(CGRectGetMaxX(self.recommendVC.view.frame), 0, self.subsScrollView.frame.size.width, self.subsScrollView.frame.size.height);
    self.rankVC.view.frame = CGRectMake(CGRectGetMaxX(self.subsVC.view.frame), 0, self.subsScrollView.frame.size.width, self.subsScrollView.frame.size.height);
}



#pragma makr -- Private method
- (void)goToLiving:(NSDictionary *)roomInfo{
    
    ZQLiveController *liveVC = [[ZQLiveController alloc]init];
    liveVC.roomInfo = roomInfo;
    [self.navigationController pushViewController:liveVC animated:YES];
    
}

#pragma mark -- UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat contentX = scrollView.contentOffset.x;
    NSInteger index = contentX / scrollView.bounds.size.width;
    self.segmentControl.selectedSegmentIndex = index;
}



#pragma mark -- OMSegmentedControlDelegate
- (void)segmentControl:(OMSegmentedControl *)segControl didSelectSegmentIndex:(NSInteger)segmentIndex{
    [UIView animateWithDuration:0.2 animations:^{
        self.subsScrollView.contentOffset = CGPointMake(self.subsScrollView.bounds.size.width * segmentIndex, 0);
    }];
}


#pragma mark -- ZQSubsRecommendControllerDelegate
- (void)recommendLiving:(NSDictionary *)roomInfo{
    [self goToLiving:roomInfo];
}


#pragma mark -- ZQSubsControllerDelegate
- (void)subscriptionLiving:(NSDictionary *)roomInfo{
    [self goToLiving:roomInfo];
}


#pragma mark -- getters and setters
- (UIView *)navigationBarView{
    if (_navigationBarView == nil) {
        _navigationBarView = [[UIView alloc]init];
        _navigationBarView.backgroundColor = [UIColor whiteColor];
        
        [_navigationBarView addSubview:self.segmentControl];
    }
    return _navigationBarView;
}

- (OMSegmentedControl *)segmentControl{
    if (_segmentControl == nil) {
        _segmentControl = [[OMSegmentedControl alloc]initWithSegMode:OMSegmentedControlModeShowAll segItemMode:OMSegmentedControlItemModeSlipeBottom];
        _segmentControl.selectedTextColor = [UIColor colorWithRed:88/255.0 green:195/255.0 blue:252/255.0 alpha:1.0];
        _segmentControl.normalTextColor = [UIColor blackColor];
        _segmentControl.slipeColor = [UIColor colorWithRed:88/255.0 green:195/255.0 blue:252/255.0 alpha:1.0];
        [_segmentControl items:@[@"推荐",@"订阅",@"榜单"] key:nil];
        _segmentControl.segmentControlDelegate = self;
    }
    return _segmentControl;
}



- (UIScrollView *)subsScrollView{
    if (_subsScrollView == nil) {
        _subsScrollView = [[UIScrollView alloc]init];
        _subsScrollView.backgroundColor = [UIColor whiteColor];
        _subsScrollView.showsVerticalScrollIndicator = NO;
        _subsScrollView.showsHorizontalScrollIndicator = NO;
        _subsScrollView.contentSize = CGSizeMake(self.view.bounds.size.width * 3, 0);
        _subsScrollView.pagingEnabled = YES;
        _subsScrollView.delegate = self;
        
        [_subsScrollView addSubview:self.recommendVC.view];
        [_subsScrollView addSubview:self.subsVC.view];
        [_subsScrollView addSubview:self.rankVC.view];
    }
    return _subsScrollView;
}

- (ZQSubsRecommendController *)recommendVC{
    if (_recommendVC == nil) {
        _recommendVC = [[ZQSubsRecommendController alloc]init];
        _recommendVC.delegate = self;
    }
    return _recommendVC;
}

- (ZQSubsController *)subsVC{
    if (_subsVC == nil) {
        _subsVC = [[ZQSubsController alloc]init];
        _subsVC.delegate = self;
    }
    return _subsVC;
}


- (ZQSubsRankController *)rankVC{
    if (_rankVC == nil) {
        _rankVC = [[ZQSubsRankController alloc]init];
    }
    return _rankVC;
}

@end
