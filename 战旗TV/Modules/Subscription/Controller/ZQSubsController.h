//
//  ZQSubsController.h
//  战旗TV
//
//  Created by 印聪 on 2017/1/4.
//  Copyright © 2017年 monster. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZQSubsControllerDelegate <NSObject>

- (void)subscriptionLiving:(NSDictionary *)roomInfo;

@end

@interface ZQSubsController : UIViewController

@property (nonatomic , weak)id<ZQSubsControllerDelegate>delegate;

@end
