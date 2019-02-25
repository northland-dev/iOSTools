//
//  FSUploadThumbAPI.h
//  Lolly
//
//  Created by Charles on 2017/11/6.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol FSUploadThumbAPIAPIDelegate <NSObject>

- (void)FSUploadThumbAPISuccess:(NSString *)filePath;
- (void)FSUploadThumbAPIFaild:(NSError *)error;
- (void)FSUploadThumbAPIProgress:(float)progress;
@end
@interface FSUploadThumbAPI : NSObject
@property (nonatomic, weak) id<FSUploadThumbAPIAPIDelegate> delegate;

- (void)uploadThumbImage:(id)param;

@end
