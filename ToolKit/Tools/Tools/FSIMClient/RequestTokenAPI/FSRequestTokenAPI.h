//
//  FSRequestTokenAPI.h
//  Lolly
//
//  Created by stu on 2017/11/3.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FSBaseTokenParam.h"
#import "FSRequestTokenResult.h"

@protocol FSRequestTokenAPIDelegate<NSObject>

- (void)fsRequestTokenAPISuccess:(FSRequestTokenResult *)result;

- (void)fsRequestTokenAPIFailed:(NSError *)error;

@end

@interface FSRequestTokenAPI : NSObject<FSBaseAPIDelegate>

@property (nonatomic, weak) id<FSRequestTokenAPIDelegate> delegate;

-(void)requestIMToken:(NSString*)url;

@end
