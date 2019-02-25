//
//  FSToasManager.h
//  Ready
//
//  Created by jiapeng on 2018/9/4.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FFToast.h"

@interface FSToasManager : NSObject
+ (instancetype) sharedManager;
-(void)showToastWithTitle:(NSString *)titleString message:(NSString *)messageString;
-(void)showToastWithTitle:(NSString *)titleString message:(NSString *)messageString position:(FFToastPosition)Position;
@end
