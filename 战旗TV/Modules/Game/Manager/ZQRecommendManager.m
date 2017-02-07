//
//  ZQRecommendManager.m
//  战旗TV
//
//  Created by 印聪 on 2016/12/29.
//  Copyright © 2016年 monster. All rights reserved.
//

#import "ZQRecommendManager.h"

@implementation ZQRecommendManager

- (instancetype)init{
    self = [super init];
    if (self) {
        
        self.validator = self;
    }
    return self;
}


- (NSString *)methodName{
    return @"live/index/recommend.json";
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
