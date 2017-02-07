//
//  ZQEntainmentLiveOtherAnchorCell.m
//  战旗TV
//
//  Created by 印聪 on 2017/1/17.
//  Copyright © 2017年 monster. All rights reserved.
//

#import "ZQEntainmentLiveOtherAnchorCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NSString+AXNetworkingMethods.h"
@interface ZQEntainmentLiveOtherAnchorCell()

@property (nonatomic , strong)UIImageView *avatarImageView;

@end

@implementation ZQEntainmentLiveOtherAnchorCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        _avatarImageView = [[UIImageView alloc]init];
        _avatarImageView.layer.masksToBounds = YES;
        [self.contentView addSubview:_avatarImageView];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.avatarImageView.frame = self.contentView.bounds;
    self.avatarImageView.layer.cornerRadius = self.avatarImageView.bounds.size.height * 0.5;
    
}

- (void)setAvatar:(NSString *)avatar{
    _avatar = avatar;
    
    NSString *avatarStr = [avatar httpsToHttp];
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@-big",avatarStr]] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
    
}

@end
