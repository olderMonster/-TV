//
//  ZQGameController.m
//  战旗TV
//
//  Created by 印聪 on 2016/12/28.
//  Copyright © 2016年 monster. All rights reserved.
//

#import "ZQGameController.h"

#import "OMSegmentedControl.h"
#import "ZQRecommendLiveCell.h"
#import "ZQLiveCell.h"
#import "ZQGameSectionHeaderView.h"
#import "ZQGameSectionFooterView.h"
#import <SDCycleScrollView/SDCycleScrollView.h>

#import "ZQEditChannelController.h"
#import "ZQLiveController.h"

#import "ZQChannelManager.h"
#import "ZQIndexBannerManager.h"
#import "ZQRecommendManager.h"
#import "NSString+AXNetworkingMethods.h"

//广告轮播图的高度
#define kBannerHeight  (252 * (self.view.bounds.size.width) / 750)

#define kRecommendCellIdentifier  @"kRecommendCellIdentifier"
#define kLiveCellIdentifier  @"kLiveCellIdentifier"
#define kGameSectionHeaderIdentifier  @"kGameSectionHeaderIdentifier"
#define kGameSectionFooterIdentifier  @"kGameSectionFooterIdentifier"

@interface ZQGameController ()< UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,CTAPIManagerCallBackDelegate,OMSegmentedControlDelegate>

//view
@property (nonatomic , strong)OMSegmentedControl *gameSegControl;
@property (nonatomic , strong)UIScrollView *liveScrollView;
//banner 750 x 252
@property (nonatomic , strong)UICollectionView *recommendCollectionView;
@property (nonatomic , strong)SDCycleScrollView *bannerView;

//utils
@property (nonatomic , strong)ZQChannelManager *channelManager;
@property (nonatomic , strong)ZQIndexBannerManager *bannerManager;
@property (nonatomic , strong)ZQRecommendManager *recommendManager;

//storage
@property (nonatomic , strong)NSMutableArray *channelArray;
@property (nonatomic , strong)NSMutableArray *recommendLiveArray;
@property (nonatomic , strong)NSMutableArray *bannerArray;

@end

@implementation ZQGameController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self initNavgationBar];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.gameSegControl];
    [self.view addSubview:self.liveScrollView];
    
    
    //请求数据
    [self.channelManager loadData];
    [self.bannerManager loadData];
    [self.recommendManager loadData];
    
}


- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    self.gameSegControl.frame = CGRectMake(0, 0, self.view.bounds.size.width, 30);
    self.liveScrollView.frame = CGRectMake(0, CGRectGetMaxY(self.gameSegControl.frame), self.view.bounds.size.width, self.view.bounds.size.height - CGRectGetMaxY(self.gameSegControl.frame) - 44);
    self.recommendCollectionView.frame = CGRectMake(0, 0, self.liveScrollView.bounds.size.width, self.liveScrollView.bounds.size.height);
}


#pragma mark -- private method
- (void)initNavgationBar{
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"nav2_search"] forState:UIControlStateNormal];
    leftBtn.frame = CGRectMake(0, 0, 20, 20);
    [leftBtn addTarget:self action:@selector(findAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"nav2_history"] forState:UIControlStateNormal];
    rightBtn.frame = CGRectMake(0, 0, 20, 20);
    [rightBtn addTarget:self action:@selector(historyAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    //设置titleView
    //137 x 72
    UIImageView *logoImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"nav2_logo"]];
    logoImageView.frame = CGRectMake(0, 0, 68.5, 36);
    self.navigationItem.titleView = logoImageView;
    
}


#pragma mark -- Event response
- (void)findAction{
   
}

- (void)historyAction{
    
}

#pragma mark -- CTAPIManagerCallBackDelegate
- (void)managerCallAPIDidSuccess:(CTAPIBaseManager *)manager{
    if ([manager isEqual:self.channelManager]){
        
        NSDictionary *dict = [manager fetchDataWithReformer:nil];
        NSArray *allChannels = [NSMutableArray arrayWithArray:dict[@"data"][@"games"]];
        
        NSDictionary *recommend = @{@"name":@"推荐",@"appIcon":@"icon_channel_rec",@"is_local":@YES};
        NSDictionary *allLive = @{@"name":@"全部直播",@"appIcon":@"icon_channel_all",@"is_local":@YES};
        
        NSMutableArray *showChannels = [NSMutableArray array];
        NSMutableArray *otherChannels = [NSMutableArray array];
        
        [showChannels addObject:recommend];
        [showChannels addObject:allLive];
        
        NSInteger count = allChannels.count > 8?8:allChannels.count;
        
        for (NSInteger index = 0; index < count; index++) {
            NSMutableDictionary *channel = [NSMutableDictionary dictionaryWithDictionary:allChannels[index]];
            channel[@"is_local"] = @NO;     //是否是本地图片（editChannel中使用）
            channel[@"status"] = @NO;       //是否编辑状态（editChannel中使用）
            [showChannels addObject:channel];
        }
        

        for (NSInteger index  = count; index < allChannels.count; index++) {
            NSMutableDictionary *channel = [NSMutableDictionary dictionaryWithDictionary:allChannels[index]];
//            channel[@"is_local"] = @NO;     //是否是本地图片（editChannel中使用）
//            channel[@"status"] = @NO;       //是否编辑状态（editChannel中使用）
            [otherChannels addObject:channel];
        }
        
        [self.channelArray addObject:@{@"channel":showChannels,@"title":@"我的游戏",@"subtitle":@"拖动排序"}];
        [self.channelArray addObject:@{@"channel":otherChannels,@"title":@"游戏推荐",@"subtitle":@""}];
        
        [self.gameSegControl items:showChannels key:@"name"];
        
        self.liveScrollView.contentSize = CGSizeMake(self.view.bounds.size.width * showChannels.count, 0);
        
    }
    
    if ([manager isEqual:self.bannerManager]){
        NSDictionary *dict = [manager fetchDataWithReformer:nil];
        if ([dict isKindOfClass:[NSDictionary class]]) {
            self.bannerArray = [NSMutableArray arrayWithArray:dict[@"data"]];
            [self.recommendCollectionView addSubview:self.bannerView];
        }
        
    }
    
    if ([manager isEqual:self.recommendManager]){
        NSDictionary *dict = [manager fetchDataWithReformer:nil];
        if ([dict isKindOfClass:[NSDictionary class]]) {
            self.recommendLiveArray = [NSMutableArray arrayWithArray:dict[@"data"]];
            [self.recommendCollectionView reloadData];
        }
        
    }

}
- (void)managerCallAPIDidFailed:(CTAPIBaseManager *)manager{
    
}


#pragma mark -- UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.recommendLiveArray.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if ([self.recommendLiveArray[section][@"lists"] count] > 4){
        return 4;
    }
    return [self.recommendLiveArray[section][@"lists"] count];
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0){
        ZQRecommendLiveCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kRecommendCellIdentifier forIndexPath:indexPath];
        cell.live = self.recommendLiveArray[indexPath.section][@"lists"][indexPath.row];
        return cell;
    }else{
        ZQLiveCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kLiveCellIdentifier forIndexPath:indexPath];
        cell.live = self.recommendLiveArray[indexPath.section][@"lists"][indexPath.row];
        return cell;
    }

}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        ZQGameSectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kGameSectionHeaderIdentifier forIndexPath:indexPath];
        headerView.indexPath = indexPath;
        headerView.channel = self.recommendLiveArray[indexPath.section];
        return headerView;
    }else{
        
        ZQGameSectionFooterView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kGameSectionFooterIdentifier forIndexPath:indexPath];
        footerView.indexPath = indexPath;
        return footerView;
        
    }
    
}


#pragma mark -- UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;{
    CGFloat cellW = (collectionView.bounds.size.width - 1)/2;
    CGFloat imageH = cellW * 150/280;
    CGFloat cellH = indexPath.section == 0?(imageH + 30):(imageH + 30 + 25 + 8);
    return CGSizeMake(cellW, cellH);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(collectionView.bounds.size.width, 60);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(collectionView.bounds.size.width, 30);
}


#pragma mark -- UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    NSDictionary *live = self.recommendLiveArray[indexPath.section][@"lists"][indexPath.row];
    ZQLiveController *liveVC = [[ZQLiveController alloc]init];
    liveVC.roomInfo = live;
    [self.navigationController pushViewController:liveVC animated:YES];

}


#pragma mark -- OMSegmentedControlDelegate
- (void)didSelectMorePannelOfSegmentControl:(OMSegmentedControl *)segControl{
    ZQEditChannelController *editChannel = [[ZQEditChannelController alloc]init];
    editChannel.channelsMArray = [NSMutableArray arrayWithArray:self.channelArray];
    [self.navigationController pushViewController:editChannel animated:YES];
}

#pragma mark -- getters and setters
- (OMSegmentedControl *)gameSegControl{
    if (_gameSegControl == nil) {
        _gameSegControl = [[OMSegmentedControl alloc] initWithSegMode:OMSegmentedControlModeShowMore segItemMode:OMSegmentedControlItemModeSlipeBottom];
        _gameSegControl.selectedTextColor = [UIColor colorWithRed:88/255.0 green:195/255.0 blue:252/255.0 alpha:1.0];
        _gameSegControl.normalTextColor = [UIColor blackColor];
        _gameSegControl.slipeColor = [UIColor colorWithRed:88/255.0 green:195/255.0 blue:252/255.0 alpha:1.0];
        _gameSegControl.moreImageName = @"channel_extra";
        _gameSegControl.sepImageName = @"channel_line";
        _gameSegControl.segmentControlDelegate = self;
    }
    return _gameSegControl;
}


- (UIScrollView *)liveScrollView{
    if (_liveScrollView == nil) {
        _liveScrollView = [[UIScrollView alloc]init];
        _liveScrollView.showsVerticalScrollIndicator = NO;
        _liveScrollView.showsHorizontalScrollIndicator = NO;
        
        [_liveScrollView addSubview:self.recommendCollectionView];
    }
    return _liveScrollView;
}


- (UICollectionView *)recommendCollectionView{
    if (_recommendCollectionView == nil) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _recommendCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _recommendCollectionView.backgroundColor = [UIColor whiteColor];
        _recommendCollectionView.dataSource = self;
        _recommendCollectionView.delegate = self;
        _recommendCollectionView.contentInset = UIEdgeInsetsMake(kBannerHeight, 0, 0, 0);
        
        [_recommendCollectionView registerClass:[ZQRecommendLiveCell class] forCellWithReuseIdentifier:kRecommendCellIdentifier];
        [_recommendCollectionView registerClass:[ZQLiveCell class] forCellWithReuseIdentifier:kLiveCellIdentifier];
        [_recommendCollectionView registerClass:[ZQGameSectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kGameSectionHeaderIdentifier];
        [_recommendCollectionView registerClass:[ZQGameSectionFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kGameSectionFooterIdentifier];
    }
    return _recommendCollectionView;
}


- (SDCycleScrollView *)bannerView{
    if (_bannerView == nil) {
        
        NSMutableArray *titles = [NSMutableArray array];
        NSMutableArray *imageUrls = [NSMutableArray array];
        for (NSDictionary *bannerDic in self.bannerArray) {
            [titles addObject:bannerDic[@"title"]];
            [imageUrls addObject:[bannerDic[@"spic"] httpsToHttp]];
        }
        
        _bannerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, -kBannerHeight, self.view.bounds.size.width, kBannerHeight) delegate:nil placeholderImage:[UIImage imageNamed:@"default_autoscroll"]];
        _bannerView.titlesGroup = titles;
        _bannerView.imageURLStringsGroup = imageUrls;
        _bannerView.titleLabelHeight = 20;
        _bannerView.titleLabelTextFont = [UIFont systemFontOfSize:10];
        _bannerView.pageControlDotSize = CGSizeMake(5, 5);
        _bannerView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    }
    return _bannerView;
}


- (ZQChannelManager *)channelManager{
    if (_channelManager == nil) {
        _channelManager = [[ZQChannelManager alloc]init];
        _channelManager.delegate = self;
    }
    return _channelManager;
}

- (ZQIndexBannerManager *)bannerManager{
    if (_bannerManager == nil) {
        _bannerManager = [[ZQIndexBannerManager alloc]init];
        _bannerManager.delegate = self;
    }
    return _bannerManager;
}

- (ZQRecommendManager *)recommendManager{
    if (_recommendManager == nil) {
        _recommendManager = [[ZQRecommendManager alloc]init];
        _recommendManager.delegate = self;
    }
    return _recommendManager;
}



- (NSMutableArray *)channelArray{
    if (_channelArray == nil) {
        _channelArray = [NSMutableArray array];
    }
    return _channelArray;
}

- (NSMutableArray *)recommendLiveArray{
    if (_recommendLiveArray == nil) {
        _recommendLiveArray = [NSMutableArray array];
    }
    return _recommendLiveArray;
}

- (NSMutableArray *)bannerArray{
    if (_bannerArray == nil) {
        _bannerArray = [NSMutableArray array];
    }
    return _bannerArray;
}


@end
