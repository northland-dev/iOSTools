//
//  FSCheckSystemPrivileges.h
//  7nujoom
//
//  Created by 王明 on 16/6/29.
//  Copyright © 2016年 Fission. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FSSystemPrivilegesHeader.h"

@interface FSCheckSystemPrivileges : NSObject

- (void)checkPrivileges:(CheckPermissionResult)result;
- (BOOL)checkLocationPrivilegesCheck;

@end
