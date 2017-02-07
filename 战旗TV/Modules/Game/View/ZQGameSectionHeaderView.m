//
//  ZQGameSectionHeaderView.m
//  战旗TV
//
//  Created by 印聪 on 2016/12/29.
//  Copyright © 2016年 monster. All rights reserved.
//

#import "ZQGameSectionHeaderView.h"

#import <Masonry.h>
#import <UIImageView+WebCache.h>
#import "NSString+AXNetworkingMethods.h"

@interface ZQGameSectionHeaderView()

@property (nonatomic , strong)UIImageView *titleImageView; //196 x 50
@property (nonatomic , strong)UILabel *subtitleLabel;

@property (nonatomic , strong)UIView *seplineView;

@end

@implementation ZQGameSectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self setupView];
    }
    return self;
}


- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [self.seplineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.right.equalTo(@(-20));
        make.top.equalTo(@(0));
        make.height.equalTo(@1);
    }];
    
    CGFloat height = 20;
    CGFloat width = 196 * height / 50;
    [self.titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@10);
        make.width.equalTo(@(width));
        make.height.equalTo(@(height));
        make.centerX.equalTo(self);
    }];
    
    [self.subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.titleImageView.mas_bottom).with.offset(5);
    }];
    
}


#pragma mark -- private method
- (void)setupView{
    
    _seplineView = [[UIView alloc]init];
    _seplineView.hidden = YES;
    _seplineView.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:249/255.0 alpha:1.0];
    [self addSubview:_seplineView];
    
    _titleImageView = [[UIImageView alloc]init];
    [self addSubview:_titleImageView];
    
    _subtitleLabel = [[UILabel alloc]init];
    _subtitleLabel.textColor = [UIColor grayColor];
    _subtitleLabel.font = [UIFont systemFontOfSize:12];
    _subtitleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_subtitleLabel];
    
}

#pragma mark -- getters and setters
- (void)setChannel:(NSDictionary *)channel{
    _channel = channel;
    
    [self.titleImageView sd_setImageWithURL:[NSURL URLWithString:[channel[@"icon"] httpsToHttp]]];
    self.subtitleLabel.text = channel[@"subTitle"];
    
    [self setNeedsLayout];
    
}

- (void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
    
    if (indexPath.section != 0) {
        self.seplineView.hidden = NO;
    }else{
        self.seplineView.hidden = YES;
    }
    
}


@end
