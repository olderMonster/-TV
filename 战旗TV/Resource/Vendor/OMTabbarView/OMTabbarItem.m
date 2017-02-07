//
//  TabbarItem.m
//  新浪微博
//
//  Created by cong on 14-9-10.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "OMTabbarItem.h"
#define kTitleRatio 0.3

@interface OMTabbarItem()


@end

@implementation OMTabbarItem


-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //设置button的文本居中
        self.titleLabel.textAlignment = 1;
        self.titleLabel.font = [UIFont systemFontOfSize:10];
        //设置button图片的显示
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        
    }
    return self;
}

//覆盖父类在highlight时的操作
-(void)setHighlighted:(BOOL)highlighted
{
    
}

//调整button内部文字的位置
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleX = 0;
    CGFloat titleheight = contentRect.size.height * kTitleRatio;
    CGFloat titleY = contentRect.size.height - titleheight - 3;
    CGFloat titlewidth = contentRect.size.width;
    return CGRectMake(titleX,titleY,titlewidth,titleheight);
}

//调整button内部图片的位置
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageX = 0;
    CGFloat imageheight = contentRect.size.height *(1- kTitleRatio - 0.1) - 5;
    CGFloat imageY = 5;
    CGFloat imagewidth = contentRect.size.width;
    return CGRectMake(imageX,imageY,imagewidth,imageheight);
}

@end
