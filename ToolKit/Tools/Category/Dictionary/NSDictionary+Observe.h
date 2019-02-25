//
//  NSDictionary+Observe.h
//  Ready
//
//  Created by luyee on 2018/8/24.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FSObserveObj : NSObject

@property (nonatomic, strong) NSString *kind;
@property (nonatomic, strong) NSString *newly;
@property (nonatomic, strong) NSString *old;

@end

@interface NSDictionary (Observe)

- (FSObserveObj *)observeObj;

@end


