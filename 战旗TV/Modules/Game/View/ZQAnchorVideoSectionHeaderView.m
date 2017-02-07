//
//  ZQAnchorVideoSectionHeaderView.m
//  战旗TV
//
//  Created by 印聪 on 2017/1/9.
//  Copyright © 2017年 monster. All rights reserved.
//

#import "ZQAnchorVideoSectionHeaderView.h"
#import "OMSegmentedControl.h"
@interface ZQAnchorVideoSectionHeaderView()

@property (nonatomic , strong)UIButton *recentButton;
@property (nonatomic , strong)UIButton *hotButton;

@property (nonatomic , strong)UIView *verSepLine;
@property (nonatomic , strong)UIView *bottomLine;

@end

@implementation ZQAnchorVideoSectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        _recentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_recentButton setTitle:@"最新视频" forState:UIControlStateNormal];
        [_recentButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_recentButton setTitleColor:[UIColor colorWithRed:88/255.0 green:195/255.0 blue:252/255.0 alpha:1.0] forState:UIControlStateSelected];
        _recentButton.titleLabel.font = [UIFont systemFontOfSize:10];
        _recentButton.selected = YES;
        [_recentButton addTarget:self action:@selector(recentAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_recentButton];
        
        
        _hotButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_hotButton setTitle:@"最热视频" forState:UIControlStateNormal];
        [_hotButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_hotButton setTitleColor:[UIColor colorWithRed:88/255.0 green:195/255.0 blue:252/255.0 alpha:1.0] forState:UIControlStateSelected];
        _hotButton.titleLabel.font = [UIFont systemFontOfSize:10];
        [_hotButton addTarget:self action:@selector(hotAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_hotButton];
        
        
        _verSepLine = [[UIView alloc]init];
        _verSepLine.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:241/255.0 alpha:1.0];
        [self addSubview:_verSepLine];
        
        _bottomLine = [[UIView alloc]init];
        _bottomLine.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:241/255.0 alpha:1.0];
        [self addSubview:_bottomLine];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.recentButton.frame = CGRectMake(0, 0, self.bounds.size.width * 0.5, self.bounds.size.height);
    self.hotButton.frame = CGRectMake(CGRectGetMaxX(self.recentButton.frame), 0, self.bounds.size.width * 0.5, self.bounds.size.height);
    
    self.verSepLine.bounds = CGRectMake(0, 0, 0.8, self.bounds.size.height - 15);
    self.verSepLine.center = self.center;
    
    self.bottomLine.frame = CGRectMake(0, self.bounds.size.height - 1, self.bounds.size.width, 1);
    
}


#pragma mark -- Event response
- (void)recentAction{
    self.recentButton.selected = YES;
    self.hotButton.selected = NO;
    
    if ([self.delegate respondsToSelector:@selector(didSelectedNewVideo:)]) {
        [self.delegate didSelectedNewVideo:self];
    }
}

- (void)hotAction{
    self.recentButton.selected = NO;
    self.hotButton.selected = YES;
    if ([self.delegate respondsToSelector:@selector(didSelectedHotVideo:)]){
        [self.delegate didSelectedHotVideo:self];
    }
}

@end
