//
//  FSMessageReceiptApi.h
//  Lolly
//
//  Created by Charles on 2017/12/26.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FSMessageReceiptApiDelegate<NSObject>

@end
@interface FSMessageReceiptApi : NSObject
@property(nonatomic,assign)id <FSMessageReceiptApiDelegate>delegate;
-(void)messageReceiptWithMsgId:(NSString *)messageId;
@end
