//
//  FSMessageReceiptApi.m
//  Lolly
//
//  Created by Charles on 2017/12/26.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import "FSMessageReceiptApi.h"
#import "FSBaseTokenParam.h"

@interface FSMsgReceiptParam : FSBaseTokenParam
@property(nonatomic,strong)NSString *msg_id;
@end
@implementation FSMsgReceiptParam
@end

@interface FSMessageReceiptApi()<FSBaseAPIDelegate>

@end
@implementation FSMessageReceiptApi
-(void)messageReceiptWithMsgId:(NSString *)messageId{
    if (!messageId || messageId.length == 0) {
        return;
    }
    FSMsgReceiptParam *param = [[FSMsgReceiptParam alloc] init];
    param.msg_id = messageId;
    
    NSString *queryStr = [param fs_queryString];
    NSString *host = [[FSGlobalLauncher launcher].allKeyDict stringForKey:key_con_msg_receipt];
    NSString *url = [NSString stringWithFormat:@"%@?%@", host, queryStr];
    FSBaseAPI *baseApi = [[FSBaseAPI alloc] init];
    baseApi.delegate = self;
    [baseApi postWithURL:url param:param result:[FSBaseResult class]];
}

#pragma mark - FSBaseAPIDelegate
- (void)baseAPISuccess:(FSBaseResult *)result {

}
- (void)baseAPIFailedWithCode:(NSInteger)code {

}

- (void)baseAPIFailed:(NSError *)error {
}
@end
