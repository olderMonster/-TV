//
//  ZQGameLiveManager.h
//  战旗TV
//
//  Created by 印聪 on 2017/1/4.
//  Copyright © 2017年 monster. All rights reserved.
//

#import "CTAPIBaseManager.h"

@interface ZQGameLiveManager : CTAPIBaseManager<CTAPIManager,CTAPIManagerValidator>

@property (nonatomic , copy)NSString *channelId;

@end
