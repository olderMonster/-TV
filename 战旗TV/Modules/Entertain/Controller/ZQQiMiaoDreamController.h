//
//  ZQQiMiaoDreamController.h
//  战旗TV
//
//  Created by 印聪 on 2017/1/4.
//  Copyright © 2017年 monster. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  ZQQiMiaoDreamControllerDelegate <NSObject>

- (void)qiMiaoMengGongChangLiving:(NSArray *)rooms index:(NSInteger)index;

@end

@interface ZQQiMiaoDreamController : UIViewController

@property (nonatomic , weak)id<ZQQiMiaoDreamControllerDelegate>delegate;

@end
