//
//  FSRyzeUploader.m
//  Ready
//
//  Created by mac on 2018/7/17.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "FSRyzeUploader.h"
#import <AFNetworking/AFNetworking.h>
#import "NSString+GC.h"

@implementation FSRyzeUploader
- (void)ryze_uploadData:(NSData *)data enableGizp:(BOOL)enableGzip successBlock:(RyzeSuccessBlock)success faildBlock:(RyzeFaildBlock)faild {
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    NSString *url = [[FSGlobalLauncher launcher].allKeyDict stringForKey:Key_app_batch_record];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSLocale *local = [NSLocale currentLocale];
    NSString *country = [local localeIdentifier];
    if(country != nil){
        [dict setValue:country forKey:@"country"];
    }
    NSString *os_name = [[UIDevice currentDevice] systemName];
    NSString *os_version = [[UIDevice currentDevice] systemVersion];
    if(os_name!=nil){
        [dict setValue:os_name forKey:@"osName"];
    }
    if(os_version!= nil){
        [dict setValue:os_version forKey:@"osVersion"];
    }
    NSString *model = [NSString deviceString];
    if(model != nil){
        [dict setValue:model forKey:@"dev"];
    }
    NSString *language = [[FSSharedLanguages SharedLanguage] language];
    [dict setValue:language forKey:@"language"];
    [dict setValue:@"0" forKey:@"promotionId"];
    if (enableGzip) {
        [dict setValue:data forKey:@"data"];
    }else{
        NSString *strdata = [data mj_JSONString];
        [dict setValue:strdata?:@"" forKey:@"data"];
    }

    [manager POST:url parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSHTTPURLResponse *urlResponse = (NSHTTPURLResponse *)task.response;
        if ([urlResponse statusCode] == 200) {
            if (success) {
                success();
            }
        }else{
            if (faild) {
                faild();
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (faild) {
            faild();
        }
    }];
}
@end
