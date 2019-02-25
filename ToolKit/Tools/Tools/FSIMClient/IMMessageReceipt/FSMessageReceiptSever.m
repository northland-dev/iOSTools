//
//  FSMessageReceiptSever.m
//  Lolly
//
//  Created by Charles on 2017/12/26.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import "FSMessageReceiptSever.h"
#import "FSMessageReceiptApi.h"

@implementation FSMessageReceiptSever
-(void)messageReceipetWithMessageId:(NSString *)messageId {
    FSMessageReceiptApi *api = [[FSMessageReceiptApi alloc] init];
    [api messageReceiptWithMsgId:messageId];
}
@end
