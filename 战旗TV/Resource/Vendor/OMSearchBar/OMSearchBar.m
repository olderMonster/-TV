//
//  OMSearchBar.m
//  战旗TV
//
//  Created by 印聪 on 2017/1/12.
//  Copyright © 2017年 monster. All rights reserved.
//

#import "OMSearchBar.h"

@implementation OMSearchBar

- (void)layoutSubviews{
    
    // view是searchBar中的唯一的直接子控件
    for (UIView *view in self.subviews) {
        // UISearchBarBackground与UISearchBarTextField是searchBar的简介子控件
        for (UIView *subview in view.subviews) {
            
            // 找到UISearchBarTextField
            if ([subview isKindOfClass:[UITextField class]]) {
                
                if (UIEdgeInsetsEqualToEdgeInsets(UIEdgeInsetsZero, self.contentInset)) { // 若contentInset被赋值
                    // 根据contentInset改变UISearchBarTextField的布局
                    subview.frame = CGRectMake( self.contentInset.left, self.contentInset.top,self.bounds.size.width - self.contentInset.left -  self.contentInset.right, self.bounds.size.height -  self.contentInset.top -  self.contentInset.bottom);
                } else { // 若contentSet未被赋值
                    // 设置UISearchBar中UISearchBarTextField的默认边距
                    CGFloat top = (self.bounds.size.height - 28.0) / 2.0;
                    CGFloat bottom = top;
                    CGFloat left = 8.0;
                    CGFloat right = left;
                    self.contentInset = UIEdgeInsetsMake(top, left, bottom, right);
                }
            }
        }
    }
    
}

@end
