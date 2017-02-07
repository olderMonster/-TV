//
//  ZQEntainmentLiveController.m
//  战旗TV
//
//  Created by 印聪 on 2017/1/12.
//  Copyright © 2017年 monster. All rights reserved.
//

#import "ZQEntainmentLiveController.h"
//#import "ZQEntainmentLiveCell.h"
@interface ZQEntainmentLiveController ()<UICollectionViewDataSource , UICollectionViewDelegateFlowLayout , ZQEntainmentLiveCellDelgate , UIScrollViewDelegate>

@property (nonatomic , strong)UICollectionView *liveCollectionView;


@end

@implementation ZQEntainmentLiveController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.liveCollectionView];
    
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    self.liveCollectionView.frame = self.view.bounds;
}


#pragma mark -- UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSInteger currentPage = scrollView.contentOffset.y/scrollView.bounds.size.width - 1;

    if (currentPage < 0) {
        [self.liveCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:(self.liveRooms.count - 1) inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:NO];
    }else if (currentPage == self.liveRooms.count){
        [self.liveCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:NO];
    }
    
}


#pragma mark -- UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.liveRooms.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZQEntainmentLiveCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    cell.delegate = self;
    cell.type = self.cellType;
    cell.videoId = self.liveRooms[indexPath.row][@"videoId"];
    //先设置anchor,在ZQEntainmentLiveInfoController会先将anchor移除在刷新数据
    cell.anchor = self.liveRooms[indexPath.row];
    cell.anchors = self.liveRooms;
    return cell;
}

#pragma mark -- UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}



#pragma mark -- ZQEntainmentLiveCellDelgate
- (void)closeLiving{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -- Getters and setters
- (UICollectionView *)liveCollectionView{
    if (_liveCollectionView == nil) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _liveCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _liveCollectionView.backgroundColor = [UIColor whiteColor];
        _liveCollectionView.pagingEnabled = YES;
        _liveCollectionView.dataSource = self;
        _liveCollectionView.delegate = self;
        [_liveCollectionView registerClass:[ZQEntainmentLiveCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    }
    return _liveCollectionView;
}



@end
