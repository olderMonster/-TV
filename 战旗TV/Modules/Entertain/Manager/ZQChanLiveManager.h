//
//  ZQDaRenManager.h
//  战旗TV
//
//  Created by 印聪 on 2017/1/3.
//  Copyright © 2017年 monster. All rights reserved.
//

#import "CTAPIBaseManager.h"

@interface ZQChanLiveManager : CTAPIBaseManager<CTAPIManager,CTAPIManagerValidator>

//必传
@property (nonatomic , copy)NSString *channelId;

//可选
@property (nonatomic , assign)NSInteger page;
@property (nonatomic , assign)NSInteger pageSize;

@end
