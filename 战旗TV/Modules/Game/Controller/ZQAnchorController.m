//
//  ZQAnchorController.m
//  战旗TV
//
//  Created by 印聪 on 2017/1/9.
//  Copyright © 2017年 monster. All rights reserved.
//

#import "ZQAnchorController.h"

#import "OMSuspendFlowLayout.h"
#import <MJRefresh/MJRefresh.h>
#import "ZQAnchorLiveCell.h"
#import "ZQAnchorVideoSectionHeaderView.h"
#import "ZQAnchorLiveInfoView.h"

#import "ZQAnchorNewVideoManager.h"
#import "ZQAnchorHotVideoManager.h"
#import "ZQRoomInfoManager.h"

@interface ZQAnchorController ()<UICollectionViewDataSource , UICollectionViewDelegateFlowLayout , CTAPIManagerCallBackDelegate , CTAPIManagerInterceptor , ZQAnchorVideoSectionHeaderViewDelegate , ZQAnchorLiveInfoViewDelegate>

@property (nonatomic , strong)UICollectionView *anchorCollectionView;
@property (nonatomic , strong)ZQAnchorLiveInfoView *headerView;

@property (nonatomic , strong)ZQAnchorNewVideoManager *recentVideoManager;
@property (nonatomic , strong)ZQAnchorHotVideoManager *hotVideoManager;
@property (nonatomic , strong)ZQRoomInfoManager *roomInfoManager;

@property (nonatomic , strong)NSMutableArray *liveMArray;

@property (nonatomic , assign)BOOL showHotVideo;
@property (nonatomic , assign)BOOL isNewFirstPage;
@property (nonatomic , assign)BOOL isHotFirstPage;

@end

@implementation ZQAnchorController


#pragma mark -- Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.anchorCollectionView];
    
    self.showHotVideo = NO;
    
    [self.recentVideoManager loadData];
    [[self roomInfoManager]loadData];
    
    
    [self setupRefresh];
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    self.anchorCollectionView.frame = self.view.bounds;
    self.headerView.frame = CGRectMake(0, -80, self.view.bounds.size.width, 80);
}


#pragma mark -- Private method
- (void)setupRefresh{
    
    if (self.showHotVideo) {
            self.anchorCollectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self.hotVideoManager refreshingAction:@selector(loadNextPage)];
    }else{
            self.anchorCollectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self.recentVideoManager refreshingAction:@selector(loadNextPage)];
    }
    
}

#pragma mark -- UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.liveMArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZQAnchorLiveCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    cell.live = self.liveMArray[indexPath.row];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        ZQAnchorVideoSectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"sectionHeaderIdentifier" forIndexPath:indexPath];
        headerView.delegate = self;
        return headerView;
        
    }else{
        return nil;
    }
    
}


#pragma mark -- UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat cellWidth = (collectionView.bounds.size.width - 1)/2;
    CGFloat imageHeight = cellWidth * 162 / 288;
    CGFloat cellHeight = imageHeight + 45;
    return CGSizeMake(cellWidth, cellHeight);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(collectionView.bounds.size.width, 30);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeZero;
}


#pragma mark -- CTAPIManagerCallBackDelegate
- (void)managerCallAPIDidSuccess:(CTAPIBaseManager *)manager{
    NSDictionary *dict = [manager fetchDataWithReformer:nil];
    
    if ([manager isEqual:self.roomInfoManager]){
        
        self.headerView.anchor = dict[@"data"];
        
        
    }else{
        
        if ([manager isEqual:self.recentVideoManager]){
            if (self.isNewFirstPage){ //是否是第一页
                NSLog(@"加载最新视频第一页");
                self.liveMArray = [NSMutableArray arrayWithArray:dict[@"data"][@"videos"]];
            }else{
                NSLog(@"加载最新视频下一页");
                [self.liveMArray addObjectsFromArray:dict[@"data"][@"videos"]];
            }
        }
        
        if ([manager isEqual:self.hotVideoManager]){
            
            if (self.isHotFirstPage){ //是否是第一页
                NSLog(@"加载最热视频第一页");
                self.liveMArray = [NSMutableArray arrayWithArray:dict[@"data"][@"videos"]];
            }else{
                NSLog(@"加载最热视频下一页");
                [self.liveMArray addObjectsFromArray:dict[@"data"][@"videos"]];
            }
        }
        
        [self.anchorCollectionView reloadData];
    }
    
 
}

- (void)managerCallAPIDidFailed:(CTAPIBaseManager *)manager{
    
    if ([manager isEqual:self.recentVideoManager]) {
        if (manager.errorType == CTAPIManagerErrorTypeNoContent) {
            NSLog(@"没有主播的最新视频");
        }
    }
    
    
    if ([manager isEqual:self.hotVideoManager]) {
        if (manager.errorType == CTAPIManagerErrorTypeNoContent) {
            NSLog(@"没有主播的最热视频");
        }
    }
    
}


#pragma mark -- CTAPIManagerInterceptor
- (void)manager:(CTAPIBaseManager *)manager afterCallingAPIWithParams:(NSDictionary *)params{
    [self.anchorCollectionView.mj_footer endRefreshing];
    
    if ([manager isEqual:self.recentVideoManager]){
        self.isNewFirstPage = [params[@"page"] integerValue] == 1?YES:NO;
    }
    
    if ([manager isEqual:self.hotVideoManager]){
        self.isHotFirstPage = [params[@"page"] integerValue] == 1?YES:NO;
    }
    
    
}

#pragma mark -- ZQAnchorVideoSectionHeaderViewDelegate
- (void)didSelectedNewVideo:(ZQAnchorVideoSectionHeaderView *)headerView{
    self.showHotVideo = NO;
    [self.recentVideoManager loadPage];
    
    [self setupRefresh];
}

- (void)didSelectedHotVideo:(ZQAnchorVideoSectionHeaderView *)headerView{
    self.showHotVideo = YES;
    [self.hotVideoManager loadPage];
    
    [self setupRefresh];
}


#pragma mark -- ZQAnchorLiveInfoViewDelegate
- (void)subscribeAnchor:(UIButton *)subsButton textButton:(UIButton *)subsTextButton{
#warning 这里添加订阅主播的网络请求
    subsButton.selected = !subsButton.selected;
    subsTextButton.selected = !subsTextButton.selected;
}


#pragma mark -- Getters and Setters
- (UICollectionView *)anchorCollectionView {
    if (_anchorCollectionView == nil) {
        OMSuspendFlowLayout *flowLayout = [[OMSuspendFlowLayout alloc]init];
        _anchorCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _anchorCollectionView.backgroundColor = [UIColor whiteColor];
        _anchorCollectionView.contentInset = UIEdgeInsetsMake(80, 0, 0, 0);
        _anchorCollectionView.dataSource = self;
        _anchorCollectionView.delegate = self;
        [_anchorCollectionView registerClass:[ZQAnchorLiveCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
        [_anchorCollectionView registerClass:[ZQAnchorVideoSectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"sectionHeaderIdentifier"];
        
        [_anchorCollectionView addSubview:self.headerView];
    }
    return _anchorCollectionView;
}


- (ZQAnchorLiveInfoView *)headerView{
    if (_headerView == nil) {
        _headerView = [[ZQAnchorLiveInfoView alloc]init];
        _headerView.delegate = self;
    }
    return _headerView;
}

- (ZQAnchorNewVideoManager *)recentVideoManager{
    if (_recentVideoManager == nil) {
        _recentVideoManager = [[ZQAnchorNewVideoManager alloc]init];
        _recentVideoManager.delegate = self;
        _recentVideoManager.interceptor = self;
        _recentVideoManager.anchorId = self.anchorId;
    }
    return _recentVideoManager;
}

- (ZQAnchorHotVideoManager *)hotVideoManager{
    if (_hotVideoManager == nil) {
        _hotVideoManager = [[ZQAnchorHotVideoManager alloc]init];
        _hotVideoManager.delegate = self;
        _hotVideoManager.interceptor = self;
        _hotVideoManager.anchorId = self.anchorId;
    }
    return _hotVideoManager;
}

- (ZQRoomInfoManager *)roomInfoManager{
    if (_roomInfoManager == nil) {
        _roomInfoManager = [[ZQRoomInfoManager alloc]init];
        _roomInfoManager.delegate = self;
        _roomInfoManager.interceptor = self;
        _roomInfoManager.roomId= self.roomId;
    }
    return _roomInfoManager;
}


- (NSMutableArray *)liveMArray{
    if (_liveMArray == nil) {
        _liveMArray = [NSMutableArray array];
    }
    return _liveMArray;
}

@end
