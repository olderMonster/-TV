//
//  ZQEditChannelController.m
//  战旗TV
//
//  Created by 印聪 on 2016/12/30.
//  Copyright © 2016年 monster. All rights reserved.
//  在添加或删除游戏的时候缺少动画

#import "ZQEditChannelController.h"

#import <Masonry.h>
#import "ZQEditChannelCell.h"
#import "ZQEditChannelSectionHeaderView.h"

#define kEditChannelCellIdentifier  @"kEditChannelCellIdentifier"
#define kEditChannelSectionHeaderIdentifier  @"kEditChannelSectionHeaderIdentifier"
#define kEditChannelSectionFooterIdentifier  @"kEditChannelSectionHeaderIdentifier"

@interface ZQEditChannelController ()<UICollectionViewDataSource , UICollectionViewDelegateFlowLayout , ZQEditChannelCellDelegate>

@property (nonatomic , strong)UIView *editView;
@property (nonatomic , strong)UILabel *headerLabel;
@property (nonatomic , strong)UIButton *editButton;
@property (nonatomic , strong)UIImageView *lineImageView;
@property (nonatomic , strong)UIView *closeView;
@property (nonatomic , strong)UIButton *closeButton;
@property (nonatomic , strong)UICollectionView *editChannelView;

@end

@implementation ZQEditChannelController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.editView];
    [self.view addSubview:self.editChannelView];
    
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    [self.editView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.equalTo(@30);
    }];
    
    
    [self.headerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.bottom.equalTo(self.editView);
    }];
    
    [self.closeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(@0);
        make.width.height.equalTo(self.editView.mas_height);
    }];
    
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.centerX.equalTo(self.closeView);
        make.width.height.equalTo(self.closeView.mas_height).multipliedBy(0.6);
    }];
    
    //6 x 88
    [self.lineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(@0);
        make.right.equalTo(self.closeView.mas_left);
        make.width.equalTo(@2);
    }];
    
    [self.editButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(@0);
        make.right.equalTo(self.lineImageView.mas_left).with.offset(-10);
    }];
    
    
    [self.editChannelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.editView.mas_bottom);
    }];
    
}

#pragma mark -- public method
- (void)show{
    [UIView animateWithDuration:0.2 animations:^{
       self.closeButton.transform = CGAffineTransformIdentity;
    }];
    
    
}


- (void)close{
    
    [UIView animateWithDuration:0.2 animations:^{
        self.closeButton.transform = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI_4);
    }];
    
}


#pragma mark -- event response
- (void)editAction:(UIButton *)button{
    button.selected = !button.selected;
    
    if (button.selected){
        
        self.headerLabel.text = @"拖动排序";
        
        NSMutableDictionary *userChannels = [NSMutableDictionary dictionaryWithDictionary:self.channelsMArray[0]];
        NSMutableArray *user = [NSMutableArray arrayWithArray:userChannels[@"channel"]];
        for (NSInteger index = 0 ; index < user.count;index++) {
            NSMutableDictionary *editChannel = [NSMutableDictionary dictionaryWithDictionary:user[index]];
            if(![editChannel[@"is_local"] boolValue]){
                editChannel[@"status"] = @YES;
            }
            [user replaceObjectAtIndex:index withObject:editChannel];
        }
        userChannels[@"channel"] = user;
        [self.channelsMArray replaceObjectAtIndex:0 withObject:userChannels];
        
        NSMutableDictionary *otherChannels = [NSMutableDictionary dictionaryWithDictionary:self.channelsMArray.lastObject];
        otherChannels[@"subtitle"] = @"(点击添加游戏)";
        [self.channelsMArray replaceObjectAtIndex:(self.channelsMArray.count - 1) withObject:otherChannels];
        
        [self.editChannelView reloadData];
        
    }else{
        
        self.headerLabel.text = @"我的游戏";
        
        NSMutableDictionary *userChannels = [NSMutableDictionary dictionaryWithDictionary:self.channelsMArray[0]];
        NSMutableArray *user = [NSMutableArray arrayWithArray:userChannels[@"channel"]];
        for (NSInteger index = 0 ; index < user.count;index++) {
            NSMutableDictionary *editChannel = [NSMutableDictionary dictionaryWithDictionary:user[index]];
            editChannel[@"status"] = @NO;
            [user replaceObjectAtIndex:index withObject:editChannel];
        }
        userChannels[@"channel"] = user;
        [self.channelsMArray replaceObjectAtIndex:0 withObject:userChannels];
        
        NSMutableDictionary *otherChannels = [NSMutableDictionary dictionaryWithDictionary:self.channelsMArray.lastObject];
        otherChannels[@"subtitle"] = @"";
        [self.channelsMArray replaceObjectAtIndex:(self.channelsMArray.count - 1) withObject:otherChannels];
        
        [self.editChannelView reloadData];
        
    }
    
}


#pragma mark -- UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.channelsMArray.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.channelsMArray[section][@"channel"] count];
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZQEditChannelCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kEditChannelCellIdentifier forIndexPath:indexPath];
    cell.delegate = self;
    cell.channel = self.channelsMArray[indexPath.section][@"channel"][indexPath.row];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        ZQEditChannelSectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kEditChannelSectionHeaderIdentifier forIndexPath:indexPath];
        headerView.title = self.channelsMArray[indexPath.section][@"title"];
        headerView.subtitle = self.channelsMArray[indexPath.section][@"subtitle"];
        return headerView;
        
    }else{
        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kEditChannelSectionFooterIdentifier forIndexPath:indexPath];
        return footerView;
    }
    
}

#pragma mark -- UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = (collectionView.bounds.size.width - 6 * 10)/5;
    CGFloat height = width + 20;
    return CGSizeMake(width, height);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 10, 0, 10);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section != 0) {
        return CGSizeMake(collectionView.bounds.size.width, 40);
    }else{
        return CGSizeZero;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(collectionView.bounds.size.width, 10);
}


#pragma mark -- UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //当初在编辑模式时才可以增加游戏
    if(!self.editButton.selected){
        return;
    }
    
    
    //添加游戏
    if (indexPath.section == 1){
        
        NSMutableDictionary *otherChannel = [NSMutableDictionary dictionaryWithDictionary:self.channelsMArray[indexPath.section]];
        NSMutableArray *otherChannels = [NSMutableArray arrayWithArray:otherChannel[@"channel"]];
        NSMutableDictionary *addChannel = [NSMutableDictionary dictionaryWithDictionary:otherChannels[indexPath.row]];
        addChannel[@"status"] = @YES;
        
        [otherChannels removeObjectAtIndex:indexPath.row];
        otherChannel[@"channel"] = otherChannels;
        [self.channelsMArray replaceObjectAtIndex:indexPath.section withObject:otherChannel];
        
        NSMutableDictionary *userChannel = [NSMutableDictionary dictionaryWithDictionary:self.channelsMArray[0]];
        NSMutableArray *userChannels = [NSMutableArray arrayWithArray:userChannel[@"channel"]];
        [userChannels addObject:addChannel];
        userChannel[@"channel"] = userChannels;
        [self.channelsMArray replaceObjectAtIndex:0 withObject:userChannel];
        
        [self.editChannelView reloadData];
        
    }else{
        
        //从用户游戏列表中删除游戏
        ZQEditChannelCell *cell = (ZQEditChannelCell *)[self.editChannelView cellForItemAtIndexPath:indexPath];
        [self didDeleteCell:cell];
    
    }
    
    
   
    
}


#pragma mark -- ZQEditChannelCellDelegate
- (void)didDeleteCell:(ZQEditChannelCell *)cell{
    if (self.editButton.selected){
        NSIndexPath *indexPath = [self.editChannelView indexPathForCell:cell];
        
        
        NSMutableDictionary *userChannel = [NSMutableDictionary dictionaryWithDictionary:self.channelsMArray[indexPath.section]];
        NSMutableArray *userChannels = [NSMutableArray arrayWithArray:userChannel[@"channel"]];
        NSMutableDictionary *delChannel = [NSMutableDictionary dictionaryWithDictionary:userChannels[indexPath.row]];
        delChannel[@"status"] = @NO;
        
        [userChannels removeObjectAtIndex:indexPath.row];
        userChannel[@"channel"] = userChannels;
        [self.channelsMArray replaceObjectAtIndex:indexPath.section withObject:userChannel];
        
        NSMutableDictionary *otherChannel = [NSMutableDictionary dictionaryWithDictionary:self.channelsMArray[1]];
        NSMutableArray *otherChannels = [NSMutableArray arrayWithArray:otherChannel[@"channel"]];
        [otherChannels insertObject:delChannel atIndex:0];
        otherChannel[@"channel"] = otherChannels;
        [self.channelsMArray replaceObjectAtIndex:1 withObject:otherChannel];
        
        [self.editChannelView reloadData];
    }
}


#pragma mark -- getters and setters

- (UIView *)editView{
    if (_editView == nil) {
        _editView = [[UIView alloc] init];
        _editView.backgroundColor = [UIColor whiteColor];
        
        [_editView addSubview:self.headerLabel];
        [_editView addSubview:self.editButton];
        [_editView addSubview:self.lineImageView];
        [_editView addSubview:self.closeView];
        
    }
    return _editView;
}


- (UILabel *)headerLabel{
    if (_headerLabel == nil) {
        _headerLabel = [[UILabel alloc] init];
        _headerLabel.font = [UIFont systemFontOfSize:13];
        _headerLabel.text = @"我的游戏";
        _headerLabel.textColor = [UIColor grayColor];
    }
    return _headerLabel;
}


- (UIButton *)editButton{
    if (_editButton == nil) {
        _editButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_editButton setTitle:@"编辑" forState:UIControlStateNormal];
        [_editButton setTitle:@"完成" forState:UIControlStateSelected];
        [_editButton setTitleColor: [UIColor colorWithRed:88/255.0 green:195/255.0 blue:252/255.0 alpha:1.0] forState:UIControlStateNormal];
        [_editButton setTitleColor: [UIColor colorWithRed:88/255.0 green:195/255.0 blue:252/255.0 alpha:1.0] forState:UIControlStateSelected];
        _editButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [_editButton addTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _editButton;
}

- (UIImageView *)lineImageView{
    if (_lineImageView == nil) {
        _lineImageView = [[UIImageView alloc]init];
        _lineImageView.image = [UIImage imageNamed:@"channel_line"];
    }
    return _lineImageView;
}

- (UIView *)closeView{
    if (_closeView == nil) {
        _closeView = [[UIView alloc]init];
        [_closeView addSubview:self.closeButton];
    }
    return _closeView;
}

- (UIButton *)closeButton{
    if (_closeButton == nil) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeButton setBackgroundImage:[UIImage imageNamed:@"channel_close"] forState:UIControlStateNormal];
        _closeButton.transform = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI_4);
    }
    return _closeButton;
}


- (UICollectionView *)editChannelView{
    if (_editChannelView == nil) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _editChannelView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _editChannelView.backgroundColor = [UIColor whiteColor];
        _editChannelView.dataSource = self;
        _editChannelView.delegate = self;
        
        [_editChannelView registerClass:[ZQEditChannelCell class] forCellWithReuseIdentifier:kEditChannelCellIdentifier];
        [_editChannelView registerClass:[ZQEditChannelSectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kEditChannelSectionHeaderIdentifier];
        [_editChannelView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kEditChannelSectionFooterIdentifier];
    }
    return _editChannelView;
}

@end
