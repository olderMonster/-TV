//
//  Tabbar.m
//  新浪微博
//
//  Created by cong on 14-9-10.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "OMTabbar.h"

@interface OMTabbar()

@property (nonatomic , strong)OMTabbarItem *lastSelectedItem;

@end

@implementation OMTabbar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}


//添加选项卡
-(void)addItemWithIcon:(NSString *)icon selctedIcon:(NSString *)selctedIcon  title:(NSString *)title
{
    
    UIColor *selctedTextColor = self.selctedTextColor?self.selctedTextColor:[UIColor orangeColor];
    
    //创建Item
    OMTabbarItem *item = [[OMTabbarItem alloc]init];
    //设置按钮的文本
    [item setTitle:title forState:UIControlStateNormal];
    //设置按钮普通状态下文本颜色
    [item setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    //设置按钮高亮状态下文本颜色
    [item setTitleColor:selctedTextColor forState:UIControlStateSelected];
    //设置按钮图片
    [item setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    //调整按钮在高亮状态下不适应变化（不变形）
    item.adjustsImageWhenHighlighted = NO;
    //设置高亮状态下按钮的图片
    [item setImage:[UIImage imageNamed:selctedIcon] forState:UIControlStateSelected];
    //添加按钮点击事件
    [item addTarget:self action:@selector(itemAction:) forControlEvents:UIControlEventTouchDown];
    //先添加Item
    [self addSubview:item];
    
    //然后调整Item的frame
    NSInteger count = self.subviews.count;
    if (count == 1) {
        [self itemAction:item];
    }
    CGFloat height = self.frame.size.height;
    CGFloat width = self.frame.size.width / count;
    for (int i= 0; i<count; i++) {
        OMTabbarItem *tabbarItem = [self.subviews objectAtIndex:i];
        tabbarItem.frame = CGRectMake(width * i, 0, width, height);
        tabbarItem.tag = i;
    }
}

-(void)itemAction:(OMTabbarItem *)item
{
    if ([self.delegate respondsToSelector:@selector(tabbar:itemSelectedFrom:to:)]) {
        [self.delegate tabbar:self itemSelectedFrom:(int)self.lastSelectedItem.tag to:(int)item.tag];
        
    }

    //取消当前选中item
    self.lastSelectedItem.selected = NO;
    
    //选中点击的item
    item.selected = YES;
    
    //记录选中的item    
    self.lastSelectedItem = item;
}


- (void)setSelctedTextColor:(UIColor *)selctedTextColor{
    _selctedTextColor = selctedTextColor;
    
    for (UIView *item in self.subviews) {
        if ([item isKindOfClass:[OMTabbarItem class]]){
            OMTabbarItem *currentItem = (OMTabbarItem *)item;
            [currentItem setTitleColor:selctedTextColor forState:UIControlStateSelected];
        }
    }
    
}

@end
