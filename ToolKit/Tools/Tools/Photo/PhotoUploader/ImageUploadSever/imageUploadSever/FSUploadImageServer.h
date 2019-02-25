//
//  FSUploadImageServer.h
//  FSVideoEditor
//
//  Created by 王明 on 2017/7/20.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FSUploadImageServerDelegate <NSObject>

- (void)FSUploadImageServerSucceed:(NSString *)filePath;
- (void)FSUploadImageServerFailed:(NSError *)error;
- (void)FSUploadImageServerProgress:(float)progess;
@end

@interface FSUploadImageServer : NSObject

@property (nonatomic, weak) id<FSUploadImageServerDelegate> delegate;

- (void)uploadFirstImage:(id)param;

@end
