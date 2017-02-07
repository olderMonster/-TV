//
//  ZQEditChannelSectionHeaderView.m
//  战旗TV
//
//  Created by 印聪 on 2016/12/30.
//  Copyright © 2016年 monster. All rights reserved.
//

#import "ZQEditChannelSectionHeaderView.h"

#import <Masonry.h>

@interface ZQEditChannelSectionHeaderView()

@property (nonatomic , strong)UILabel *titleLabel;
@property (nonatomic , strong)UILabel *subtitleLabel;

@end

@implementation ZQEditChannelSectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:13];
        _titleLabel.textColor = [UIColor grayColor];
        [self addSubview:_titleLabel];
        
        
        _subtitleLabel = [[UILabel alloc] init];
        _subtitleLabel.font = [UIFont systemFontOfSize:10];
        _subtitleLabel.textColor = [UIColor grayColor];
        [self addSubview:_subtitleLabel];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.centerY.equalTo(self);
    }];
    

    [self.subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right).with.offset(5);
        make.bottom.equalTo(self.titleLabel);
    }];
    
}


#pragma mark -- getters and setters
- (void)setTitle:(NSString *)title{
    _title = title;
    
    self.titleLabel.text = title;
    
    [self setNeedsLayout];
    
}

- (void)setSubtitle:(NSString *)subtitle{
    _subtitle = subtitle;
    self.subtitleLabel.text = subtitle;
    
     [self setNeedsLayout];
}

@end
