//
//  ZQRecommendController.h
//  战旗TV
//
//  Created by 印聪 on 2017/1/4.
//  Copyright © 2017年 monster. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZQSubsRecommendControllerDelegate <NSObject>

- (void)recommendLiving:(NSDictionary *)roomInfo;

@end

@interface ZQSubsRecommendController : UIViewController

@property (nonatomic , weak)id<ZQSubsRecommendControllerDelegate>delegate;

@end
