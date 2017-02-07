//
//  ZQBarrageAlphaCell.m
//  战旗TV
//
//  Created by 印聪 on 2017/1/6.
//  Copyright © 2017年 monster. All rights reserved.
//

#import "ZQBarrageAlphaCell.h"
#import <Masonry/Masonry.h>

@interface ZQBarrageAlphaCell()

@property (nonatomic , strong)UILabel *barrageLabel;
@property (nonatomic , strong)UILabel *titleLabel;
@property (nonatomic , strong)UILabel *progressLabel;
@property (nonatomic , strong)UISlider *sliderView;

@end

@implementation ZQBarrageAlphaCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _barrageLabel = [[UILabel alloc]init];
        _barrageLabel.text = @"我是弹幕君哟~";
        _barrageLabel.textColor = [UIColor colorWithRed:88/255.0 green:195/255.0 blue:252/255.0 alpha:1.0];
        _barrageLabel.font = [UIFont systemFontOfSize:14];
        _barrageLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_barrageLabel];
        
        
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:12];
        _titleLabel.text = @"弹幕透明度";
        [self.contentView addSubview:_titleLabel];
        
        _progressLabel = [[UILabel alloc]init];
        _progressLabel.textColor = [UIColor colorWithRed:88/255.0 green:195/255.0 blue:252/255.0 alpha:1.0];
        _progressLabel.text = @"100%";
        _progressLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_progressLabel];
        
        _sliderView = [[UISlider alloc]init];
        _sliderView.value = 1;
        _sliderView.minimumTrackTintColor = [UIColor colorWithRed:88/255.0 green:195/255.0 blue:252/255.0 alpha:1.0];
        _sliderView.maximumTrackTintColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:249/255.0 alpha:1.0];
        [_sliderView setThumbImage:[UIImage imageNamed:@"ic_toumingdu"] forState:UIControlStateNormal];
        [_sliderView addTarget:self action:@selector(alphaChanged) forControlEvents:UIControlEventValueChanged];
        [self.contentView addSubview:_sliderView];
        
        
    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.barrageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.contentView);
        make.height.equalTo(self.contentView).multipliedBy(0.5); //高度为cell的0.5倍
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.bottom.equalTo(self.contentView);
        make.height.equalTo(self.contentView).multipliedBy(0.5);
    }];
    
    [self.progressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right).with.offset(20);
        make.centerY.height.equalTo(self.titleLabel);
    }];
    
    [self.sliderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.progressLabel.mas_right).with.offset(10);
        make.right.equalTo(self.contentView).with.offset(-10);
//        make.height.equalTo(self.progressLabel);
        make.centerY.equalTo(self.progressLabel);
    }];
    
}

#pragma mark -- Event response
- (void)alphaChanged{
    self.progressLabel.text = [NSString stringWithFormat:@"%.0f%%",self.sliderView.value * 100];
    _barrageLabel.textColor = [UIColor colorWithRed:88/255.0 green:195/255.0 blue:252/255.0 alpha:self.sliderView.value];
}

@end
