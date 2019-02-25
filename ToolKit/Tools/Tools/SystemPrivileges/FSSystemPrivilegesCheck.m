//
//  FSSystemPrivilegesCheck.m
//  7nujoom
//
//  Created by 王明 on 16/6/22.
//  Copyright © 2016年 Fission. All rights reserved.
//

#import "FSSystemPrivilegesCheck.h"

@implementation FSSystemPrivilegesCheck

+ (FSSystemPrivilegesCheck *)sharedInstance {

    return [[FSSystemPrivilegesCheck alloc] init];
}

- (instancetype)init {
    static FSSystemPrivilegesCheck *manage = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if ((manage = [super init]) != nil) {
            NSLog(@"FSSystemPrivilegesCheck 只执行了一次");
        }
    });
    self = manage;
    return self;
}

- (void)checkSourceTypeAvailable:(FSSystemPrivilegesType)privilegesType result:(CheckPermissionResult)response {
    
    _privilegesFactory = [[FSSystemPrivilegesFactory alloc] init];
    _checkSystemPrivileges = [_privilegesFactory factoryMethod:privilegesType];
    [_checkSystemPrivileges checkPrivileges:^(BOOL granted) {
        if (response) {
            response(granted);
        }
    }];

}

- (void)checkSourceTypeArrayAvailable:(NSArray *)privilegesTypeArray result:(CheckPermissionResult)response {
    __block NSMutableArray *tempArray = [NSMutableArray arrayWithArray:privilegesTypeArray];
    [tempArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
     //   dispatch_async(queue, ^{
            [self checkSourceTypeAvailable:[obj integerValue] result:^(BOOL granted) {
                
                if (idx == [tempArray count] - 1) {
                    if (response) {
                        response(granted);
                    }
                }else
                {
                    if (!granted) {
                        if (response) {
                            response(NO);
                        }
                        *stop = YES;
                    }
                }
                dispatch_semaphore_signal(semaphore);
                
            }];
            //等待执行，不会占用资源
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            //dispatch_release(semaphore);

        //    });
    }];
}

- (BOOL)checkLocationPrivilegesCheck {
    
    _privilegesFactory = [[FSSystemPrivilegesFactory alloc] init];
    _checkSystemPrivileges = [_privilegesFactory factoryMethod:FSSystemPrivilegesTypeLocation];
    return [_checkSystemPrivileges checkLocationPrivilegesCheck];
}

- (void)requestLocationPrivileges {
    _privilegesFactory = [[FSSystemPrivilegesFactory alloc] init];
    _checkSystemPrivileges = [_privilegesFactory factoryMethod:FSSystemPrivilegesTypeLocation];
}

@end
