//
//  FSErrorCodeTransfer.m
//  7nujoom
//
//  Created by luyee on 2018/7/23.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "FSErrorCodeTransfer.h"
#import "FSAlert.h"

static NSDictionary *_transPrefixDic = nil;

@interface FSErrorCodeTransfer ()

- (NSString * (^)(NSInteger))transferCode;

@end

@implementation FSErrorCodeTransfer

+ (void (^) (NSInteger code))tansferErrorCode{
    return ^(NSInteger code){
        [[[FSErrorCodeTransfer alloc] init] initWithCode:code];
    };
}

- (void)initWithCode:(NSInteger)code
{
    [[FSToasManager sharedManager] showToastWithTitle:nil message:self.transferCode( code)];
    [FSAlert showMessage:self.transferCode(code)];
//    [[[FSNewe stAlertView alloc]init] showViewWithMessage:self.transferCode(code) titleType:FSNewestAlertViewType_Failed];
    
}

- (NSDictionary *)transPrefixDic{    // 把相关前缀加在这个数组里
    if (!_transPrefixDic) {
        _transPrefixDic = @{
                            @"connectMicErrorCode":@"1",
                            };
    }
    return _transPrefixDic;
}

- (NSString * (^)(NSInteger))transferCode{
    return ^(NSInteger code){
        NSString *codeString = [NSNumber numberWithInteger:code].stringValue;
        NSString *codeValue = [self.transPrefixDic valueForKey:codeString];
        if (codeValue && codeValue.length) {
            return locStrBy(codeValue);
        }
        return @"";
    };
}



@end
