//
//  ZQPhoneCodeSectionHeader.m
//  战旗TV
//
//  Created by 印聪 on 2017/1/12.
//  Copyright © 2017年 monster. All rights reserved.
//

#import "ZQPhoneCodeSectionHeader.h"

@interface ZQPhoneCodeSectionHeader()

@property (nonatomic , strong)UILabel *titleLabel;

@end

@implementation ZQPhoneCodeSectionHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:249/255.0 alpha:1.0];
        
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:11];
        _titleLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:_titleLabel];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.titleLabel.frame = CGRectMake(10, 0, self.bounds.size.width - 20, self.bounds.size.height);
    
}

- (void)setTitle:(NSString *)title{
    _title = title;
    
    self.titleLabel.text = title;
}

@end
