//
//  ZQEditChannelCell.m
//  战旗TV
//
//  Created by 印聪 on 2016/12/30.
//  Copyright © 2016年 monster. All rights reserved.
//

#import "ZQEditChannelCell.h"
#import <Masonry.h>
#import "NSString+AXNetworkingMethods.h"
#import <UIImageView+WebCache.h>

@interface ZQEditChannelCell()

@property (nonatomic , strong)UIImageView *channelImageView;
@property (nonatomic , strong)UILabel *channelLabel;
@property (nonatomic , strong)UIButton *deleteButton;

@end

@implementation ZQEditChannelCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        _channelImageView = [[UIImageView alloc]init];
        [self.contentView addSubview:_channelImageView];
        
        _channelLabel = [[UILabel alloc]init];
        _channelLabel.font = [UIFont systemFontOfSize:10];
        _channelLabel.textAlignment = NSTextAlignmentCenter;
        _channelLabel.numberOfLines = 0;
        [_channelLabel sizeToFit];
        [self.contentView addSubview:_channelLabel];
        
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteButton setBackgroundImage:[UIImage imageNamed:@"channel_delete"] forState:UIControlStateNormal];
        [_deleteButton addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_deleteButton];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.channelImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.contentView);
        make.height.equalTo(@(self.contentView.bounds.size.width));
    }];
    
    [self.channelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.channelImageView.mas_bottom).with.offset(5);
    }];
    
    [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.channelImageView).offset(self.contentView.bounds.size.width * 0.5 * 0.717);
        make.centerY.equalTo(self.channelImageView).offset(-self.contentView.bounds.size.width * 0.5 * 0.717);
        make.width.height.equalTo(@15);
    }];
    
}

#pragma mark -- event response
- (void)deleteAction{
    if ([self.delegate respondsToSelector:@selector(didDeleteCell:)]) {
        [self.delegate didDeleteCell:self];
    }
}


#pragma mark -- getters and setters
- (void)setChannel:(NSDictionary *)channel{
    _channel = channel;
    
    self.channelLabel.text = channel[@"name"];
    self.deleteButton.hidden = ![channel[@"status"] boolValue];
    
    BOOL localImage = [channel[@"is_local"] boolValue];
    NSString *imageName = channel[@"appIcon"];
    if (localImage) {
        self.channelImageView.image = [UIImage imageNamed:imageName];
    }else{
        imageName = [imageName httpsToHttp];
        [self.channelImageView sd_setImageWithURL:[NSURL URLWithString:imageName]];
    }
    
    
}

@end
