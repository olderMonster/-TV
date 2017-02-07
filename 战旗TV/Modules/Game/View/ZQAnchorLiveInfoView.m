//
//  ZQAnchorLiveInfoView.m
//  战旗TV
//
//  Created by 印聪 on 2017/1/9.
//  Copyright © 2017年 monster. All rights reserved.
//

#import "ZQAnchorLiveInfoView.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "NSString+AXNetworkingMethods.h"



@interface ZQAnchorLiveInfoView()

@property (nonatomic , strong)UIImageView *avatarImageView; //主播头像
@property (nonatomic , strong)UIImageView *levelImageView;  //主播等级
@property (nonatomic , strong)UILabel *nicknameLabel;       //主播昵称
@property (nonatomic , strong)UILabel *livingLabel;         //'正在直播'
@property (nonatomic , strong)UILabel *livingChannelLabel;  //直播的栏目
@property (nonatomic , strong)UIImageView *onlineImageView;
@property (nonatomic , strong)UILabel *onlineLabel;         //在线人数
@property (nonatomic , strong)UIButton *subsButton;         //订阅
//这里因为订阅文本与（正在直播等文本在同一行，一次这里就不用一个按钮）
@property (nonatomic , strong)UIButton *subsTextButton;      //'订阅'
@property (nonatomic , strong)UIView *sepView;

@end

@implementation ZQAnchorLiveInfoView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        _avatarImageView = [[UIImageView alloc] init];
        _avatarImageView.layer.masksToBounds = YES;
        [self addSubview:_avatarImageView];
        
        _levelImageView = [[UIImageView alloc] init]; //96 x 32
        [self addSubview:_levelImageView];
        
        _nicknameLabel = [[UILabel alloc] init];
        _nicknameLabel.backgroundColor = [UIColor whiteColor];
        _nicknameLabel.font = [UIFont systemFontOfSize:13];
        _nicknameLabel.textColor = [UIColor blackColor];
        [self addSubview:_nicknameLabel];
        
        
        _livingLabel = [[UILabel alloc] init];
        _livingLabel.backgroundColor = [UIColor whiteColor];
        _livingLabel.font = [UIFont systemFontOfSize:10];
        _livingLabel.textColor = [UIColor grayColor];
        _livingLabel.text = @"正在直播：";
        [self addSubview:_livingLabel];
        
        _livingChannelLabel = [[UILabel alloc] init];
        _livingChannelLabel.backgroundColor = [UIColor whiteColor];
        _livingChannelLabel.font = [UIFont systemFontOfSize:10];
        _livingChannelLabel.textColor = [UIColor colorWithRed:88/255.0 green:195/255.0 blue:252/255.0 alpha:1.0];
        [self addSubview:_livingChannelLabel];
        
        _onlineImageView = [[UIImageView alloc] init];
        _onlineImageView.image = [UIImage imageNamed:@"room_online_icon"];
        [self addSubview:_onlineImageView];
        
        _onlineLabel = [[UILabel alloc]init];
        _onlineLabel.backgroundColor = [UIColor whiteColor];
        _onlineLabel.font = [UIFont systemFontOfSize:10];
        _onlineLabel.textColor = [UIColor grayColor];
        [self addSubview:_onlineLabel];
        
        _subsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_subsButton setBackgroundImage:[UIImage imageNamed:@"ic_dingyue_on"] forState:UIControlStateNormal];
        [_subsButton setBackgroundImage:[UIImage imageNamed:@"ic_dingyue_off"] forState:UIControlStateSelected];
        [_subsButton addTarget:self action:@selector(subsAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_subsButton];
        
        _subsTextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_subsTextButton setTitle:@"订阅" forState:UIControlStateNormal];
        [_subsTextButton setTitle:@"已订阅" forState:UIControlStateSelected];
        [_subsTextButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _subsTextButton.titleLabel.font = [UIFont systemFontOfSize:8];
        [_subsTextButton addTarget:self action:@selector(subsAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_subsTextButton];
        
        _sepView = [[UIView alloc]init];
        _sepView.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:249/255.0 alpha:1.0];
        [self addSubview:_sepView];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.sepView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self);
        make.height.equalTo(@10);
    }];
    
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self).with.offset(10);
        make.bottom.equalTo(self.sepView.mas_top).with.offset(-10);
        make.width.equalTo(self.avatarImageView.mas_height);
    }];
    
    self.avatarImageView.layer.cornerRadius = (self.bounds.size.height - 30) * 0.5;
    
    [self.levelImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.centerX.equalTo(self.avatarImageView);
        make.width.equalTo(@(96 * 0.4));
        make.height.equalTo(@(32 * 0.4));
    }];
    
    [self.subsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(10);
        make.right.equalTo(self).with.offset(-10);
        make.width.height.equalTo(@30);
    }];
    
    [self.nicknameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarImageView.mas_right).with.offset(10);
        make.top.equalTo(self.avatarImageView).with.offset(5);
        make.right.equalTo(self.subsButton.mas_left).with.offset(-10);
    }];
    
    [self.livingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.levelImageView);
        make.left.equalTo(self.nicknameLabel);
    }];
    
    [self.livingChannelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.livingLabel.mas_right);
        make.centerY.equalTo(self.livingLabel);
    }];
    
    [self.onlineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.livingChannelLabel.mas_right).with.offset(20);
        make.centerY.equalTo(self.levelImageView);
        make.width.height.equalTo(@10);
    }];
    
    [self.onlineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.onlineImageView.mas_right).with.offset(2);
        make.centerY.equalTo(self.levelImageView);
        make.right.lessThanOrEqualTo(self.subsButton.mas_left).with.offset(10);
    }];
    
    
    [self.subsTextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.livingLabel);
        make.centerX.equalTo(self.subsButton);
    }];
}


#pragma mark -- Private method
- (void)subsAction{
    if ([self.delegate respondsToSelector:@selector(subscribeAnchor:textButton:)]) {
        [self.delegate subscribeAnchor:self.subsButton textButton:self.subsTextButton];
    }
}


#pragma mark -- Getters and setters
- (void)setAnchor:(NSDictionary *)anchor{
    _anchor = anchor;
    
    NSString *avatar = [anchor[@"avatar"] httpsToHttp];
    avatar = [NSString stringWithFormat:@"%@-medium",avatar];
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:avatar] placeholderImage:[UIImage imageNamed:@"ic_change"]];
    
    self.nicknameLabel.text = anchor[@"nickname"];
    self.livingChannelLabel.text = anchor[@"gameName"];
    
    NSString *onlineCount = [NSString stringWithFormat:@"%@",anchor[@"online"]];
    if ([onlineCount integerValue] > 10000) {
        onlineCount = [NSString stringWithFormat:@"%.1f万",[onlineCount integerValue]/10000.0f];
    }
    self.onlineLabel.text = onlineCount;
    
    self.levelImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"ic_zhubodengji_%@",anchor[@"level"]]];
    
    [self setNeedsLayout];
}




@end
