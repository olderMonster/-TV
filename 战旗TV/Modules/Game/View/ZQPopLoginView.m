//
//  ZQPopLoginView.m
//  战旗TV
//
//  Created by 印聪 on 2017/1/24.
//  Copyright © 2017年 monster. All rights reserved.
//

#import "ZQPopLoginView.h"

@implementation ZQPopLoginView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.5;
        
    }
    return self;
}

- (void)setFrame:(CGRect)frame{
    frame.size.width = [UIScreen mainScreen].bounds.size.width;
    frame.size.height = [UIScreen mainScreen].bounds.size.height;
    [super setFrame:frame];
}

@end
