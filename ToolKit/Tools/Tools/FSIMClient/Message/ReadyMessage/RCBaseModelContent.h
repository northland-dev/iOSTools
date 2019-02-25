//
//  RCBaseModelContent.h
//  Ready
//
//  Created by jiapeng on 2018/8/2.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCBaseModelContent : RCMessageContent

@property (nonatomic, strong) NSString *mExtern;
@property (nonatomic, assign) NSInteger fromUserId;
@property (nonatomic, assign) long st;
@property (nonatomic, strong) NSString *type;

- (NSDictionary *)willEncodeInfos;

@end
