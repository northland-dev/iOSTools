//
//  FSCameraBottom.h
//  Lolly
//
//  Created by Charles on 2017/11/3.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FSCameraBottom;
@protocol FSCameraBottomDelegate<NSObject>

// 点击取消
- (void)cameraBottomTouchCancle:(FSCameraBottom *)cameraBottom;

// 点击拍照
- (void)cameraBottomTouchShoot:(FSCameraBottom *)cameraBottom;

// 点击翻转
- (void)cameraBottomTouchRotate:(FSCameraBottom *)cameraBottom;


@end

@interface FSCameraBottom : UIView

@property (nonatomic,assign)id<FSCameraBottomDelegate> delegate;

@end
