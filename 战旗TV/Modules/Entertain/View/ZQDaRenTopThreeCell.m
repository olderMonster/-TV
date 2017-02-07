//
//  ZQDaRenCell.m
//  战旗TV
//
//  Created by 印聪 on 2017/1/3.
//  Copyright © 2017年 monster. All rights reserved.
//

#import "ZQDaRenTopThreeCell.h"

#import "NSString+AXNetworkingMethods.h"

#import <Masonry.h>
#import <UIImageView+WebCache.h>

@interface ZQDaRenTopThreeCell()

@property (nonatomic , strong)UIImageView *picImageView;
@property (nonatomic , strong)UILabel *liveLabel;
@property (nonatomic , strong)UIImageView *avatarImageView;
@property (nonatomic , strong)UILabel *nicknameLabel;
@property (nonatomic , strong)UIImageView *onlineImageView;
@property (nonatomic , strong)UILabel *onlineLabel;
@property (nonatomic , strong)UIView *sepView;

@end


@implementation ZQDaRenTopThreeCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        _picImageView = [[UIImageView alloc]init];
        [self.contentView addSubview:self.picImageView];
        
        _liveLabel = [[UILabel alloc] init];
        _liveLabel.backgroundColor = [UIColor colorWithRed:88/255.0 green:195/255.0 blue:252/255.0 alpha:0.5];
        _liveLabel.textColor = [UIColor whiteColor];
        _liveLabel.font = [UIFont systemFontOfSize:17];
        _liveLabel.text = @"LIVE";
        _liveLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_liveLabel];
        
        _avatarImageView = [[UIImageView alloc]init];
        _avatarImageView.layer.masksToBounds = YES;
        _avatarImageView.layer.cornerRadius = 15;
        [self.contentView addSubview:_avatarImageView];
        
        _nicknameLabel = [[UILabel alloc] init];
        _nicknameLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_nicknameLabel];
        
        _onlineImageView = [[UIImageView alloc]init];
        _onlineImageView.image = [UIImage imageNamed:@"player_land_online_icon"];
        [self.contentView addSubview:_onlineImageView];
        
        _onlineLabel = [[UILabel alloc]init];
        _onlineLabel.backgroundColor = [UIColor whiteColor];
        _onlineLabel.textColor = [UIColor grayColor];
        _onlineLabel.font = [UIFont systemFontOfSize:10];
        [self.contentView addSubview:_onlineLabel];
        
        _sepView = [[UIView alloc]init];
        _sepView.backgroundColor  = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:249/255.0 alpha:1.0];
        [self.contentView addSubview:_sepView];
        
    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.picImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(@0);
        make.height.equalTo(@(self.contentView.bounds.size.width));
    }];
    
    [self.liveLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(self.contentView);
        make.width.equalTo(@80);
        make.height.equalTo(@30);
    }];
    
    
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(self.picImageView.mas_bottom).with.offset(10);
        make.bottom.equalTo(@(-20));
        make.height.equalTo(self.avatarImageView.mas_width);
    }];
    
    [self.onlineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-10));
        make.centerY.equalTo(self.avatarImageView);
    }];
    
    [self.onlineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.onlineLabel.mas_left).with.offset(-5);
        make.width.height.equalTo(@10);
        make.centerY.equalTo(self.onlineLabel);
    }];
    
    [self.nicknameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarImageView.mas_right).with.offset(10);
        make.centerY.equalTo(self.avatarImageView);
    }];
    
    [self.sepView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(self.avatarImageView.mas_bottom).with.offset(10);
        make.bottom.equalTo(self.contentView).with.offset(0);
    }];
    
}

- (void)setLive:(NSDictionary *)live{
    _live = live;
    
    NSString *picUrl = [NSString stringWithFormat:@"%@-sbig",[live[@"avatar"] httpsToHttp]];
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:picUrl] placeholderImage:[UIImage imageNamed:@"default_autoscroll"]];
    
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:picUrl] placeholderImage:[UIImage imageNamed:@"ic_change"]];
    
    //主播状态，4表示正在直播
//    NSInteger status = [live[@"status"] integerValue];
    
    self.nicknameLabel.text = live[@"nickname"];
    
    NSString *online = [NSString stringWithFormat:@"%@",live[@"online"]];
    if ([online integerValue] > 10000){
        online = [NSString stringWithFormat:@"%.1f万",[online floatValue]/10000];
    }
    self.onlineLabel.text = online;
        
}


@end
