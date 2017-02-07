//
//  ZQEntainmentSectionHeaderView.m
//  战旗TV
//
//  Created by 印聪 on 2017/1/3.
//  Copyright © 2017年 monster. All rights reserved.
//

#import "ZQBaiBianSectionHeaderView.h"

@interface ZQBaiBianSectionHeaderView()

@property (nonatomic , strong)UILabel *titleLabel;

@end

@implementation ZQBaiBianSectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.font = [UIFont systemFontOfSize:16];
        
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.backgroundColor = [UIColor whiteColor];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = self.font;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
        
    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.titleLabel.frame = CGRectMake(0, 0 , self.bounds.size.width, self.bounds.size.height);
}


- (void)setTitle:(NSString *)title{
    _title = title;
    
    self.titleLabel.text = title;
    
}

- (void)setFont:(UIFont *)font{
    _font = font;
    
    self.titleLabel.font = font;
    
}

@end
