//
//  FSUploadThumbSever.h
//  Lolly
//
//  Created by Charles on 2017/11/6.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FSUploadThumbSeverDelegate <NSObject>

- (void)FSUploadThumbSeverSucceed:(NSString *)filePath;
- (void)FSUploadThumbSeverFailed:(NSError *)error;
- (void)FSUploadThumbSeverProgress:(float)progess;
@end
@interface FSUploadThumbSever : NSObject
@property (nonatomic, weak) id<FSUploadThumbSeverDelegate> delegate;
- (void)uploadThumbImage:(id)param;

@end
