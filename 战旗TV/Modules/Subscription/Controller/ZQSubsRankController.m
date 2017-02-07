//
//  ZQSubsRankController.m
//  战旗TV
//
//  Created by 印聪 on 2017/1/4.
//  Copyright © 2017年 monster. All rights reserved.
//

#import "ZQSubsRankController.h"

#import "OMSegmentedControl.h"
#import "ZQRankManager.h"
#import <MJRefresh/MJRefresh.h>

#import "ZQRankNormalCell.h"
#import "ZQRankTopThreeCell.h"

#define kRankNormalCellIdentifier @"kRankNormalCellIdentifier"
#define kRankTopThreeCellIdentifier @"kRankTopThreeCellIdentifier"

@interface ZQSubsRankController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,CTAPIManagerCallBackDelegate,CTAPIManagerInterceptor,OMSegmentedControlDelegate>

@property (nonatomic , strong)OMSegmentedControl *segmentControl;

@property (nonatomic , strong)UICollectionView *rankCollectionView;

@property (nonatomic , strong)ZQRankManager *rankManager;
@property (nonatomic , strong)NSArray *rankArray;

@end

@implementation ZQSubsRankController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.segmentControl];
    
    [self.view addSubview:self.rankCollectionView];
    
    [self.rankManager loadData];
    
    [self setupRefresh];
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    self.segmentControl.frame = CGRectMake(20, 10, self.view.bounds.size.width - 40, 30);

    self.rankCollectionView.frame = CGRectMake(0, CGRectGetMaxY(self.segmentControl.frame), self.view.bounds.size.width, self.view.bounds.size.height - CGRectGetMaxY(self.segmentControl.frame));
    
}


#pragma mark -- private method
- (void)setupRefresh{
    self.rankCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self.rankManager refreshingAction:@selector(loadData)];
}

#pragma mark -- UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return [self.rankArray[self.segmentControl.selectedSegmentIndex] count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.rankArray[self.segmentControl.selectedSegmentIndex][section] count];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0){
        
        ZQRankTopThreeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kRankTopThreeCellIdentifier forIndexPath:indexPath];
        cell.userType = self.segmentControl.selectedSegmentIndex == 0?ZQRankNormalCellUserTypeAnchor:ZQRankNormalCellUserTypeConsume;
        cell.indexPath = indexPath;
        cell.user = self.rankArray[self.segmentControl.selectedSegmentIndex][indexPath.section][indexPath.row];
        return cell;
        
    }else{
        
        ZQRankNormalCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kRankNormalCellIdentifier forIndexPath:indexPath];
        
        //给cell赋值的顺序不要改变
        cell.userType = self.segmentControl.selectedSegmentIndex == 0?ZQRankNormalCellUserTypeAnchor:ZQRankNormalCellUserTypeConsume;
        cell.indexPath = indexPath;
        cell.user = self.rankArray[self.segmentControl.selectedSegmentIndex][indexPath.section][indexPath.row];
        
        return cell;
    }
    

}


#pragma mark -- UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 1){
            CGFloat cellWidth = collectionView.bounds.size.width * 0.4;
            CGFloat cellHeight = cellWidth + 40;
            return CGSizeMake(cellWidth - 20, cellHeight);
        }else{
            CGFloat cellWidth = collectionView.bounds.size.width * 0.3;
            CGFloat cellHeight = cellWidth + 40;
            return CGSizeMake(cellWidth - 10, cellHeight);
        }
        
    }
    return CGSizeMake(collectionView.bounds.size.width, 40);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (section == 0) {
        return UIEdgeInsetsMake(0, 20, 0, 20);
    }
    return UIEdgeInsetsZero;
}


#pragma mark -- OMSegmentedControlDelegate
- (void)segmentControl:(OMSegmentedControl *)segControl didSelectSegmentIndex:(NSInteger)segmentIndex{
    [self.rankCollectionView reloadData];
}

#pragma mark -- CTAPIManagerCallBackDelegate
- (void)managerCallAPIDidSuccess:(CTAPIBaseManager *)manager{
    NSDictionary *dict = [manager fetchDataWithReformer:nil];
    NSMutableArray *anchor = [NSMutableArray arrayWithArray:dict[@"data"][@"anchor"]];
    NSMutableArray *consume = [NSMutableArray arrayWithArray:dict[@"data"][@"consume"]];
    
    [anchor exchangeObjectAtIndex:0 withObjectAtIndex:1];
    [consume exchangeObjectAtIndex:0 withObjectAtIndex:1];
    
    NSArray *anchorTopThree = [anchor subarrayWithRange:NSMakeRange(0, 3)];
    NSArray *anchorOthers = [anchor subarrayWithRange:NSMakeRange(3, anchor.count - 3)];
    
    NSArray *consumeTopThree = [consume subarrayWithRange:NSMakeRange(0, 3)];
    NSArray *consumeOthers = [consume subarrayWithRange:NSMakeRange(3, anchor.count - 3)];
    self.rankArray = @[@[anchorTopThree,anchorOthers],@[consumeTopThree,consumeOthers]];
    [self.rankCollectionView reloadData];
}

- (void)managerCallAPIDidFailed:(CTAPIBaseManager *)manager{
    
}


#pragma mark -- CTAPIManagerInterceptor
- (void)manager:(CTAPIBaseManager *)manager afterCallingAPIWithParams:(NSDictionary *)params{
    [self.rankCollectionView.mj_header endRefreshing];
}



#pragma mark -- getters and setters
- (OMSegmentedControl *)segmentControl{
    if (_segmentControl == nil) {
        _segmentControl = [[OMSegmentedControl alloc]initWithSegMode:OMSegmentedControlModeShowAll segItemMode:OMSegmentedControlItemModeBackgroundSelected];
        
        _segmentControl.selectedTextColor =[UIColor whiteColor];
        _segmentControl.normalTextColor = [UIColor colorWithRed:88/255.0 green:195/255.0 blue:252/255.0 alpha:1.0];
        _segmentControl.normalBackgroundColor = [UIColor whiteColor];
        _segmentControl.selectedBackgroundColor = [UIColor colorWithRed:88/255.0 green:195/255.0 blue:252/255.0 alpha:1.0];
        _segmentControl.borderColor = [UIColor colorWithRed:88/255.0 green:195/255.0 blue:252/255.0 alpha:1.0];
        _segmentControl.borderRadius = 2;
        _segmentControl.borderWidth = 1;
        _segmentControl.font = [UIFont systemFontOfSize:13];
        [_segmentControl items:@[@"主播周榜",@"土豪周榜"] key:nil];
        
        _segmentControl.segmentControlDelegate = self;
        
    }
    return _segmentControl;
}


- (UICollectionView *)rankCollectionView{
    if (_rankCollectionView == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        _rankCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _rankCollectionView.backgroundColor = [UIColor whiteColor];
        _rankCollectionView.dataSource = self;
        _rankCollectionView.delegate = self;
        [_rankCollectionView registerClass:[ZQRankNormalCell class] forCellWithReuseIdentifier:kRankNormalCellIdentifier];
        [_rankCollectionView registerClass:[ZQRankTopThreeCell class] forCellWithReuseIdentifier:kRankTopThreeCellIdentifier];
    }
    return _rankCollectionView;
}

- (ZQRankManager *)rankManager{
    if (_rankManager == nil) {
        _rankManager = [[ZQRankManager alloc]init];
        _rankManager.delegate = self;
        _rankManager.interceptor = self;
    }
    return _rankManager;
}

@end
