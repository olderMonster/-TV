//
//  ZQSubsSectionHeaderView.h
//  战旗TV
//
//  Created by 印聪 on 2017/1/4.
//  Copyright © 2017年 monster. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZQSubsSectionHeaderViewDelegate <NSObject>

- (void)goLoginVC;

@end

@interface ZQSubsSectionHeaderView : UICollectionReusableView

@property (nonatomic , weak)id<ZQSubsSectionHeaderViewDelegate>delegate;

@end
