//
//  ZQGameSectionFooterView.m
//  战旗TV
//
//  Created by 印聪 on 2016/12/29.
//  Copyright © 2016年 monster. All rights reserved.
//

#import "ZQGameSectionFooterView.h"
#import <Masonry.h>
@interface ZQGameSectionFooterView()

@property (nonatomic , strong)UIButton *actionButton; //110 x 24

@end


@implementation ZQGameSectionFooterView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        _actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_actionButton];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat height = 10;
    CGFloat width = 110 * height / 24;
    [self.actionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(@(-10));
        make.width.equalTo(@(width));
        make.height.equalTo(@(height));
    }];
    
}


#pragma mark -- getters and setters
- (void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
    
    NSString *imageName = indexPath.section == 0?@"home_rec_refresh":@"home_rec_more";
    [self.actionButton setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
}


@end
