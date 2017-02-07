//
//  ZQBaiBianZhuBoManager.m
//  战旗TV
//
//  Created by 印聪 on 2017/1/3.
//  Copyright © 2017年 monster. All rights reserved.
//

#import "ZQBaiBianZhuBoManager.h"

@implementation ZQBaiBianZhuBoManager

- (instancetype)init{
    self = [super init];
    if (self) {
        
        self.validator = self;
    }
    return self;
}


- (NSString *)methodName{
    return @"gamer/banner.json";
}

- (CTAPIManagerRequestType)requestType{
    return CTAPIManagerRequestTypeGet;
}

- (NSString *)serviceType{
    return kZQServiceApisZQ;
}


- (BOOL)shouldCache{
    return NO;
}

#pragma mark -- CTAPIManagerValidator
- (BOOL)manager:(CTAPIBaseManager *)manager isCorrectWithCallBackData:(NSDictionary *)data{
    return YES;
}

- (BOOL)manager:(CTAPIBaseManager *)manager isCorrectWithParamsData:(NSDictionary *)data{
    return YES;
}


@end
