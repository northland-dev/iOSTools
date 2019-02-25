//
//  FSConfigSever.h
//  Lolly
//
//  Created by jiapeng on 2017/11/7.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FSConfigSeverDelegate <NSObject>
- (void)FSConfigSeverCallBack;
@end

@interface FSConfigSever : NSObject
@property (nonatomic, weak) id <FSConfigSeverDelegate> delegate;
+ (instancetype)shareServer;
- (void)requestTotalSumData;

@end
