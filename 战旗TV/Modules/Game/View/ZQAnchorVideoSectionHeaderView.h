//
//  ZQAnchorVideoSectionHeaderView.h
//  战旗TV
//
//  Created by 印聪 on 2017/1/9.
//  Copyright © 2017年 monster. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZQAnchorVideoSectionHeaderView;

@protocol ZQAnchorVideoSectionHeaderViewDelegate <NSObject>

- (void)didSelectedNewVideo:(ZQAnchorVideoSectionHeaderView *)headerView;
- (void)didSelectedHotVideo:(ZQAnchorVideoSectionHeaderView *)headerView;

@end

@interface ZQAnchorVideoSectionHeaderView : UICollectionReusableView

@property (nonatomic , weak)id<ZQAnchorVideoSectionHeaderViewDelegate>delegate;

@end
