//
//  ZQAnchorVideoManager.h
//  战旗TV
//
//  Created by 印聪 on 2017/1/9.
//  Copyright © 2017年 monster. All rights reserved.
//

#import "CTAPIBaseManager.h"

@interface ZQAnchorNewVideoManager : CTAPIBaseManager<CTAPIManager,CTAPIManagerValidator>

@property (nonatomic , copy)NSString *anchorId;

- (void)loadPage;
- (void)loadNextPage;

@end
