//
//  ApisZQService.m
//  战旗TV
//
//  Created by 印聪 on 2016/12/28.
//  Copyright © 2016年 monster. All rights reserved.
//

#import "ApisZQService.h"
#import "CTAppContext.h"
@implementation ApisZQService

#pragma mark - CTServiceProtocal
- (BOOL)isOnline
{
    return [CTAppContext sharedInstance].isOnline;
}

- (NSString *)offlineApiBaseUrl
{
    return @"http://apis.zhanqi.tv/static";
}

- (NSString *)onlineApiBaseUrl
{
    return @"http://apis.zhanqi.tv/static";
}

- (NSString *)offlineApiVersion
{
    return @"v2.1";
}

- (NSString *)onlineApiVersion
{
    return @"v2.1";
}

- (NSString *)onlinePublicKey
{
    return @"";
}

- (NSString *)offlinePublicKey
{
    return @"";
}

- (NSString *)onlinePrivateKey
{
    return @"";
}

- (NSString *)offlinePrivateKey
{
    return @"";
}

@end
