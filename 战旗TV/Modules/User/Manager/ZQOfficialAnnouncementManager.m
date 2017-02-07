//
//  ZQOfficialAnnounceMentManager.m
//  战旗TV
//
//  Created by 印聪 on 2017/1/11.
//  Copyright © 2017年 monster. All rights reserved.
//

#import "ZQOfficialAnnouncementManager.h"

@interface ZQOfficialAnnouncementManager()

//可选
@property (nonatomic , assign)NSInteger page;
@property (nonatomic , assign)NSInteger pageSize;
@property (nonatomic , assign)NSInteger totalNoticeCount;

@end

@implementation ZQOfficialAnnouncementManager

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
    return [NSString stringWithFormat:@"news/list/%@/%ld/%ld.json",self.officialType,self.pageSize,self.page];
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

- (NSDictionary *)reformParams:(NSDictionary *)params{
    return @{@"page":@(self.page)};
}

- (BOOL)beforePerformSuccessWithResponse:(CTURLResponse *)response{
    
    if([response.content[@"code"] integerValue] == 0){
        self.totalNoticeCount = [response.content[@"data"][@"cnt"] integerValue];
        self.page ++;
    }
    
    return YES;
}

- (BOOL)beforePerformFailWithResponse:(CTURLResponse *)response{
    if (self.page > 0) {
        self.page --;
    }
    
    return YES;
}


#pragma mark -- CTAPIManagerValidator
- (BOOL)manager:(CTAPIBaseManager *)manager isCorrectWithCallBackData:(NSDictionary *)data{
    return YES;
}

- (BOOL)manager:(CTAPIBaseManager *)manager isCorrectWithParamsData:(NSDictionary *)data{
    return YES;
}

#pragma mark -- Public method
- (void)loadPage{
    self.page = 1;
    [self loadData];
}


- (void)loadNextPage{
    
    if (self.isLoading) {
        return;
    }
    
    NSInteger totalPage = ceil(self.totalNoticeCount / (float)self.pageSize);
    if (totalPage > 1 && self.page <= totalPage) {
        [self loadData];
    }else{
        [self afterCallingAPIWithParams:@{@"page":@(self.page)}];
    }
    
}

@end
