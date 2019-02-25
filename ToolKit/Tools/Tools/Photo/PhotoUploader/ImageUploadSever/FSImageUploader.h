//
//  FSimageUploader.h
//  FSVideoEditor
//
//  Created by Charles on 2017/9/8.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol FSImageUploaderDelegate <NSObject>

-(void)imageUploaderProgress:(CGFloat)progress;

-(void)imageUploaderSuccess:(NSString *)sourceUrl thumbUrl:(NSString *)thumUrl;

-(void)imageUploaderFaild;

@end

@interface FSImageUploaderParam : NSObject
@property(nonatomic,strong)NSData *sourceImageData;
@property(nonatomic,strong)NSData *thumbImageData;
@end


@interface FSImageUploader : NSObject
@property(nonatomic,assign)id<FSImageUploaderDelegate> delegate;
// 上传图片
-(void)uploadImage:(FSImageUploaderParam *)param;
@end
