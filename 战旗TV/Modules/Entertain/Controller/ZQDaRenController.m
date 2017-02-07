//
//  ZQDaRenController.m
//  战旗TV
//
//  Created by 印聪 on 2017/1/3.
//  Copyright © 2017年 monster. All rights reserved.
//

#import "ZQDaRenController.h"

#import "ZQDaRenTopThreeCell.h"
#import "ZQDaRenCell.h"
#import "ZQChanLiveManager.h"
#import "ZQLiveController.h"

#import <MJRefresh/MJRefresh.h>

#define kTopThreeCellIdentifier  @"kTopThreeCellIdentifier"
#define kDaRenCellIdentifier     @"kDaRenCellIdentifier"
@interface ZQDaRenController ()<UICollectionViewDataSource , UICollectionViewDelegateFlowLayout,CTAPIManagerCallBackDelegate,CTAPIManagerInterceptor>

@property (nonatomic , strong)UICollectionView *daRenCollectionView;
@property (nonatomic , strong)ZQChanLiveManager *daRenManager;

@property (nonatomic , strong)NSMutableArray *daRenMArray;

@end

@implementation ZQDaRenController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.daRenCollectionView];
    
    [self.daRenManager loadData];
    
    [self setupRefresh];
    
}


- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    self.daRenCollectionView.frame= self.view.bounds;
}


#pragma mark -- private method
- (void)setupRefresh{
    
    self.daRenCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self.daRenManager refreshingAction:@selector(loadData)];
    
}


#pragma mark -- UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.daRenMArray.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;{
    return [self.daRenMArray[section] count];
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0){
        ZQDaRenTopThreeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kTopThreeCellIdentifier forIndexPath:indexPath];
        cell.live = self.daRenMArray[indexPath.section][indexPath.row];
        return cell;
    }else{
        ZQDaRenCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kDaRenCellIdentifier forIndexPath:indexPath];
        cell.live = self.daRenMArray[indexPath.section][indexPath.row];
        return cell;
    }

}


#pragma mark -- UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0){
       return CGSizeMake(collectionView.bounds.size.width, collectionView.bounds.size.width + 50 + 10);
    }else{
        CGFloat cellWidth = (collectionView.bounds.size.width - 1)/2;
        return CGSizeMake(cellWidth, cellWidth);
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    if (section == 0){
        return 0;
    }
    return 1;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    if (section == 0){
        return 0;
    }
    return 1;
}


#pragma mark -- UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSMutableArray *livesArray = [NSMutableArray array];
    for (NSArray *array in self.daRenMArray) {
        [livesArray addObjectsFromArray:array];
    }
    
    NSInteger showIndex = 0;
    NSDictionary *currentShow = self.daRenMArray[indexPath.section][indexPath.row];
    for (NSInteger index = 0 ; index < livesArray.count;index++) {
        NSDictionary *dict = livesArray[index];
        if ([dict isEqual:currentShow]) {
            showIndex = index;
            break;
        }
    }
    
    if ([self.delegate respondsToSelector:@selector(meiPaiDaRenLiving:index:)]) {
        [self.delegate meiPaiDaRenLiving:livesArray index:showIndex];
    }
    
}


#pragma mark -- CTAPIManagerCallBackDelegate
- (void)managerCallAPIDidSuccess:(CTAPIBaseManager *)manager{
    NSDictionary *dict = [manager fetchDataWithReformer:nil];
    NSArray *liveArray = dict[@"data"][@"rooms"];
    self.daRenMArray = [NSMutableArray array]; //清空数据
    [self.daRenMArray addObject:[liveArray subarrayWithRange:NSMakeRange(0, 3)]];
    [self.daRenMArray addObject:[liveArray subarrayWithRange:NSMakeRange(3, liveArray.count - 3)]];
    [self.daRenCollectionView reloadData];
}

- (void)managerCallAPIDidFailed:(CTAPIBaseManager *)manager{
    
}


#pragma mark -- CTAPIManagerInterceptor
- (void)manager:(CTAPIBaseManager *)manager afterCallingAPIWithParams:(NSDictionary *)params{
    [self.daRenCollectionView.mj_header endRefreshing];
}


#pragma mark -- getters and setters
- (UICollectionView *)daRenCollectionView{
    if (_daRenCollectionView == nil) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _daRenCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _daRenCollectionView.backgroundColor = [UIColor whiteColor];
        _daRenCollectionView.dataSource = self;
        _daRenCollectionView.delegate = self;
        [_daRenCollectionView registerClass:[ZQDaRenTopThreeCell class] forCellWithReuseIdentifier:kTopThreeCellIdentifier];
        [_daRenCollectionView registerClass:[ZQDaRenCell class] forCellWithReuseIdentifier:kDaRenCellIdentifier];
        
    }
    return _daRenCollectionView;
}


- (ZQChanLiveManager *)daRenManager{
    if (_daRenManager == nil) {
        _daRenManager = [[ZQChanLiveManager alloc]init];
        _daRenManager.delegate = self;
        _daRenManager.interceptor = self;
        _daRenManager.channelId = @"116";
    }
    return _daRenManager;
}

- (NSMutableArray *)daRenMArray {
    if (_daRenMArray == nil) {
        _daRenMArray = [NSMutableArray array];
    }
    return _daRenMArray;
}

@end
