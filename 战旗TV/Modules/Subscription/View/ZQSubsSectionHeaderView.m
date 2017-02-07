//
//  ZQSubsSectionHeaderView.m
//  战旗TV
//
//  Created by 印聪 on 2017/1/4.
//  Copyright © 2017年 monster. All rights reserved.
//

#import "ZQSubsSectionHeaderView.h"
#import <Masonry/Masonry.h>
@interface ZQSubsSectionHeaderView()

@property (nonatomic , strong)UIImageView *statusImageView;
@property (nonatomic , strong)UILabel *desLabel;
@property (nonatomic , strong)UIButton *loginButton;

@end

@implementation ZQSubsSectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        _statusImageView = [[UIImageView alloc]init];
        _statusImageView.image = [UIImage imageNamed:@"pic_weidenglu"];
        [self addSubview:_statusImageView];
        
        _desLabel = [[UILabel alloc]init];
        _desLabel.backgroundColor = [UIColor whiteColor];
        _desLabel.font = [UIFont systemFontOfSize:12];
        _desLabel.textAlignment = NSTextAlignmentCenter;
        _desLabel.text = @"登录即可获得关注主播的动态哦";
        _desLabel.textColor = [UIColor blackColor];
        [self addSubview:_desLabel];
        
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginButton.backgroundColor = [UIColor colorWithRed:88/255.0 green:195/255.0 blue:252/255.0 alpha:1.0];
        [_loginButton setTitle:@"立 即 登 录" forState:UIControlStateNormal];
        [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginButton addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_loginButton];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.right.bottom.equalTo(self).with.offset(-20);
        make.height.equalTo(@35);
    }];
    
    [self.desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.equalTo(@20);
        make.bottom.equalTo(self.loginButton.mas_top).with.offset(-15);
    }];
    
    [self.statusImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(@20);
        make.bottom.equalTo(self.desLabel.mas_top).with.offset(-20);
        make.height.equalTo(self.statusImageView.mas_width);
    }];
    
}


#pragma mark -- event response
- (void)loginAction{
    if ([self.delegate respondsToSelector:@selector(goLoginVC)]){
        [self.delegate goLoginVC];
    }
}

@end
