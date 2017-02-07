//
//  ZQGameBannerManager.m
//  战旗TV
//
//  Created by 印聪 on 2016/12/29.
//  Copyright © 2016年 monster. All rights reserved.
//

#import "ZQIndexBannerManager.h"

@implementation ZQIndexBannerManager

- (instancetype)init{
    self = [super init];
    if (self) {
        
        self.validator = self;
    }
    return self;
}


- (NSString *)methodName{
    return @"index/banner.json";
}

- (CTAPIManagerRequestType)requestType{
    return CTAPIManagerRequestTypeGet;
}

- (NSString *)serviceType{
    return kZQServiceApisZQ;
}


- (NSDictionary *)reformParams:(NSDictionary *)params{
    return @{@"rand":@"1455848328344"};
}

#pragma mark -- CTAPIManagerValidator
- (BOOL)manager:(CTAPIBaseManager *)manager isCorrectWithCallBackData:(NSDictionary *)data{
    return YES;
}

- (BOOL)manager:(CTAPIBaseManager *)manager isCorrectWithParamsData:(NSDictionary *)data{
    return YES;
}

@end
