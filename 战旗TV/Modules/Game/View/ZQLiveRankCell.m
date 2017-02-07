//
//  ZQLiveRankCell.m
//  战旗TV
//
//  Created by 印聪 on 2017/1/10.
//  Copyright © 2017年 monster. All rights reserved.
//

#import "ZQLiveRankCell.h"

#import <Masonry/Masonry.h>

@interface ZQLiveRankCell()

@property (nonatomic , strong)UILabel *rankLabel;
@property (nonatomic , strong)UIImageView *levelImageView;
@property (nonatomic , strong)UILabel *anchorLabel;
@property (nonatomic , strong)UILabel *nicknameLabel;
@property (nonatomic , strong)UILabel *scoreLabel;

@property (nonatomic , strong)UIView *sepLineView;

@end

@implementation ZQLiveRankCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _rankLabel = [[UILabel alloc] init];
        _rankLabel.backgroundColor = [UIColor whiteColor];
        _rankLabel.font = [UIFont systemFontOfSize:14];
        _rankLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_rankLabel];
        
        _levelImageView = [[UIImageView alloc] init]; //64 x 28
        [self.contentView addSubview:_levelImageView];
        
        _anchorLabel = [[UILabel alloc]init];
        _anchorLabel.font = [UIFont systemFontOfSize:12];
        _anchorLabel.textColor = [UIColor colorWithRed:88/255.0 green:195/255.0 blue:252/255.0 alpha:1.0];
        _anchorLabel.textAlignment = NSTextAlignmentCenter;
        _anchorLabel.text = @"主播"; //这里显示主播的关键字
        [self.contentView addSubview:_anchorLabel];
        
        _nicknameLabel = [[UILabel alloc]init];
        _nicknameLabel.backgroundColor = [UIColor whiteColor];
        _nicknameLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_nicknameLabel];
        
        _scoreLabel = [[UILabel alloc]init];
        _scoreLabel.backgroundColor = [UIColor whiteColor];
        _scoreLabel.font = [UIFont systemFontOfSize:11];
        _scoreLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:_scoreLabel];
        
        _sepLineView = [[UIView alloc]init];
        _sepLineView.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:241/255.0 alpha:1.0];
        [self.contentView addSubview:_sepLineView];
        
    }
    return self;
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.rankLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.contentView);
        make.width.equalTo(self.rankLabel.mas_height);
    }];
    
    [self.levelImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rankLabel.mas_right);
        make.centerY.equalTo(self.contentView);
        make.width.equalTo(@48);
        make.height.equalTo(@21);
    }];
    
    [self.anchorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.levelImageView);
        make.right.equalTo(self.levelImageView).with.offset(-12);
        make.top.bottom.equalTo(self.contentView);
    }];
    
    [self.scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).with.offset(-10);
        make.top.bottom.equalTo(self.contentView);
    }];
    
    [self.nicknameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.levelImageView.mas_right).with.offset(5);
        make.top.bottom.equalTo(self.contentView);
        make.right.lessThanOrEqualTo(self.scoreLabel.mas_left).with.offset(-5);
    }];
    
    [self.sepLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.levelImageView);
        make.bottom.right.equalTo(self.contentView);
        make.height.equalTo(@1);
    }];
    
}


#pragma mark -- Getters and setters
- (void)setRank:(NSDictionary *)rank{
    _rank = rank;
    
    NSString *level = [rank[@"level"] integerValue]< 10?[NSString stringWithFormat:@"0%@",rank[@"level"]]:[NSString stringWithFormat:@"%@",rank[@"level"]];
    self.levelImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"ic_dengji%@",level]];
    
    self.nicknameLabel.text = rank[@"nickname"];
    self.scoreLabel.text = [NSString stringWithFormat:@"%@",rank[@"score"]];
    
}

- (void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
    
    self.rankLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row + 1];
    
}


@end
