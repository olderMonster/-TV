//
//  ZQEntainmentLiveCell.h
//  战旗TV
//
//  Created by 印聪 on 2017/1/12.
//  Copyright © 2017年 monster. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger , ZQEntainmentLiveCellType) {
    ZQEntainmentLiveCellTypeBaiBianZhuBo = 0,
    ZQEntainmentLiveCellTypeDaRenMeiPai = 1
};

@protocol ZQEntainmentLiveCellDelgate <NSObject>

- (void)closeLiving;

@end

@interface ZQEntainmentLiveCell : UICollectionViewCell

@property (nonatomic , copy)NSString *videoId;
@property (nonatomic , strong)NSArray *anchors;
@property (nonatomic , strong)NSDictionary *anchor;
@property (nonatomic , weak)id<ZQEntainmentLiveCellDelgate>delegate;
@property (nonatomic , assign)ZQEntainmentLiveCellType type;

@end
