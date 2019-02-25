//
//  NSString+Util.m
//  FSPurchase
//
//  Created by Charles on 2017/11/2.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import "NSString+Util.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Util)
- (NSString *)md5Value {
    const char *cStr = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5 (cStr, (unsigned int)strlen (cStr), digest);
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0 ; i < CC_MD5_DIGEST_LENGTH ; i++){
        [result appendFormat : @"%02x" , digest[i]];
    }
    return result;
}
@end
