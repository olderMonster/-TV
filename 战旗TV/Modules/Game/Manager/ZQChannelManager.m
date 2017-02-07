//
//  ZQChannelManager.m
//  战旗TV
//
//  Created by 印聪 on 2016/12/28.
//  Copyright © 2016年 monster. All rights reserved.
//

#import "ZQChannelManager.h"

@implementation ZQChannelManager

- (instancetype)init{
    self = [super init];
    if (self) {
        
        self.validator = self;
    }
    return self;
}


- (NSString *)methodName{
    return @"game.lists/app.json";
}

- (CTAPIManagerRequestType)requestType{
    return CTAPIManagerRequestTypeGet;
}

- (NSString *)serviceType{
    return kZQServiceApisZQ;
}


- (NSDictionary *)reformParams:(NSDictionary *)params{
    return @{};
}

#pragma mark -- CTAPIManagerValidator
- (BOOL)manager:(CTAPIBaseManager *)manager isCorrectWithCallBackData:(NSDictionary *)data{
    return YES;
}

- (BOOL)manager:(CTAPIBaseManager *)manager isCorrectWithParamsData:(NSDictionary *)data{
    return YES;
}

@end
