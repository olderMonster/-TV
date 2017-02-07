//
//  ZQLiveRankController.m
//  战旗TV
//
//  Created by 印聪 on 2017/1/10.
//  Copyright © 2017年 monster. All rights reserved.
//

#import "ZQLiveRankController.h"
#import "OMSegmentedControl.h"
#import "ZQLiveRankCell.h"
#import "ZQLiveRankTopThreeView.h"
#import "ZQLiveRankProtectCell.h"

#import "ZQLiveRankManager.h"
#import "ZQLiveRankProtectManager.h"

@interface ZQLiveRankController ()<UITableViewDataSource , UITableViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout , CTAPIManagerCallBackDelegate , OMSegmentedControlDelegate>

@property (nonatomic , strong)OMSegmentedControl *rankSegControl;

@property (nonatomic , strong)UICollectionView *protectCollectionView;
@property (nonatomic , strong)UITableView *rankTableView;
@property (nonatomic , strong)ZQLiveRankTopThreeView *firstView; //第一名
@property (nonatomic , strong)ZQLiveRankTopThreeView *secondView; //第二名
@property (nonatomic , strong)ZQLiveRankTopThreeView *thirdView; //第三名


@property (nonatomic , strong)ZQLiveRankManager *rankManager;
@property (nonatomic , strong)ZQLiveRankProtectManager *protectManager;
@property (nonatomic , strong)NSArray *rankArray;
@property (nonatomic , strong)NSArray *showRankArray;
@property (nonatomic , strong)NSArray *protectArray;

@end

@implementation ZQLiveRankController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.rankSegControl];
    [self.view addSubview:self.protectCollectionView];
    [self.view addSubview:self.rankTableView];
    [self setupHeaderView];
    
    
    [self.rankManager loadData];
    [self.protectManager loadData];
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    self.rankSegControl.frame = CGRectMake(20, 10, self.view.bounds.size.width - 40, 30);
    self.rankTableView.frame = CGRectMake(0, CGRectGetMaxY(self.rankSegControl.frame) + 10, self.view.bounds.size.width, self.view.bounds.size.height - (CGRectGetMaxY(self.rankSegControl.frame) + 10));
    self.protectCollectionView.frame = self.rankTableView.frame;
}

#pragma mark -- Private method
- (void)setupHeaderView{
    
    UIView *headerView = [[UIView alloc]init];
    headerView.backgroundColor = [UIColor whiteColor];
    
    [headerView addSubview:self.firstView];
    [headerView addSubview:self.secondView];
    [headerView addSubview:self.thirdView];

    CGFloat itemViewWidth = (self.view.bounds.size.width - 40) / 3;
    self.firstView.frame = CGRectMake(20 + itemViewWidth, 0, itemViewWidth, 100);
    self.secondView.frame = CGRectMake(20, 10, itemViewWidth, 100);
    self.thirdView.frame = CGRectMake(CGRectGetMaxX(self.firstView.frame), 10, itemViewWidth, 80);
    
    
    headerView.frame = CGRectMake(0, 0, self.view.bounds.size.width, CGRectGetMaxY(self.firstView.frame));
    self.rankTableView.tableHeaderView = headerView;
    
}

- (void)updateData{
    
    if (self.rankSegControl.selectedSegmentIndex > 0){

        NSDictionary *firstRank = self.rankArray[self.rankSegControl.selectedSegmentIndex - 1][0];
        NSDictionary *secondRank = self.rankArray[self.rankSegControl.selectedSegmentIndex - 1][1];
        NSDictionary *thirdRank = self.rankArray[self.rankSegControl.selectedSegmentIndex - 1][2];
        
        self.firstView.user = firstRank;
        self.secondView.user = secondRank;
        self.thirdView.user = thirdRank;
        
        [self.rankTableView reloadData];
    }
}


#pragma mark -- UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.protectArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZQLiveRankProtectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    cell.protectUser = self.protectArray[indexPath.row];
    return cell;
}


#pragma mark -- UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat cellWidth = (collectionView.bounds.size.width - 15 * 2 - 10 * 4)/5;
    CGFloat cellHeight = cellWidth + 25;
    return CGSizeMake(cellWidth, cellHeight);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 15, 0, 15);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}


#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.rankSegControl.selectedSegmentIndex > 0){
        return [self.showRankArray[self.rankSegControl.selectedSegmentIndex - 1] count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cellIdentifier";
    ZQLiveRankCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[ZQLiveRankCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.indexPath = indexPath;
    cell.rank = self.showRankArray[self.rankSegControl.selectedSegmentIndex - 1][indexPath.row];
    return cell;
}


#pragma mark -- CTAPIManagerCallBackDelegate
- (void)managerCallAPIDidSuccess:(CTAPIBaseManager *)manager{
    
    NSDictionary *dict = [manager fetchDataWithReformer:nil];
    
    if ([manager isEqual:self.rankManager]){
        NSArray *week = dict[@"data"][@"week"];
        NSArray *total = dict[@"data"][@"total"];
        self.rankArray = @[week,total];
        self.showRankArray = @[[week subarrayWithRange:NSMakeRange(3, week.count - 3)],[total subarrayWithRange:NSMakeRange(3, total.count - 3)]];
        [self updateData];
    }
    
    if ([manager isEqual:self.protectManager]) {
        
        self.protectArray = dict[@"data"][@"guard"];
        [self.rankSegControl editTitle:[NSString stringWithFormat:@"守护（%ld）",self.protectArray.count] index:0];
        [self.protectCollectionView reloadData];
    }
    
}

- (void)managerCallAPIDidFailed:(CTAPIBaseManager *)manager{
    
}


#pragma mark -- OMSegmentedControlDelegate
- (void)segmentControl:(OMSegmentedControl *)segControl didSelectSegmentIndex:(NSInteger)segmentIndex{
    if (segmentIndex == 0){
        self.protectCollectionView.hidden = NO;
        self.rankTableView.hidden = YES;
        
        //当第一次没有请求的数据的时候此时应该再去请求
        if (!self.protectArray) {
            [self.protectManager loadData];
        }

        
    }else{
        self.protectCollectionView.hidden = YES;
        self.rankTableView.hidden = NO;
        [self updateData];
        
        //当第一次没有请求的数据的时候此时应该再去请求
        if (!self.showRankArray) {
            [self.rankManager loadData];
        }
    }
}

#pragma mark -- Getters and setters
- (OMSegmentedControl *)rankSegControl{
    if (_rankSegControl == nil) {
        _rankSegControl = [[OMSegmentedControl alloc]initWithSegMode:OMSegmentedControlModeShowAll segItemMode:OMSegmentedControlItemModeBackgroundSelected];
        _rankSegControl.normalTextColor = [UIColor colorWithRed:88/255.0 green:195/255.0 blue:252/255.0 alpha:1.0];
        _rankSegControl.selectedTextColor = [UIColor whiteColor];
        _rankSegControl.selectedBackgroundColor = [UIColor colorWithRed:88/255.0 green:195/255.0 blue:252/255.0 alpha:1.0];
        _rankSegControl.font = [UIFont systemFontOfSize:12];
        [_rankSegControl items:@[@"守护（0）",@"周榜",@"总榜"] key:nil];
        _rankSegControl.borderColor = [UIColor colorWithRed:88/255.0 green:195/255.0 blue:252/255.0 alpha:1.0];
        _rankSegControl.borderWidth = 1;
        _rankSegControl.borderRadius = 2;
        _rankSegControl.segmentControlDelegate = self;
        _rankSegControl.selectedSegmentIndex = 1;
    }
    return _rankSegControl;
}

- (UICollectionView *)protectCollectionView{
    if (_protectCollectionView == nil) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _protectCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _protectCollectionView.backgroundColor = [UIColor whiteColor];
        _protectCollectionView.dataSource = self;
        _protectCollectionView.delegate = self;
        [_protectCollectionView registerClass:[ZQLiveRankProtectCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    }
    return _protectCollectionView;
}


- (UITableView *)rankTableView{
    if (_rankTableView == nil) {
        _rankTableView = [[UITableView alloc]init];
        _rankTableView.backgroundColor = [UIColor whiteColor];
        _rankTableView.dataSource = self;
        _rankTableView.delegate = self;
        _rankTableView.tableFooterView = [[UIView alloc]init];
        _rankTableView.rowHeight = 35;
        _rankTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _rankTableView;
}


- (ZQLiveRankManager *)rankManager{
    if (_rankManager == nil) {
        _rankManager = [[ZQLiveRankManager alloc]init];
        _rankManager.delegate = self;
        _rankManager.roomId = self.roomId;
    }
    return _rankManager;
}

- (ZQLiveRankProtectManager *)protectManager{
    if (_protectManager == nil) {
        _protectManager = [[ZQLiveRankProtectManager alloc]init];
        _protectManager.delegate = self;
        _protectManager.roomId = self.roomId;
    }
    return _protectManager;
}

- (ZQLiveRankTopThreeView *)firstView{
    if (_firstView == nil) {
        _firstView = [[ZQLiveRankTopThreeView alloc]init];
        _firstView.rank = 1;
    }
    return _firstView;
}

- (ZQLiveRankTopThreeView *)secondView{
    if (_secondView == nil) {
        _secondView = [[ZQLiveRankTopThreeView alloc]init];
        _secondView.rank = 2;
    }
    return _secondView;
}

- (ZQLiveRankTopThreeView *)thirdView{
    if (_thirdView == nil) {
        _thirdView = [[ZQLiveRankTopThreeView alloc]init];
        _thirdView.rank = 3;
    }
    return _thirdView;
}

@end
