//
//  NSString+URL.m
//  7nujoom
//
//  Created by xu on 2018/6/12.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "NSString+URL.h"

@implementation NSString (URL)

+ (NSString *)stringFormatResourceURL:(NSString *)string{
    if([string hasPrefix:@"http://"] || [string hasPrefix:@"https://"]){
        
    }else{
//        string = [NSString stringWithFormat:@"%@%@",URL_IP_RESOURCE,string];
    }
    return string;
}
@end
