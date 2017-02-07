//
//  ZQQiMiaoDreamController.m
//  战旗TV
//
//  Created by 印聪 on 2017/1/4.
//  Copyright © 2017年 monster. All rights reserved.
//

#import "ZQQiMiaoDreamController.h"
#import "ZQLiveCell.h"
#import "ZQGameLiveManager.h"
#import <MJRefresh/MJRefresh.h>
#import "ZQLiveController.h"
@interface ZQQiMiaoDreamController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,CTAPIManagerCallBackDelegate,CTAPIManagerInterceptor>

@property (nonatomic , strong)UICollectionView *dreamCollectionView;
@property (nonatomic , strong)NSArray *dreamsArray;
@property (nonatomic , strong)ZQGameLiveManager *liveManager;

@end

@implementation ZQQiMiaoDreamController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.dreamCollectionView];
    
    [self.liveManager loadData];
    
    [self setupRefresh];
}


- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    self.dreamCollectionView.frame = self.view.bounds;
    
}

#pragma mark -- private method
- (void)setupRefresh{
    
    self.dreamCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self.liveManager refreshingAction:@selector(loadData)];
    
}


#pragma mark -- UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;{
    return self.dreamsArray.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZQLiveCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    cell.live = self.dreamsArray[indexPath.row];
    return cell;
}

#pragma mark -- UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat cellW = (collectionView.bounds.size.width - 1)/2;
    CGFloat imageH = cellW * 150/280;
    CGFloat cellH = imageH + 30 + 25 + 5;
    return CGSizeMake(cellW, cellH);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}


#pragma mark -- UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *roomInfo = self.dreamsArray[indexPath.row];
    
    if ([self.delegate respondsToSelector:@selector(qiMiaoMengGongChangLiving:index:)]) {
        [self.delegate qiMiaoMengGongChangLiving:self.dreamsArray index:indexPath.row];
    }
    
}


#pragma mark -- CTAPIManagerCallBackDelegate
- (void)managerCallAPIDidSuccess:(CTAPIBaseManager *)manager{
    NSDictionary *dict = [manager fetchDataWithReformer:nil];
    self.dreamsArray = dict[@"data"][@"rooms"];
    [self.dreamCollectionView reloadData];
}
- (void)managerCallAPIDidFailed:(CTAPIBaseManager *)manager{
    
}

#pragma mark -- CTAPIManagerInterceptor
- (void)manager:(CTAPIBaseManager *)manager afterCallingAPIWithParams:(NSDictionary *)params{
    [self.dreamCollectionView.mj_header endRefreshing];
}

#pragma mark -- getters and setters
- (UICollectionView *)dreamCollectionView{
    if (_dreamCollectionView == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _dreamCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _dreamCollectionView.backgroundColor = [UIColor whiteColor];
        _dreamCollectionView.dataSource = self;
        _dreamCollectionView.delegate = self;
        [_dreamCollectionView registerClass:[ZQLiveCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    }
    return _dreamCollectionView;
}

- (ZQGameLiveManager *)liveManager{
    if (_liveManager == nil) {
        _liveManager = [[ZQGameLiveManager alloc]init];
        _liveManager.delegate = self;
        _liveManager.interceptor = self;
        _liveManager.channelId = @"126";
    }
    return _liveManager;
}

@end
