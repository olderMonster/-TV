//
//  ZQAnchorInfoManager.h
//  战旗TV
//
//  Created by 印聪 on 2017/1/9.
//  Copyright © 2017年 monster. All rights reserved.
//

#import "CTAPIBaseManager.h"

@interface ZQRoomInfoManager : CTAPIBaseManager<CTAPIManager,CTAPIManagerValidator>

@property (nonatomic , copy)NSString *roomId;

@end
