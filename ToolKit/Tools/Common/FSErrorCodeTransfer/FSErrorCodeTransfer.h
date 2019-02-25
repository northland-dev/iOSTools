//
//  FSErrorCodeTransfer.h
//  7nujoom
//
//  Created by luyee on 2018/7/23.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FSErrorCodeTransfer : NSObject

+ (void (^) (NSInteger code))tansferErrorCode;

@end
