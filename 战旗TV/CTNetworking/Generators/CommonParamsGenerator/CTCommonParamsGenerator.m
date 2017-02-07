//
//  AXPublicURLParamsGenerator.m
//  RTNetworking
//
//  Created by casa on 14-5-6.
//  Copyright (c) 2014年 casatwy. All rights reserved.
//

#import "CTCommonParamsGenerator.h"
#import "CTAppContext.h"
#import "NSDictionary+AXNetworkingMethods.h"

@implementation CTCommonParamsGenerator

+ (NSDictionary *)commonParamsDictionary
{
    return @{
             @"os":@"1",
             @"ver":@"3.2.5"
             };
}

+ (NSDictionary *)commonParamsDictionaryForLog
{
    return @{
             @"os":@"1",
             @"ver":@"3.2.5"
             };
}

@end
