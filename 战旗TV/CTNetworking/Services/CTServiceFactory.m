//
//  AXServiceFactory.m
//  RTNetworking
//
//  Created by casa on 14-5-12.
//  Copyright (c) 2014年 casatwy. All rights reserved.
//

#import "CTServiceFactory.h"
#import "CTService.h"

#import "GDMapService.h"
#import "ApisZQService.h"
#import "ZQNoneVerService.h"
/*************************************************************************/

// service name list
NSString * const kCTServiceGDMapV3 = @"kCTServiceGDMapV3";
NSString * const kZQServiceApisZQ = @"kZQServiceApisZQ";
NSString * const kZQServiceNoneVer = @"kZQServiceNoneVer";

@interface CTServiceFactory ()

@property (nonatomic, strong) NSMutableDictionary *serviceStorage;

@end

@implementation CTServiceFactory

#pragma mark - getters and setters
- (NSMutableDictionary *)serviceStorage
{
    if (_serviceStorage == nil) {
        _serviceStorage = [[NSMutableDictionary alloc] init];
    }
    return _serviceStorage;
}

#pragma mark - life cycle
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static CTServiceFactory *sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CTServiceFactory alloc] init];
    });
    return sharedInstance;
}

#pragma mark - public methods
- (CTService<CTServiceProtocol> *)serviceWithIdentifier:(NSString *)identifier
{
    if (self.serviceStorage[identifier] == nil) {
        self.serviceStorage[identifier] = [self newServiceWithIdentifier:identifier];
    }
    return self.serviceStorage[identifier];
}

#pragma mark - private methods
- (CTService<CTServiceProtocol> *)newServiceWithIdentifier:(NSString *)identifier
{
    if ([identifier isEqualToString:kCTServiceGDMapV3]) {
        return [[GDMapService alloc] init];
    }
    
    if ([identifier isEqualToString:kZQServiceApisZQ]){
        return [[ApisZQService alloc]init];
    }
    
    if ([identifier isEqualToString:kZQServiceNoneVer]){
        return [[ZQNoneVerService alloc]init];
    }

    return nil;
}

@end
