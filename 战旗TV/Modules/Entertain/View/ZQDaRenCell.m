//
//  ZQDaRenCell.m
//  战旗TV
//
//  Created by 印聪 on 2017/1/3.
//  Copyright © 2017年 monster. All rights reserved.
//

#import "ZQDaRenCell.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>
#import "NSString+AXNetworkingMethods.h"
@interface ZQDaRenCell()

@property (nonatomic , strong)UIImageView *picImageView;
@property (nonatomic , strong)UIImageView *textBgImageView;
@property (nonatomic , strong)UILabel *nickNameLabel;
@property (nonatomic , strong)UILabel *onlineLabel;
@property (nonatomic , strong)UIImageView *onlineImageView;

@end

@implementation ZQDaRenCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        _picImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_picImageView];
        
        _textBgImageView = [[UIImageView alloc] init];
        _textBgImageView.backgroundColor = [UIColor blackColor];
        _textBgImageView.alpha = 0.2;
        [self.contentView addSubview:_textBgImageView];
        
        _nickNameLabel = [[UILabel alloc] init];
        _nickNameLabel.textColor = [UIColor whiteColor];
        _nickNameLabel.font = [UIFont systemFontOfSize:10];
        [self.contentView addSubview:_nickNameLabel];
        
        _onlineLabel = [[UILabel alloc] init];
        _onlineLabel.textColor = [UIColor whiteColor];
        _onlineLabel.font = [UIFont systemFontOfSize:10];
        [self.contentView addSubview:_onlineLabel];
        
        _onlineImageView = [[UIImageView alloc]init];
        _onlineImageView.image = [UIImage imageNamed:@"room_online_white_icon"];
        [self.contentView addSubview:_onlineImageView];
        
    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.picImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    [self.textBgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView).with.offset(0);
        make.height.equalTo(@20);
    }];
    
    [self.onlineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.textBgImageView);
        make.right.equalTo(self.contentView).with.offset(-5);
    }];
    
    [self.onlineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.textBgImageView);
        make.right.equalTo(self.onlineLabel.mas_left).with.offset(-2);
        make.width.height.equalTo(@10);
    }];
    
    [self.nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@5);
        make.centerY.equalTo(self.textBgImageView);
        make.right.lessThanOrEqualTo(self.onlineImageView.mas_left).with.offset(-5);
    }];
    
}


- (void)setLive:(NSDictionary *)live{
    _live = live;
    
    NSString *picUrl = [NSString stringWithFormat:@"%@-sbig",[live[@"avatar"] httpsToHttp]];
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:picUrl] placeholderImage:[UIImage imageNamed:@"default_meipai_small"]];
    
    self.nickNameLabel.text = live[@"nickname"];
    
    NSString *online = [NSString stringWithFormat:@"%@",live[@"online"]];
    if ([online integerValue] > 10000){
        online = [NSString stringWithFormat:@"%.1f万",[online floatValue]/10000];
    }
    self.onlineLabel.text = online;
    
}

@end
