//
//  ZQBaiBianZhuBoController.m
//  战旗TV
//
//  Created by 印聪 on 2017/1/3.
//  Copyright © 2017年 monster. All rights reserved.
//

#import "ZQBaiBianZhuBoController.h"

#import "ZQBaiBianCell.h"
#import "ZQLiveCell.h"
#import "ZQBaiBianSectionHeaderView.h"
#import "ZQLiveController.h"

#import "ZQBaiBianZhuBoManager.h"
#import "ZQBaiBianRecommendManager.h"
#import <MJRefresh/MJRefresh.h>

#define kBaiBianRecommendCell @"kBaiBianRecommendCell"
#define kBaiBianNormalCell    @"kBaiBianNormalCell"
#define kBaiBianSectionHeader    @"kBaiBianSectionHeader"
#define kBaiBianSectionFooter    @"kBaiBianSectionFooter"
@interface ZQBaiBianZhuBoController ()<UICollectionViewDataSource , UICollectionViewDelegateFlowLayout , CTAPIManagerCallBackDelegate,CTAPIManagerInterceptor>

@property (nonatomic , strong)UICollectionView *liveCollectionView;
@property (nonatomic , strong)ZQBaiBianZhuBoManager *baibianManager;
@property (nonatomic , strong)ZQBaiBianRecommendManager *recommendManager;

@property (nonatomic , strong)NSMutableArray *baibianMArray;

@end

@implementation ZQBaiBianZhuBoController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.liveCollectionView];
    
    [self.baibianManager loadData];
    [self.recommendManager loadData];
    
    [self setupRefresh];
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    self.liveCollectionView.frame = self.view.bounds;
}

#pragma mark -- private method
- (void)setupRefresh{
    
    __weak typeof(self) weakSelf = self;
    self.liveCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf.baibianManager loadData];
        [weakSelf.recommendManager loadData];
    }];
    
}



#pragma mark -- UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.baibianMArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.baibianMArray[section][@"lists"] count];
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0){
        ZQBaiBianCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kBaiBianRecommendCell forIndexPath:indexPath];
        cell.live = self.baibianMArray[indexPath.section][@"lists"][indexPath.row];
        return cell;
    }else{
        ZQLiveCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kBaiBianNormalCell forIndexPath:indexPath];
        cell.live = self.baibianMArray[indexPath.section][@"lists"][indexPath.row];
        return cell;
    }
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        ZQBaiBianSectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kBaiBianSectionHeader forIndexPath:indexPath];
        headerView.title = self.baibianMArray[indexPath.section][@"title"];
        return headerView;
    }else{
        UICollectionReusableView *resuseView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kBaiBianSectionFooter forIndexPath:indexPath];
        resuseView.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:249/255.0 alpha:1.0];
        return resuseView;
    }
    
}

#pragma mark -- UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        CGFloat cellWidth = (collectionView.bounds.size.width - 2)/3;
        return CGSizeMake(cellWidth, cellWidth);
    }else{
        CGFloat cellW = (collectionView.bounds.size.width - 1)/2;
        CGFloat imageH = cellW * 150/280;
        CGFloat cellH = imageH + 30 + 25;
        return CGSizeMake(cellW, cellH);
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGSizeZero;
    }else{
        //40(title)
        return CGSizeMake(collectionView.bounds.size.width, 40);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    if (section != self.baibianMArray.count - 1){
        return CGSizeMake(collectionView.bounds.size.width, 10);
    }else{
        return CGSizeZero;
    }
    
}


#pragma mark -- UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.delegate respondsToSelector:@selector(baiBianZHuoBoLiving:index:)]) {
        [self.delegate baiBianZHuoBoLiving:self.baibianMArray[indexPath.section][@"lists"] index:indexPath.row];
    }
    
}



#pragma mark -- CTAPIManagerCallBackDelegate
- (void)managerCallAPIDidSuccess:(CTAPIBaseManager *)manager{
    NSDictionary *dict = [manager fetchDataWithReformer:nil];
    
    if ([manager isEqual:self.baibianManager]){
        NSArray *banner = dict[@"data"][@"banner"];
        NSArray *hot = dict[@"data"][@"hotRoom"][@"rooms"];
        NSDictionary *bannerDic = @{@"title":@"",@"lists":banner};
        NSDictionary *baibian = @{@"title":@"百变主播",@"lists":hot};
        NSArray *subHot = [NSArray array];
        if (hot.count > 4){
            subHot = [hot subarrayWithRange:NSMakeRange(0, 4)];
        }else{
            subHot = hot;
        }
        NSDictionary *hotDic = @{@"title":@"热门直播",@"lists":subHot};
        
        [self.baibianMArray insertObject:bannerDic atIndex:0];
        [self.baibianMArray insertObject:hotDic atIndex:1];
        [self.baibianMArray addObject:baibian];
        
    }
    
    if ([manager isEqual:self.recommendManager]){
        if (self.baibianMArray.count){
            NSDictionary *lastDic = [self.baibianMArray lastObject];
            [self.baibianMArray removeLastObject];
            [self.baibianMArray addObjectsFromArray:dict[@"data"]];
            [self.baibianMArray addObject:lastDic];
            
        }else{
            self.baibianMArray = [NSMutableArray arrayWithArray:dict[@"data"]];
        }
        
    }
    if ([self.baibianMArray[0][@"title"] isEqualToString:@""]){
        [self.liveCollectionView reloadData];
    }
    
}
- (void)managerCallAPIDidFailed:(CTAPIBaseManager *)manager{
    
}


#pragma mark -- CTAPIManagerInterceptor
- (void)manager:(CTAPIBaseManager *)manager afterCallingAPIWithParams:(NSDictionary *)params{
    [self.liveCollectionView.mj_header endRefreshing];
}


#pragma mark -- getters and setters
- (UICollectionView *)liveCollectionView{
    if (_liveCollectionView == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _liveCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _liveCollectionView.backgroundColor = [UIColor whiteColor];
        _liveCollectionView.dataSource = self;
        _liveCollectionView.delegate = self;
        [_liveCollectionView registerClass:[ZQBaiBianCell class] forCellWithReuseIdentifier:kBaiBianRecommendCell];
        [_liveCollectionView registerClass:[ZQLiveCell class] forCellWithReuseIdentifier:kBaiBianNormalCell];
        [_liveCollectionView registerClass:[ZQBaiBianSectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kBaiBianSectionHeader];
        [_liveCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kBaiBianSectionFooter];
    }
    return _liveCollectionView;
}


- (ZQBaiBianZhuBoManager *)baibianManager{
    if (_baibianManager == nil) {
        _baibianManager = [[ZQBaiBianZhuBoManager alloc]init];
        _baibianManager.delegate = self;
    }
    return _baibianManager;
}

- (ZQBaiBianRecommendManager *)recommendManager{
    if (_recommendManager == nil) {
        _recommendManager = [[ZQBaiBianRecommendManager alloc]init];
        _recommendManager.delegate = self;
        _recommendManager.interceptor = self;
    }
    return _recommendManager;
}


- (NSMutableArray *)baibianMArray{
    if (_baibianMArray == nil) {
        _baibianMArray = [NSMutableArray array];
    }
    return _baibianMArray;
}

@end
