//
//  ZQLiveRankProtectCell.m
//  战旗TV
//
//  Created by 印聪 on 2017/1/10.
//  Copyright © 2017年 monster. All rights reserved.
//

#import "ZQLiveRankProtectCell.h"
#import <Masonry/Masonry.h>
#import "NSString+AXNetworkingMethods.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface ZQLiveRankProtectCell()

@property (nonatomic , strong)UIImageView *avatarImageView;
@property (nonatomic , strong)UIImageView *identityImageView;
@property (nonatomic , strong)UILabel *nicknameLabel;

@end

@implementation ZQLiveRankProtectCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        _avatarImageView = [[UIImageView alloc]init];
        _avatarImageView.layer.masksToBounds = YES;
        [self.contentView addSubview:_avatarImageView];
        
        _identityImageView = [[UIImageView alloc]init]; //108 x 32
        [self.contentView addSubview:_identityImageView];
        
        _nicknameLabel = [[UILabel alloc]init];
        _nicknameLabel.backgroundColor = [UIColor whiteColor];
        _nicknameLabel.font = [UIFont systemFontOfSize:10];
        _nicknameLabel.textColor = [UIColor blackColor];
        _nicknameLabel.textAlignment = NSTextAlignmentCenter;
        _nicknameLabel.numberOfLines = 0;
        [_nicknameLabel sizeToFit];
        [self.contentView addSubview:_nicknameLabel];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.contentView);
        make.height.equalTo(self.avatarImageView.mas_width);
    }];
    
    self.avatarImageView.layer.cornerRadius = self.contentView.frame.size.width* 0.5;
    
    [self.identityImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.bottom.equalTo(self.avatarImageView);
        make.width.equalTo(@(108 * 0.4));
        make.height.equalTo(@(32 * 0.4));
    }];
    
    [self.nicknameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.avatarImageView.mas_bottom);
        make.bottom.lessThanOrEqualTo(self.contentView);
    }];

}

- (void)setProtectUser:(NSDictionary *)protectUser{
    _protectUser = protectUser;
    
    NSString *avatar = [protectUser[@"avatar"] httpsToHttp];
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@-big",avatar]] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
    
    self.identityImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"guard_0%@",protectUser[@"level"]]];
    self.nicknameLabel.text = protectUser[@"nickname"];
    
}


@end
