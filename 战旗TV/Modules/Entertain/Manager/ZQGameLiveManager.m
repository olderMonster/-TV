//
//  ZQGameLiveManager.m
//  战旗TV
//
//  Created by 印聪 on 2017/1/4.
//  Copyright © 2017年 monster. All rights reserved.
//

#import "ZQGameLiveManager.h"

@interface ZQGameLiveManager()

@property (nonatomic , assign)NSInteger page;
@property (nonatomic , assign)NSInteger pageSize;


@end


@implementation ZQGameLiveManager

- (instancetype)init{
    self = [super init];
    if (self) {
        
        self.page = 1;
        self.pageSize = 20;
        
        self.validator = self;
    }
    return self;
}


- (NSString *)methodName{
    return [NSString stringWithFormat:@"game/live/%@/%ld/%ld.json",self.channelId,self.pageSize,self.page];
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
