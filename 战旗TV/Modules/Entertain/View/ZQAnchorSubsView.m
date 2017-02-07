//
//  ZQAnchorSubsView.m
//  战旗TV
//
//  Created by 印聪 on 2017/1/17.
//  Copyright © 2017年 monster. All rights reserved.
//

#import "ZQAnchorSubsView.h"
#import "NSString+AXNetworkingMethods.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface ZQAnchorSubsView()

@property (nonatomic , strong)UIImageView *avatarImageView;
@property (nonatomic , strong)UILabel *nicknameLabel;
@property (nonatomic , strong)UIButton *subsButton; //订阅按钮
@property (nonatomic , strong)UILabel *onlineLabel;

@end

@implementation ZQAnchorSubsView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor blackColor];
        self.layer.masksToBounds = YES;
        self.alpha = 0.8;
        
        _avatarImageView = [[UIImageView alloc]init];
        _avatarImageView.layer.masksToBounds = YES;
        [self addSubview:_avatarImageView];
        
        _nicknameLabel = [[UILabel alloc]init];
        _nicknameLabel.backgroundColor = [UIColor clearColor];
        _nicknameLabel.textColor = [UIColor whiteColor];
        _nicknameLabel.font = [UIFont systemFontOfSize:9];
        _nicknameLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_nicknameLabel];
        
        _onlineLabel = [[UILabel alloc]init];
        _onlineLabel.backgroundColor = [UIColor clearColor];
        _onlineLabel.textColor = [UIColor whiteColor];
        _onlineLabel.font = [UIFont systemFontOfSize:8];
        _onlineLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_onlineLabel];
        
        _subsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _subsButton.backgroundColor = [UIColor colorWithRed:88/255.0 green:195/255.0 blue:252/255.0 alpha:1.0];
        [_subsButton setTitle:@"订阅" forState:UIControlStateNormal];
        [_subsButton setTitle:@"已订阅" forState:UIControlStateSelected];
        _subsButton.layer.masksToBounds = YES;
        _subsButton.titleLabel.font = [UIFont systemFontOfSize:8];
        [self addSubview:_subsButton];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.layer.cornerRadius = self.bounds.size.height * 0.5;
    
    self.avatarImageView.frame = CGRectMake(0, 0, self.bounds.size.height, self.bounds.size.height);
    self.avatarImageView.layer.cornerRadius = self.avatarImageView.bounds.size.height * 0.5;
    
    self.subsButton.frame = CGRectMake(self.bounds.size.width - self.bounds.size.height, 0, self.bounds.size.height, self.bounds.size.height);
    self.subsButton.layer.cornerRadius = self.subsButton.bounds.size.height * 0.5;
    
    self.nicknameLabel.frame = CGRectMake(CGRectGetMaxX(self.avatarImageView.frame), 0, self.subsButton.frame.origin.x - CGRectGetMaxX(self.avatarImageView.frame), self.bounds.size.height * 0.5);
    self.onlineLabel.frame = CGRectMake(self.nicknameLabel.frame.origin.x, CGRectGetMaxY(self.nicknameLabel.frame), self.nicknameLabel.bounds.size.width, self.nicknameLabel.bounds.size.height);
    
}

- (void)setAnchor:(NSDictionary *)anchor{
    _anchor = anchor;
    
    NSString *avatar = [anchor[@"avatar"] httpsToHttp];
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@-big",avatar]] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
    
    self.nicknameLabel.text = anchor[@"nickname"];
    NSString *online = [NSString stringWithFormat:@"%@",anchor[@"online"]];
    if ([online integerValue] > 10000) {
        online = [NSString stringWithFormat:@"%.1f万",[online integerValue]/10000.0];
    }
    self.onlineLabel.text = online;
    
}

@end
