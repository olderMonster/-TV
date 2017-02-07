//
//  ZQLiveCell.m
//  战旗TV
//
//  Created by 印聪 on 2016/12/29.
//  Copyright © 2016年 monster. All rights reserved.
//

#import "ZQLiveCell.h"

#import <Masonry.h>
#import <UIImageView+WebCache.h>
#import "NSString+AXNetworkingMethods.h"

@interface ZQLiveCell()

@property (nonatomic , strong)UIImageView *liveImageView;
@property (nonatomic , strong)UIImageView *avatarImageView;
@property (nonatomic , strong)UIImageView *genderImageView; // 1 男 ， 2 女
@property (nonatomic , strong)UILabel *liveTitleLabel;
@property (nonatomic , strong)UILabel *hostNameLabel;
@property (nonatomic , strong)UIImageView *onlineImageView;
@property (nonatomic , strong)UILabel *onlineLabel;

@end

@implementation ZQLiveCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        [self setupView];
        
    }
    return self;
}


#pragma mark -- private method
- (void)setupView{
    
    //280 x 150
    _liveImageView = [[UIImageView alloc]init];
    [self.contentView addSubview:_liveImageView];
    
    
    _avatarImageView = [[UIImageView alloc]init];
    _avatarImageView.layer.masksToBounds = YES;
    _avatarImageView.layer.cornerRadius = 25 * 0.5;
    _avatarImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    _avatarImageView.layer.borderWidth = 1.0f;
    [self.contentView addSubview:_avatarImageView];
    
    _genderImageView = [[UIImageView alloc]init];
    [self.contentView addSubview:_genderImageView];
    
    _liveTitleLabel = [[UILabel alloc]init];
    _liveTitleLabel.textColor = [UIColor blackColor];
    _liveTitleLabel.font = [UIFont systemFontOfSize:11];
    [self.contentView addSubview:_liveTitleLabel];
    
    
    _hostNameLabel = [[UILabel alloc]init];
    _hostNameLabel.textColor = [UIColor grayColor];
    _hostNameLabel.font = [UIFont systemFontOfSize:10];
    [self.contentView addSubview:_hostNameLabel];
    
    _onlineImageView = [[UIImageView alloc]init];
    _onlineImageView.image = [UIImage imageNamed:@"room_online_icon"];
    [self.contentView addSubview:_onlineImageView];
    
    
    _onlineLabel = [[UILabel alloc]init];
    _onlineLabel.textColor = [UIColor grayColor];
    _onlineLabel.font = [UIFont systemFontOfSize:9];
    [self.contentView addSubview:_onlineLabel];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat height = self.contentView.bounds.size.width * 150 / 280;
    [self.liveImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.contentView);
        make.height.equalTo(@(height));
    }];
    
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@5);
        make.top.equalTo(self.liveImageView.mas_bottom).with.offset(8);
        make.width.height.equalTo(@25);
    }];
    
    [self.genderImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.equalTo(self.avatarImageView);
        make.width.height.equalTo(@10);
    }];
    
    [self.liveTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarImageView.mas_right).with.offset(10);
        make.right.equalTo(@(-5));
        make.centerY.equalTo(self.avatarImageView);
    }];
    
    [self.onlineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-5));
        make.top.equalTo(self.avatarImageView.mas_bottom);
        make.bottom.equalTo(self.contentView);
    }];
    
    [self.onlineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.onlineLabel);
        make.width.height.equalTo(@10);
        make.right.equalTo(self.onlineLabel.mas_left).with.offset(-5);
    }];
    
    [self.hostNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@5);
        make.top.bottom.equalTo(self.onlineLabel);
    }];
    
}


#pragma mark -- getters and setters
- (void)setLive:(NSDictionary *)live{
    _live = live;
    
    [self.liveImageView sd_setImageWithURL:[NSURL URLWithString:[live[@"spic"] httpsToHttp]] placeholderImage:[UIImage imageNamed:@"default_autoscroll"]];
    
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@-medium",[live[@"avatar"] httpsToHttp]]] placeholderImage:[UIImage imageNamed:@"ic_change"]];
    
    NSInteger gender = [live[@"gender"] integerValue];
    NSString *genderImageName = gender == 1?@"mp_anchorinfo_female":@"mp_anchorinfo_male";
    self.genderImageView.image = [UIImage imageNamed:genderImageName];
    
    self.liveTitleLabel.text = live[@"title"];
    
    self.hostNameLabel.text = live[@"nickname"];
    
    NSString *online = [NSString stringWithFormat:@"%@",live[@"online"]];
    if ([online floatValue] > 10000){
        online = [NSString stringWithFormat:@"%.1f万",[online floatValue] / 10000];
    }
    self.onlineLabel.text = online;
    
    [self setNeedsLayout];
}


@end
