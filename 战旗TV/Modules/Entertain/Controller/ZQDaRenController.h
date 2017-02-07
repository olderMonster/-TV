//
//  ZQDaRenController.h
//  战旗TV
//
//  Created by 印聪 on 2017/1/3.
//  Copyright © 2017年 monster. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZQDaRenControllerDelegate <NSObject>

- (void)meiPaiDaRenLiving:(NSArray *)rooms index:(NSInteger)index;

@end

@interface ZQDaRenController : UIViewController

@property (nonatomic , weak)id<ZQDaRenControllerDelegate>delegate;

@end
