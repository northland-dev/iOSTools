//
//  FSImageEditController.m
//  Lolly
//
//  Created by Charles on 2017/11/4.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import "FSImageEditController.h"
#import "UIImage+Crop.h"
#import "UIImage+Rotate.h"

@interface FSImageEditController ()<UIScrollViewDelegate>
{
    CGFloat _zoomScale;
    UIImage *_rotatedImage;
}
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UIScrollView *contentView;
@property(nonatomic,strong)UIView *topBack;
@property(nonatomic,strong)UIView *mediumBack;
@property(nonatomic,strong)UIView *bottomBack;
@property(nonatomic,strong)UILabel *tipLabel;

@end

@implementation FSImageEditController

#pragma mark - property init
- (UIScrollView *)contentView {
    if (!_contentView) {
        _contentView = [[UIScrollView alloc] init];
        [_contentView setShowsVerticalScrollIndicator:NO];
        [_contentView setShowsHorizontalScrollIndicator:NO];
        [_contentView setMinimumZoomScale:1.0];
        [_contentView setMaximumZoomScale:5.0];
        [_contentView setBouncesZoom:YES];
        [_contentView setDelegate:self];
        [_contentView setClipsToBounds:NO];
        [self.view addSubview:_contentView];
    }
    return _contentView;
}

#pragma mark - property init
- (UILabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] init];
        [_tipLabel setTextAlignment:(NSTextAlignmentCenter)];
        [_tipLabel setTextColor:[UIColor whiteColor]];
        [_tipLabel setFont:[UIFont proximaFontOfSize:16.0]];
        [_tipLabel setText:[FSSharedLanguages CustomLocalizedStringWithKey:@"cropTip"]];
        [_tipLabel setBackgroundColor:[UIColor clearColor]];
        [self.view addSubview:_tipLabel];
    }
    return _tipLabel;
}

- (UIView *)topBack {
    if (!_topBack) {
         _topBack = [[UIView alloc] init];
        [_topBack setBackgroundColor:HexRGBAlpha(0x000000, 0.4)];
        [_topBack setUserInteractionEnabled:NO];
        [self.view addSubview:_topBack];
    }
    return _topBack;
}

- (UIView *)mediumBack {
    if (!_mediumBack) {
         _mediumBack = [[UIView alloc] init];
        [_mediumBack setBackgroundColor:[UIColor clearColor]];
        [_mediumBack.layer setBorderColor:HexRGBAlpha(0xffffff, 0.8).CGColor];
        [_mediumBack.layer setBorderWidth:1.0];
        [_mediumBack setUserInteractionEnabled:NO];
        [self.view addSubview:_mediumBack];

    }
    return _mediumBack;
}

- (UIView *)bottomBack {
    if (!_bottomBack) {
         _bottomBack = [[UIView alloc] init];
        [_bottomBack setBackgroundColor:HexRGBAlpha(0x000000, 0.4)];
        [_bottomBack setUserInteractionEnabled:NO];
        [self.view addSubview:_bottomBack];
    }
    return _bottomBack;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithImage:_image];
        [_imageView setContentMode:(UIViewContentModeScaleAspectFit)];
    }
    return _imageView;
}

- (void)setImage:(UIImage *)image {
    _image = image;
    [self.imageView setImage:image];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.contentView addSubview:self.imageView];
    [self.view setBackgroundColor:[UIColor blackColor]];

    _zoomScale = 1.0;
    CGSize imageSize = self.image.size;
    CGFloat scale = MIN(CGRectGetWidth(self.view.bounds)/imageSize.width, CGRectGetHeight(self.view.bounds)/imageSize.height);
    CGSize scaledSize = CGSizeMake(floorf(imageSize.width*scale), floorf(imageSize.height*scale));
    
    WS(weakS);
    
//    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(weakS.view.mas_centerX);
//        make.centerY.equalTo(weakS.view.mas_centerY);
//        make.width.mas_equalTo(weakS.view.mas_width);
//        make.height.mas_equalTo(weakS.view.mas_width);
//    }];
    
    /**
     *  此处不能使用自动布局 使用自动布局 影响scrollview的 contentSize;
     *  直接修改frame;
     *  为什么不能用还需要调查
     **/
    CGFloat insetY = (scaledSize.height - CGRectGetWidth(self.view.frame))/2.0;
    [self.contentView setFrame:CGRectMake(0, (CGRectGetHeight(self.view.bounds) - CGRectGetWidth(self.view.bounds))/2.0, CGRectGetWidth(self.view.bounds), CGRectGetWidth(self.view.bounds))];
    [self.contentView setContentSize:scaledSize];
    [self.contentView setContentOffset:CGPointMake(0, insetY)];

    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(scaledSize.width);
        make.height.mas_equalTo(scaledSize.height);
        make.top.equalTo(weakS.contentView.mas_top);
        make.left.equalTo(weakS.contentView.mas_left);
    }];
    
    
    [self.mediumBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakS.view.mas_centerX);
        make.centerY.equalTo(weakS.view.mas_centerY);
        make.width.mas_equalTo(weakS.view.mas_width);
        make.height.mas_equalTo(weakS.view.mas_width);
    }];
    
    [self.topBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakS.view.mas_left);
        make.right.equalTo(weakS.view.mas_right);
        make.top.equalTo(weakS.view.mas_top);
        make.bottom.equalTo(weakS.mediumBack.mas_top);
    }];
    
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakS.view.mas_left);
        make.right.equalTo(weakS.view.mas_right);
        make.bottom.equalTo(weakS.mediumBack.mas_top).with.offset(-35.0);
        make.height.mas_equalTo(20);
    }];
    
    [self.bottomBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakS.view.mas_left);
        make.right.equalTo(weakS.view.mas_right);
        make.top.equalTo(weakS.mediumBack.mas_bottom);
        make.bottom.equalTo(weakS.view.mas_bottom);
    }];
}

#pragma mark - public function
// 源图
- (UIImage *)sourceImage {
    /*     */
    UIImageOrientation orientaition = [self.image imageOrientation];
    CGSize imageSize = CGSizeMake(CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds));
    if(UIImageOrientationUp != orientaition){
        _rotatedImage = [UIImage image:self.image rotation:orientaition];
        return _rotatedImage;
    }
    return self.image;
}

// 调整之后的切图
- (UIImage *)cropedImage {
//    return self.image;
    /*  */
    CGRect rect = [self croppedImageFrame];
//    CGSize size = CGSizeMake(CGRectGetWidth(self.view.bounds), CGRectGetWidth(self.view.bounds));
    CGSize size = CGSizeMake(500, 500);
    UIImage *image = [self.image cropImageWithRect:rect szie:size];
    return image;
   
}
/***
 *   获取固定大小的某个区域的图片
 *   通过获取当前区域在图片上的相对位置 来截取图片
 *   1.计算x,y
 *   2.通过scale 计算对应的值
 *
 *   公式:  裁剪框的位置 通过 - (CGRect)convertRect:(CGRect)rect toView:(nullable UIView *)view;
 *         获得
 *
 *
 ***/
- (CGRect)croppedImageFrame {
    
    CGSize imageSize = self.image.size;
    // 当前的contentSize;
    CGSize contentSize = self.contentView.contentSize;
    // 当前的offset
    CGPoint contentOffset = self.contentView.contentOffset;
    // 当前比例
    CGRect frame = CGRectZero;
    CGFloat widthScale = imageSize.width/contentSize.width;
    CGFloat heightScale = imageSize.height/contentSize.height;

    frame.origin.x = MAX(floorf(contentOffset.x * widthScale),0);
    frame.origin.y = MAX(floorf(contentOffset.y * heightScale),0);
    // 固定大小可以直接计算
    // width
    CGFloat shouldBeWidth = imageSize.width * (CGRectGetWidth(self.mediumBack.frame)/contentSize.width);
    // height
    CGFloat shouldBeHeight = imageSize.height * (CGRectGetHeight(self.mediumBack.frame)/contentSize.height);
    frame.size.width = MIN(imageSize.width,shouldBeWidth);
    frame.size.height = MIN(imageSize.height,shouldBeHeight);
    return frame;
}
#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}
@end
