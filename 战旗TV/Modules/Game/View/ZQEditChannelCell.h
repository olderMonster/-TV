//
//  ZQEditChannelCell.h
//  战旗TV
//
//  Created by 印聪 on 2016/12/30.
//  Copyright © 2016年 monster. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZQEditChannelCell;

@protocol ZQEditChannelCellDelegate <NSObject>

@optional
- (void)didDeleteCell:(ZQEditChannelCell *)cell;

@end

@interface ZQEditChannelCell : UICollectionViewCell

@property (nonatomic , strong)NSDictionary *channel;
@property (nonatomic , weak)id<ZQEditChannelCellDelegate>delegate;

@end
