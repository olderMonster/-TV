//
//  ZQEntainmentRecommendCell.m
//  战旗TV
//
//  Created by 印聪 on 2017/1/3.
//  Copyright © 2017年 monster. All rights reserved.
//

#import "ZQBaiBianCell.h"
#import "NSString+AXNetworkingMethods.h"
#import <UIImageView+WebCache.h>
@interface ZQBaiBianCell()

@property (nonatomic , strong)UIImageView *liveImageView;

@end

@implementation ZQBaiBianCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _liveImageView = [[UIImageView alloc]init];
        [self.contentView addSubview:_liveImageView];
        
    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.liveImageView.frame = self.contentView.bounds;
}


- (void)setLive:(NSDictionary *)live{
    _live = live;
    
    NSString *avatarStr = [NSString stringWithFormat:@"%@-sbig",[live[@"avatar"] httpsToHttp]];
    [self.liveImageView sd_setImageWithURL:[NSURL URLWithString:avatarStr] placeholderImage:[UIImage imageNamed:@"default_baibian"]];
}

@end
