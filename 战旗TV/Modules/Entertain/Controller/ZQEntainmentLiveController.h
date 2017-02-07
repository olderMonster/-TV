//
//  ZQEntainmentLiveController.h
//  战旗TV
//
//  Created by 印聪 on 2017/1/12.
//  Copyright © 2017年 monster. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZQEntainmentLiveCell.h"
@interface ZQEntainmentLiveController : UIViewController

@property (nonatomic , strong)NSArray *liveRooms;
@property (nonatomic , assign)NSInteger currentShowIndex;

@property (nonatomic , assign)ZQEntainmentLiveCellType cellType;

@end
