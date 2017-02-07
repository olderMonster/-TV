//
//  ZQRankNormalCell.h
//  战旗TV
//
//  Created by 印聪 on 2017/1/4.
//  Copyright © 2017年 monster. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger , ZQRankNormalCellUserType) {
    ZQRankNormalCellUserTypeAnchor,
    ZQRankNormalCellUserTypeConsume
};

@interface ZQRankNormalCell : UICollectionViewCell

@property (nonatomic , assign)ZQRankNormalCellUserType userType;
@property (nonatomic , strong)NSIndexPath *indexPath;
@property (nonatomic , strong)NSDictionary *user;

@end
