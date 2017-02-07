//
//  ZQLiveRankManager.m
//  战旗TV
//
//  Created by 印聪 on 2017/1/10.
//  Copyright © 2017年 monster. All rights reserved.
//

#import "ZQLiveRankManager.h"

@implementation ZQLiveRankManager

- (instancetype)init{
    self = [super init];
    if (self) {
        self.validator = self;
    }
    return self;
}


- (NSString *)methodName{
    return [NSString stringWithFormat:@"room/fansweekrank/%@/10.json",self.roomId];
}

- (CTAPIManagerRequestType)requestType{
    return CTAPIManagerRequestTypeGet;
}

- (NSString *)serviceType{
    return kZQServiceApisZQ;
}


#pragma mark -- CTAPIManagerValidator
- (BOOL)manager:(CTAPIBaseManager *)manager isCorrectWithCallBackData:(NSDictionary *)data{
    return YES;
}

- (BOOL)manager:(CTAPIBaseManager *)manager isCorrectWithParamsData:(NSDictionary *)data{
    return YES;
}



@end
