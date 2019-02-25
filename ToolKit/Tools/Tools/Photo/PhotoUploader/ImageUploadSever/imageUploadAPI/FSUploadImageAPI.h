//
//  FSUploadImageAPI.h
//  FSVideoEditor
//
//  Created by 王明 on 2017/7/20.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FSUploadImageAPIDelegate <NSObject>

- (void)FSUploadImageAPISuccess:(NSString *)filePath;
- (void)FSUploadImageAPIFaild:(NSError *)error;
- (void)FSUploadImageAPIProgress:(float)progress;
@end

@interface FSUploadImageAPI : NSObject

@property (nonatomic, weak) id<FSUploadImageAPIDelegate> delegate;

- (void)uploadFirstImage:(id)param;

@end
