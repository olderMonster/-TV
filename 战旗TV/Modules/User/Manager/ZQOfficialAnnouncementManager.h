//
//  ZQOfficialAnnounceMentManager.h
//  战旗TV
//
//  Created by 印聪 on 2017/1/11.
//  Copyright © 2017年 monster. All rights reserved.
//

#import "CTAPIBaseManager.h"

@interface ZQOfficialAnnouncementManager : CTAPIBaseManager<CTAPIManager,CTAPIManagerValidator>

@property (nonatomic , copy)NSString *officialType;

- (void)loadPage;
- (void)loadNextPage;

@end
