//
//  ZQEntainmentLiveInfoController.m
//  战旗TV
//
//  Created by 印聪 on 2017/1/13.
//  Copyright © 2017年 monster. All rights reserved.
//

#import "ZQEntainmentLiveInfoController.h"
#import <Masonry/Masonry.h>
#import "ZQAnchorSubsView.h"
#import "ZQEntainmentLiveOtherAnchorCell.h"
@interface ZQEntainmentLiveInfoController ()<UICollectionViewDataSource , UICollectionViewDelegateFlowLayout>

@property (nonatomic , strong)ZQAnchorSubsView *anchorView;
@property (nonatomic , strong)UICollectionView *otherAnchorView;
@property (nonatomic , strong)UIButton *rankButton;

@property (nonatomic , strong)UIButton *commentButton;
@property (nonatomic , strong)UIButton *shareButton;
@property (nonatomic , strong)UIButton *fullScreenButton;
@property (nonatomic , strong)UIButton *giftsButton;

@property (nonatomic , strong)NSMutableArray *othersAnchors;

/** 粒子动画 */
@property(nonatomic, weak) CAEmitterLayer *emitterLayer;

@end

@implementation ZQEntainmentLiveInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:self.anchorView];
    [self.view addSubview:self.otherAnchorView];
    [self.view addSubview:self.rankButton];
    
    [self.view addSubview:self.commentButton];
    [self.view addSubview:self.shareButton];
    [self.view addSubview:self.fullScreenButton];
    [self.view addSubview:self.giftsButton];
    [self.view.layer addSublayer:self.emitterLayer];
}

- (void)viewWillLayoutSubviews{
    
    [super viewWillLayoutSubviews];
    
    self.anchorView.frame = CGRectMake(10, 20 + 10, self.view.bounds.size.width * 0.35, 30);
    self.otherAnchorView.frame = CGRectMake(CGRectGetMaxX(self.anchorView.frame) + 5, self.anchorView.frame.origin.y, self.view.bounds.size.width - (CGRectGetMaxX(self.anchorView.frame) + 10) - self.anchorView.bounds.size.height - 10, self.anchorView.frame.size.height);
    
    self.rankButton.frame = CGRectMake(self.anchorView.frame.origin.x, CGRectGetMaxY(self.anchorView.frame) + 10, 48, 18);
    
    [self.commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.bottom.equalTo(self.view).with.offset(-10);
        make.width.height.equalTo(@30);
    }];
    
    [self.shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.width.height.equalTo(self.commentButton);
        make.left.equalTo(self.commentButton.mas_right).with.offset(10);
    }];
    
    [self.fullScreenButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.width.height.equalTo(self.commentButton);
        make.left.equalTo(self.shareButton.mas_right).with.offset(10);
    }];
    
    [self.giftsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.width.height.equalTo(self.commentButton);
        make.right.equalTo(self.view).with.offset(-10);
    }];
    
    self.emitterLayer.position = self.giftsButton.center;
    
}



#pragma mark -- UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.othersAnchors.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZQEntainmentLiveOtherAnchorCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    cell.avatar = self.othersAnchors[indexPath.row][@"avatar"];
    return cell;
}

#pragma mark -- UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(collectionView.bounds.size.height, collectionView.bounds.size.height);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}


#pragma mark -- Getters and setters
- (UIView *)anchorView{
    if (_anchorView == nil) {
        _anchorView = [[ZQAnchorSubsView alloc]init];
    }
    return _anchorView;
}

- (UICollectionView *)otherAnchorView{
    if (_otherAnchorView == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _otherAnchorView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _otherAnchorView.backgroundColor = [UIColor clearColor];
        _otherAnchorView.showsHorizontalScrollIndicator = NO;
        _otherAnchorView.dataSource = self;
        _otherAnchorView.delegate = self;
        [_otherAnchorView registerClass:[ZQEntainmentLiveOtherAnchorCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    }
    return _otherAnchorView;
}

- (UIButton *)rankButton{
    if (_rankButton == nil) {
        //128 x 48
        _rankButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rankButton setBackgroundImage:[UIImage imageNamed:@"ic_yulezhibojian_paihangbang_normal"] forState:UIControlStateNormal];
        [_rankButton setBackgroundImage:[UIImage imageNamed:@"ic_yulezhibojian_paihangbang_pressed"] forState:UIControlStateHighlighted];
    }
    return _rankButton;
}



- (UIButton *)commentButton{
    if (_commentButton == nil) {
        _commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_commentButton setBackgroundImage:[UIImage imageNamed:@"mp_chat_normal"] forState:UIControlStateNormal];
        [_commentButton setBackgroundImage:[UIImage imageNamed:@"mp_chat_pressed"] forState:UIControlStateHighlighted];
    }
    return _commentButton;
}

- (UIButton *)shareButton{
    if (_shareButton == nil) {
        _shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareButton setBackgroundImage:[UIImage imageNamed:@"mp_share_normal"] forState:UIControlStateNormal];
        [_shareButton setBackgroundImage:[UIImage imageNamed:@"mp_share_pressed"] forState:UIControlStateHighlighted];
    }
    return _shareButton;
}

- (UIButton *)fullScreenButton{
    if (_fullScreenButton == nil) {
        _fullScreenButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_fullScreenButton setBackgroundImage:[UIImage imageNamed:@"ic_yulezhibojian_quanping_normal"] forState:UIControlStateNormal];
        [_fullScreenButton setBackgroundImage:[UIImage imageNamed:@"ic_yulezhibojian_quanping_pressed"] forState:UIControlStateHighlighted];
    }
    return _fullScreenButton;
}

- (UIButton *)giftsButton{
    if (_giftsButton == nil) {
        _giftsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_giftsButton setBackgroundImage:[UIImage imageNamed:@"mp_gift_normal"] forState:UIControlStateNormal];
        [_giftsButton setBackgroundImage:[UIImage imageNamed:@"mp_gift_pressed"] forState:UIControlStateHighlighted];
    }
    return _giftsButton;
}


- (NSMutableArray *)othersAnchors{
    if (_othersAnchors == nil) {
        _othersAnchors = [NSMutableArray array];
    }
    return _othersAnchors;
}

- (void)setAnchor:(NSDictionary *)anchor{
    _anchor = anchor;
    self.anchorView.anchor = anchor;
}

- (void)setAnchors:(NSArray *)anchors{
    _anchors = anchors;
    
    self.othersAnchors =  [NSMutableArray arrayWithArray:anchors];
    [self.othersAnchors removeObject:self.anchor];
    [self.otherAnchorView reloadData];
}

- (CAEmitterLayer *)emitterLayer
{
    if (!_emitterLayer) {
        CAEmitterLayer *emitterLayer = [CAEmitterLayer layer];
        // 发射器在xy平面的中心位置
        emitterLayer.emitterPosition = self.giftsButton.center;
        // 发射器的尺寸大小
        emitterLayer.emitterSize = CGSizeMake(20, 20);
        // 渲染模式
        emitterLayer.renderMode = kCAEmitterLayerUnordered;
        // 开启三维效果
        //    _emitterLayer.preservesDepth = YES;
        NSMutableArray *array = [NSMutableArray array];
        // 创建粒子
        for (int i = 0; i<9; i++) {
            // 发射单元
            CAEmitterCell *stepCell = [CAEmitterCell emitterCell];
            // 粒子的创建速率，默认为1/s
            stepCell.birthRate = 1;
            // 粒子存活时间
            stepCell.lifetime = arc4random_uniform(4) + 1;
            // 粒子的生存时间容差
            stepCell.lifetimeRange = 1.5;
            // 颜色
            // fire.color=[[UIColor colorWithRed:0.8 green:0.4 blue:0.2 alpha:0.1]CGColor];
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"good%d_30x30", i + 1]];
            // 粒子显示的内容
            stepCell.contents = (id)[image CGImage];
            // 粒子的名字
            //            [fire setName:@"step%d", i];
            // 粒子的运动速度
            stepCell.velocity = arc4random_uniform(100) + 100;
            // 粒子速度的容差
            stepCell.velocityRange = 80;
            // 粒子在xy平面的发射角度
            stepCell.emissionLongitude = M_PI+M_PI_2;;
            // 粒子发射角度的容差
            stepCell.emissionRange = M_PI_2/6;
            // 缩放比例
            stepCell.scale = 0.3;
            [array addObject:stepCell];
        }
        
        emitterLayer.emitterCells = array;
        _emitterLayer = emitterLayer;
    }
    return _emitterLayer;
}


@end
