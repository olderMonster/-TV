//
//  NSString+AXNetworkingMethods.m
//  RTNetworking
//
//  Created by casa on 14-5-6.
//  Copyright (c) 2014年 casatwy. All rights reserved.
//

#import "NSString+AXNetworkingMethods.h"
#include <CommonCrypto/CommonDigest.h>
#import "NSObject+AXNetworkingMethods.h"

@implementation NSString (AXNetworkingMethods)

- (NSString *)AX_md5
{
	NSData* inputData = [self dataUsingEncoding:NSUTF8StringEncoding];
	unsigned char outputData[CC_MD5_DIGEST_LENGTH];
	CC_MD5([inputData bytes], (unsigned int)[inputData length], outputData);
	
	NSMutableString* hashStr = [NSMutableString string];
	int i = 0;
	for (i = 0; i < CC_MD5_DIGEST_LENGTH; ++i)
		[hashStr appendFormat:@"%02x", outputData[i]];
	
	return hashStr;
}


- (NSString *)httpsToHttp{
    if (self.length > 5){
        NSString *webSite = [self substringToIndex:5];
        if ([webSite isEqualToString:@"https"]){
            NSString *str = [self substringFromIndex:5];
            NSString *httpStr = [NSString stringWithFormat:@"http%@",str];
            return httpStr;
        }
    }
    return self;
}

@end
