//
//  ZQRankTopThreeCell.h
//  战旗TV
//
//  Created by 印聪 on 2017/1/5.
//  Copyright © 2017年 monster. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZQRankNormalCell.h"

@interface ZQRankTopThreeCell : UICollectionViewCell

@property (nonatomic , assign)ZQRankNormalCellUserType userType;
@property (nonatomic , strong)NSIndexPath *indexPath;
@property (nonatomic , strong)NSDictionary *user;

@end
