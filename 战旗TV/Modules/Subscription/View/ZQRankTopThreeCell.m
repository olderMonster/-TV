//
//  ZQRankTopThreeCell.m
//  战旗TV
//
//  Created by 印聪 on 2017/1/5.
//  Copyright © 2017年 monster. All rights reserved.
//

#import "ZQRankTopThreeCell.h"

#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "NSString+AXNetworkingMethods.h"

@interface ZQRankTopThreeCell()

@property (nonatomic , strong)UIImageView *honnorImageView;
@property (nonatomic , strong)UIImageView *avatarImageView;
@property (nonatomic , strong)UILabel *nicknameLabel;
@property (nonatomic , strong)UILabel *scoreLabel;
@property (nonatomic , strong)UIImageView *statusImageView; //直播状态

@end

@implementation ZQRankTopThreeCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        _avatarImageView = [[UIImageView alloc]init];
        [self.contentView addSubview:_avatarImageView];
        
        _honnorImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_honnorImageView];
        
        _nicknameLabel = [[UILabel alloc]init];
        _nicknameLabel.font = [UIFont systemFontOfSize:10];
        _nicknameLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_nicknameLabel];
        
        _scoreLabel = [[UILabel alloc]init];
        _scoreLabel.font = [UIFont systemFontOfSize:10];
        _scoreLabel.textAlignment = NSTextAlignmentCenter;
        _scoreLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:_scoreLabel];
        
        _statusImageView = [[UIImageView alloc]init];
        [self.contentView addSubview:_statusImageView];
        
    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
        
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(10);
        make.width.equalTo(self.contentView);
        make.height.equalTo(self.avatarImageView.mas_width);
    }];
    
    [self.honnorImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.avatarImageView);
    }];
    
    [self.statusImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.honnorImageView);
        make.bottom.equalTo(self.honnorImageView);
        make.width.equalTo(@48);
        make.height.equalTo(@16);
    }];
    
    [self.nicknameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.avatarImageView);
        make.top.equalTo(self.honnorImageView.mas_bottom).with.offset(10);
    }];
    
    [self.scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.avatarImageView);
        make.top.equalTo(self.nicknameLabel.mas_bottom).with.offset(5);
    }];
    
}

- (void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
    
    if (indexPath.row == 0){
        self.honnorImageView.image = [UIImage imageNamed:@"ic_dierming"];
    }
    
    if (indexPath.row == 1){
        self.honnorImageView.image = [UIImage imageNamed:@"ic_diyiming"];
    }
    
    if (indexPath.row == 2){
        self.honnorImageView.image = [UIImage imageNamed:@"ic_disanming"];
    }
    
}


- (void)setUser:(NSDictionary *)user{
    _user = user;
    
    NSString *avatar = [NSString stringWithFormat:@"%@-sbig",user[@"avatar"]];
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:[avatar httpsToHttp]] placeholderImage:[UIImage imageNamed:@"default_meipai_small"]];
    
    self.nicknameLabel.text = user[@"nickname"];
    
    self.scoreLabel.text = [NSString stringWithFormat:@"%@",user[@"score"]];
    
    self.statusImageView.image = nil;
    if (self.userType == ZQRankNormalCellUserTypeAnchor) {
        
        NSInteger status = [user[@"status"] integerValue];
        if (status == 4) {
            self.statusImageView.image = [UIImage imageNamed:@"ic_zhibo"];
        }
    }else{
        self.statusImageView.image = [UIImage imageNamed:@"ic_level_me_chuangshishen"];
    }
    
}


@end
