//
//  ZQAnchorController.h
//  战旗TV
//
//  Created by 印聪 on 2017/1/9.
//  Copyright © 2017年 monster. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZQAnchorController : UIViewController

/*
 * 直播间id
 * 根据直播间信息可以去到主播id(uid)，然后拿着uid去请求主播信息或者主播的视频
 */
@property (nonatomic , copy)NSString *anchorId;
@property (nonatomic , copy)NSString *roomId;
@end
