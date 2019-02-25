//
//  FSBeautyCameraController.m
//  Lolly
//
//  Created by Charles on 2017/11/3.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import "FSBeautyCameraController.h"
#import "GPUImageBeautifyFilter.h"
#import "GPUImage.h"
#import "FSCameraBottom.h"
#import "FSImageEditController.h"



@interface FSBeautyCameraController ()<FSCameraBottomDelegate,GPUImageVideoCameraDelegate>
{
    BOOL _canStartWhenActive;
}
@property(nonatomic,strong)GPUImageOutput<GPUImageInput>  *filter;
@property(nonatomic,strong)GPUImageStillCamera *videoCamera;
@property(nonatomic,strong)GPUImageView *filterImageView;
@property(nonatomic,strong)FSCameraBottom *cameraBottom;
@end

@implementation FSBeautyCameraController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化 videoCamera
    self.videoCamera = [[GPUImageStillCamera alloc] initWithSessionPreset:AVCaptureSessionPresetHigh cameraPosition:AVCaptureDevicePositionFront];
    [self.videoCamera setDelegate:self];
    self.videoCamera.outputImageOrientation              = UIInterfaceOrientationPortrait;
    self.videoCamera.horizontallyMirrorFrontFacingCamera = YES;
    self.videoCamera.horizontallyMirrorRearFacingCamera  = NO;
    [self.videoCamera.captureSession setSessionPreset:AVCaptureSessionPresetHigh];
    
    // 初始化 filter
    self.filter = [[GPUImageBeautifyFilter alloc] init];
    // 添加美颜滤镜
    [self.videoCamera addTarget:self.filter];
    
    // 添加显示视图
    self.filterImageView = [[GPUImageView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.filterImageView];
    [self.filter addTarget:self.filterImageView];
    
     self.cameraBottom = [[FSCameraBottom alloc] init];
    [self.cameraBottom setDelegate:self];
    [self.view addSubview:self.cameraBottom];
    
    WS(weakS);
    
    [self.cameraBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakS.view.mas_bottom);
        make.left.equalTo(weakS.view.mas_left);
        make.right.equalTo(weakS.view.mas_right);
        make.height.mas_equalTo(@100);
    }];
    
    [self addNotification];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 开始进行相机捕获
    [self.videoCamera startCameraCapture];
    //  重设状态
    _canStartWhenActive = YES;
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    _canStartWhenActive = NO;
}
#pragma mark -
- (void)appResignActive:(NSNotification *)notification {
    if (_canStartWhenActive) {
        [self.videoCamera pauseCameraCapture];
        [self.videoCamera stopCameraCapture];
    }
}
- (void)appBecomeActive:(NSNotification *)notification {
    // 进入编辑页面时需要停用
    if (_canStartWhenActive) {
        [self.videoCamera resumeCameraCapture];
        [self.videoCamera startCameraCapture];
    }
}
#pragma mark - notification
- (void)addNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appResignActive:) name:UIApplicationWillResignActiveNotification object:nil];
}

- (void)removeNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillResignActiveNotification object:nil];
}

#pragma mark - FSCameraBottomDelegate
- (void)cameraBottomTouchShoot:(FSCameraBottom *)cameraBottom {
    WS(weakS);
    [self.videoCamera capturePhotoAsImageProcessedUpToFilter:self.filter withCompletionHandler:^(UIImage *processedImage, NSError *error) {
        if (error) {
            return ;
        }
        [weakS.videoCamera stopCameraCapture];
#pragma mark - 这里出现了crash 待修复
        if ([weakS.sourceDelegate respondsToSelector:@selector(imageSelectorSelectedImage:)]) {
            [weakS.sourceDelegate imageSelectorSelectedImage:processedImage];
        }
    }];
}
- (void)cameraBottomTouchCancle:(FSCameraBottom *)cameraBottom {
//    if ([self.videoCamera isRunning]) {
//    }
    [self.videoCamera stopCameraCapture];

    [self dismissViewControllerAnimated:YES completion:nil];
    [RyzeMagicStatics ryze_addEventName:@"DataSta_Click_TakePhotoPage_Cancel" withParams:nil];
}
- (void)cameraBottomTouchRotate:(FSCameraBottom *)cameraBottom {
    [self.videoCamera rotateCamera];
}

#pragma mark - dealloc
- (void)dealloc {
    
    [self removeNotification];
    NSLog(@"销毁了 beautyCameraController");
}
@end
