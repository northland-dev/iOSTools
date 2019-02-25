//
//  FSConfigAPI.h
//  Lolly
//
//  Created by jiapeng on 2017/11/7.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FSConfigParam.h"
#import "FSConfigResult.h"


@protocol FSConfigAPIDelegate <NSObject>
-(void)FSConfigAPISuccess:(FSConfigResult *)resultClass;
-(void)FSConfigAPIFailed:(NSError *)failure;
-(void)FSConfigAPICode:(NSInteger)reportCode;
@end

@interface FSConfigAPI : NSObject<FSBaseAPIDelegate>
@property (nonatomic, weak) id <FSConfigAPIDelegate> delegate;
-(void)requestWithParam:(FSConfigParam *)param;

@end
