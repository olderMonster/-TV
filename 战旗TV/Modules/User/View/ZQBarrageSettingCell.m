//
//  ZQBarrageSettingCell.m
//  战旗TV
//
//  Created by 印聪 on 2017/1/6.
//  Copyright © 2017年 monster. All rights reserved.
//

#import "ZQBarrageSettingCell.h"
#import <Masonry/Masonry.h>


@interface ZQBarrageSettingCell()

@property (nonatomic , strong)UILabel *titleLabel;
@property (nonatomic , strong)UIButton *leftBtn;
@property (nonatomic , strong)UIButton *middleBtn;
@property (nonatomic , strong)UIButton *rightBtn;

@end

@implementation ZQBarrageSettingCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_titleLabel];
        
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftBtn addTarget:self action:@selector(leftBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_leftBtn];
        
        _middleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _middleBtn.selected = YES;
        [_middleBtn addTarget:self action:@selector(middleBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_middleBtn];
        
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightBtn addTarget:self action:@selector(rightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_rightBtn];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.top.bottom.equalTo(self.contentView);
    }];
    
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).with.offset(-20);
        make.centerY.equalTo(self.contentView);
        make.height.equalTo(self.contentView).multipliedBy(0.7);
        make.width.equalTo(self.rightBtn.mas_height);
    }];
    
    [self.middleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.rightBtn.mas_left).with.offset(-20);
        make.centerY.width.height.equalTo(self.rightBtn);
    }];
    
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.middleBtn.mas_left).with.offset(-20);
        make.centerY.width.height.equalTo(self.rightBtn);
    }];
    
}


- (void)setSetDict:(NSDictionary *)setDict{
    _setDict = setDict;
    
    self.titleLabel.text = setDict[@"title"];
    
    [self.leftBtn setBackgroundImage:[UIImage imageNamed:setDict[@"leftNormal"]] forState:UIControlStateNormal];
    [self.leftBtn setBackgroundImage:[UIImage imageNamed:setDict[@"leftSelected"]] forState:UIControlStateSelected];
    
    [self.middleBtn setBackgroundImage:[UIImage imageNamed:setDict[@"middleNormal"]] forState:UIControlStateNormal];
    [self.middleBtn setBackgroundImage:[UIImage imageNamed:setDict[@"middleSelected"]] forState:UIControlStateSelected];
    
    [self.rightBtn setBackgroundImage:[UIImage imageNamed:setDict[@"rightNormal"]] forState:UIControlStateNormal];
    [self.rightBtn setBackgroundImage:[UIImage imageNamed:setDict[@"rightSelected"]] forState:UIControlStateSelected];
}


#pragma makr -- Event response
- (void)leftBtnAction:(UIButton *)button{
    button.selected = YES;
    self.middleBtn.selected = NO;
    self.rightBtn.selected = NO;
}

- (void)middleBtnAction:(UIButton *)button{
    button.selected = YES;
    self.leftBtn.selected = NO;
    self.rightBtn.selected = NO;
}

- (void)rightBtnAction:(UIButton *)button{
    button.selected = YES;
    self.leftBtn.selected = NO;
    self.middleBtn.selected = NO;
}


@end
