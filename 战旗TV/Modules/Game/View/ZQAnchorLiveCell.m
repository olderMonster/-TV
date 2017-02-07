//
//  ZQAnchorLiveCell.m
//  战旗TV
//
//  Created by 印聪 on 2017/1/9.
//  Copyright © 2017年 monster. All rights reserved.
//

#import "ZQAnchorLiveCell.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "NSString+AXNetworkingMethods.h"
@interface ZQAnchorLiveCell()

@property (nonatomic , strong)UIImageView *liveImageView;
@property (nonatomic , strong)UILabel *titleLabel;
@property (nonatomic , strong)UILabel *nicknameLabel;
@property (nonatomic , strong)UIImageView *pageviewsImageView;
@property (nonatomic , strong)UILabel *pageviewsLabel; //观看人数

@end

@implementation ZQAnchorLiveCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        _liveImageView = [[UIImageView alloc]init];
        [self.contentView addSubview:_liveImageView];
        
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.backgroundColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont systemFontOfSize:10];
        _titleLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:_titleLabel];
        
        
        _nicknameLabel = [[UILabel alloc]init];
        _nicknameLabel.backgroundColor = [UIColor whiteColor];
        _nicknameLabel.font = [UIFont systemFontOfSize:10];
        _nicknameLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:_nicknameLabel];
        
        _pageviewsImageView = [[UIImageView alloc]init];
        _pageviewsImageView.image = [UIImage imageNamed:@"search_video_playnum"];
        [self.contentView addSubview:_pageviewsImageView];
        
        _pageviewsLabel = [[UILabel alloc]init];
        _pageviewsLabel.font = [UIFont systemFontOfSize:10];
        _pageviewsLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:_pageviewsLabel];
        
    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.liveImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.contentView);
        make.height.equalTo(@100);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(5);
        make.right.equalTo(self.contentView).with.offset(-5);
        make.top.equalTo(self.liveImageView.mas_bottom);
        make.height.equalTo(@20);
    }];
    
    [self.pageviewsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).with.offset(-5);
        make.top.equalTo(self.titleLabel.mas_bottom);
        make.bottom.equalTo(self.contentView);
    }];
    
    [self.pageviewsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.pageviewsLabel);
        make.width.height.equalTo(@10);
        make.right.equalTo(self.pageviewsLabel.mas_left).with.offset(-2);
    }];
    
    [self.nicknameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@3);
        make.top.bottom.equalTo(self.pageviewsLabel);
        make.right.lessThanOrEqualTo(self.pageviewsImageView.mas_left).with.offset(-5);
    }];
    
}



- (void)setLive:(NSDictionary *)live{
    _live = live;
    
    NSString *spic = [live[@"spic"] httpsToHttp];
    [self.liveImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",spic]] placeholderImage:[UIImage imageNamed:@"default_autoscroll"]];
    
    self.titleLabel.text = live[@"title"];
    self.pageviewsLabel.text = live[@"playCnt"];
    self.nicknameLabel.text = live[@"nickname"];
    
}

@end
