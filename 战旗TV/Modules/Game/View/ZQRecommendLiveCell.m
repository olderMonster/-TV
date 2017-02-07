//
//  ZQLiveCell.m
//  战旗TV
//
//  Created by 印聪 on 2016/12/29.
//  Copyright © 2016年 monster. All rights reserved.
//

#import "ZQRecommendLiveCell.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "NSString+AXNetworkingMethods.h"
@interface ZQRecommendLiveCell()

@property (nonatomic , strong)UIImageView *liveImageView;
@property (nonatomic , strong)UILabel *liveTitleLabel;
@property (nonatomic , strong)UILabel *hostNameLabel;
@property (nonatomic , strong)UIImageView *onlineImageView;
@property (nonatomic , strong)UILabel *onlineLabel;

@end

@implementation ZQRecommendLiveCell

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
    
    _liveTitleLabel = [[UILabel alloc]init];
    _liveTitleLabel.textColor = [UIColor whiteColor];
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
    
    [self.liveTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@5);
        make.right.equalTo(@(-5));
        make.bottom.equalTo(self.liveImageView).with.offset(-5);
    }];
    
    [self.onlineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-5));
        make.top.equalTo(self.liveImageView.mas_bottom);
        make.bottom.equalTo(self.contentView);
    }];
    
    [self.onlineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.onlineLabel);
        make.width.height.equalTo(@10);
        make.right.equalTo(self.onlineLabel.mas_left).with.offset(-5);
    }];
    
    [self.hostNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.liveTitleLabel);
//        make.width.equalTo(self.onlineImageView.mas_left);
        make.top.bottom.equalTo(self.onlineLabel);
    }];
    
}


#pragma mark -- getters and setters
- (void)setLive:(NSDictionary *)live{
    _live = live;
    
    [self.liveImageView sd_setImageWithURL:[NSURL URLWithString:[live[@"spic"] httpsToHttp]] placeholderImage:[UIImage imageNamed:@"default_autoscroll"]];
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
