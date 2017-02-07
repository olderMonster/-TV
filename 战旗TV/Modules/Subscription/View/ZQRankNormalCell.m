//
//  ZQRankNormalCell.m
//  战旗TV
//
//  Created by 印聪 on 2017/1/4.
//  Copyright © 2017年 monster. All rights reserved.
//

#import "ZQRankNormalCell.h"
#import <Masonry.h>
@interface ZQRankNormalCell()

@property (nonatomic , strong)UILabel *rankLabel;
@property (nonatomic , strong)UIImageView *levelImageView;
@property (nonatomic , strong)UILabel *nicknameLabel;
@property (nonatomic , strong)UILabel *scoreLabel;
@property (nonatomic , strong)UIImageView *statusImageView;

@property (nonatomic , strong)UIView *sepView; //分隔线

@end

@implementation ZQRankNormalCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        _rankLabel = [[UILabel alloc]init];
        _rankLabel.textAlignment = NSTextAlignmentCenter;
        _rankLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_rankLabel];
        
        
        _levelImageView = [[UIImageView alloc]init];  //96 x 32
        [self.contentView addSubview:_levelImageView];
        
        _nicknameLabel = [[UILabel alloc]init];
        _nicknameLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_nicknameLabel];
        
        _scoreLabel = [[UILabel alloc]init];
        _scoreLabel.font = [UIFont systemFontOfSize:11];
        _scoreLabel.textColor = [UIColor grayColor];
        _scoreLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_scoreLabel];
        
        
        _statusImageView = [[UIImageView alloc]init];
        _statusImageView.hidden = YES;
        _statusImageView.image = [UIImage imageNamed:@"ic_list_zhibo"]; //54 x 26
        [self.contentView addSubview:_statusImageView];
        
        _sepView = [[UIView alloc]init];
        _sepView.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:249/255.0 alpha:1.0];
        [self.contentView addSubview:_sepView];
        
    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.rankLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.centerY.equalTo(self.contentView);
        make.width.equalTo(@25);
    }];
    
    [self.levelImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rankLabel.mas_right).with.offset(10);
        make.centerY.equalTo(self.contentView);
        make.width.equalTo(@48);
        make.height.equalTo(@16);
    }];
   
    [self.scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).with.offset(-10);
        make.height.equalTo(self.contentView);
    }];
    
    [self.nicknameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.levelImageView.mas_right).with.offset(10);
        make.height.equalTo(self.contentView);
    }];
    
    [self.statusImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nicknameLabel.mas_right).with.offset(5);
        make.centerY.equalTo(self.contentView);
        make.width.equalTo(@27);
        make.height.equalTo(@13);
    }];
    
    
    [self.sepView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.levelImageView);
        make.right.equalTo(self.contentView);
        make.height.equalTo(@1);
        make.bottom.equalTo(self.contentView);
    }];
    
}




- (void)setUser:(NSDictionary *)user{
    _user = user;
    
    self.nicknameLabel.text = user[@"nickname"];
    self.scoreLabel.text = [NSString stringWithFormat:@"%@",user[@"score"]];
    
    if (self.userType == ZQRankNormalCellUserTypeAnchor){
       self.levelImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"ic_zhubodengji_%@",user[@"level"]]];
    }
    if (self.userType == ZQRankNormalCellUserTypeConsume){
        //土豪榜
        self.statusImageView.hidden = YES;
        
        if (self.indexPath && self.indexPath.row > 4){
            NSString *imageName = [self getUserLevel:[user[@"score"] integerValue]];
            self.levelImageView.image = [UIImage imageNamed:imageName];
        }
        
    }else{
        //主播榜
        NSInteger status = [user[@"status"] integerValue];
        if (status == 4) {
            self.statusImageView.hidden = NO;
        }else{
            self.statusImageView.hidden = YES;
        }
    }
    
}


- (void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
    
    self.rankLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row + 4];
    
    if (self.userType == ZQRankNormalCellUserTypeConsume){
        if (indexPath.section == 1 && indexPath.row < 5){
            self.levelImageView.image = [UIImage imageNamed:@"ic_level_me_shen"]; //神
        }
    }
    
}


#pragma mark -- private method
- (NSString *)getUserLevel:(NSInteger)score{
    
    NSString *levelStr = @"ic_level_me_wudengji";
    if (score > 232000){
        //王者1
        levelStr = @"ic_level_me_wz_01";
    } else if (score > 224000){
        //王者2
        levelStr = @"ic_level_me_wz_02";
    }else if (score > 216000){
        //王者3
        levelStr = @"ic_level_me_wz_03";
    }else if (score > 208000){
        //王者4
        levelStr = @"ic_level_me_wz_04";
    }else if (score > 200000){
        //王者5
        levelStr = @"ic_level_me_wz_05";
    }else if (score > 192000){
        //钻石1
        levelStr = @"ic_level_me_zs_01";
    }else if (score > 184000){
        //钻石2
        levelStr = @"ic_level_me_zs_02";
    }else if (score > 176000){
        //钻石3
        levelStr = @"ic_level_me_zs_03";
    }else if (score > 168000){
        //钻石4
        levelStr = @"ic_level_me_zs_04";
    }else if (score > 160000){
        //钻石5
        levelStr = @"ic_level_me_zs_05";
    }else if (score > 152000){
        //白金1
        levelStr = @"ic_level_me_bj_01";
    }else if (score > 144000){
        //白金2
        levelStr = @"ic_level_me_bj_02";
    }else if (score > 136000){
        //白金3
        levelStr = @"ic_level_me_bj_03";
    }else if (score > 128000){
        //白金4
        levelStr = @"ic_level_me_bj_04";
    }else if (score > 120000){
        //白金5
        levelStr = @"ic_level_me_bj_05";
    }else if (score > 112000){
        //黄金1
        levelStr = @"ic_level_me_hj_01";
    }else if (score > 04000){
        //黄金2
        levelStr = @"ic_level_me_hj_02";
    }else if (score > 96000){
        //黄金3
        levelStr = @"ic_level_me_hj_03";
    }else if (score > 88000){
        //黄金4
        levelStr = @"ic_level_me_hj_04";
    }else if (score > 80000){
        //黄金5
        levelStr = @"ic_level_me_hj_05";
    }else if (score > 72000){
        //白银1
        levelStr = @"ic_level_me_by_01";
    }else if (score > 64000){
        //白银2
        levelStr = @"ic_level_me_by_02";
    }else if (score > 56000){
        //白银3
        levelStr = @"ic_level_me_by_03";
    }else if (score > 48000){
        //白银4
        levelStr = @"ic_level_me_by_04";
    }else if (score > 40000){
        //白银5
        levelStr = @"ic_level_me_by_05";
    }else if (score > 32000){
        //青铜1
        levelStr = @"ic_level_me_qt_01";
    }else if (score > 24000){
        //青铜2
        levelStr = @"ic_level_me_qt_02";
    }else if (score > 16000){
        //青铜3
        levelStr = @"ic_level_me_qt_03";
    }else if (score > 8000){
        //青铜4
        levelStr = @"ic_level_me_qt_04";
    }else if (score > 0){
        //青铜5
        levelStr = @"ic_level_me_qt_05";
    }
    return levelStr;
}

@end
