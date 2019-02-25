//
//  FSPhotoBrowserController.m
//  Lolly
//
//  Created by Charles on 2017/11/11.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import "FSPhotoBrowserController.h"

@interface FSPhotoBrowserController ()<UIScrollViewDelegate>
{
    BOOL _scaled;
}
@property(nonatomic,strong)UIScrollView *contentView;
@property(nonatomic,strong)UIView *editView;
@property(nonatomic,strong)UIButton *profileButton;
@property(nonatomic,strong)UIButton *deleteButton;
@end

@implementation FSPhotoBrowserController

- (UIView *)editView {
    if (!_editView) {
         _editView = [[UIView alloc] init];
        [_editView setBackgroundColor:HexRGBAlpha(0x000000,0.5)];
        [self.view addSubview:_editView];
    }
    return _editView;
}

- (UIButton *)profileButton {
    if (!_profileButton) {
        _profileButton = [[UIButton alloc] init];
        [_profileButton setTitle:[FSSharedLanguages CustomLocalizedStringWithKey:@"setHeader"] forState:(UIControlStateNormal)];
        [_profileButton.titleLabel setFont:[UIFont proximaFontOfSize:16.0]];
        [_profileButton setTitleColor:HexRGB(0xffffff) forState:(UIControlStateNormal)];
        [_profileButton addTarget:self action:@selector(makeCurrentImageAHeader:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.editView addSubview:_profileButton];
    }
    return _profileButton;
}

- (UIButton *)deleteButton {
    if (!_deleteButton) {
        _deleteButton = [[UIButton alloc] init];
        [_deleteButton setTitle:[FSSharedLanguages CustomLocalizedStringWithKey:@"delete"] forState:(UIControlStateNormal)];
        [_deleteButton.titleLabel setFont:[UIFont proximaFontOfSize:16.0]];
        [_deleteButton setTitleColor:HexRGB(0xffffff) forState:(UIControlStateNormal)];
        [_deleteButton addTarget:self action:@selector(deleteCurrentImage:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.editView addSubview:_deleteButton];
    }
    return _deleteButton;
}

- (UIScrollView *)contentView {
    if (!_contentView) {
         _contentView = [[UIScrollView alloc] init];
        [_contentView setDelegate:self];
        [_contentView setBounces:YES];
        [_contentView setMinimumZoomScale:1.0];
        [_contentView setMaximumZoomScale:3.0];
        [_contentView setZoomScale:1.0];
        [self.view addSubview:_contentView];
    }
    return _contentView;
}

- (UIImageView *)imageView {
    if (!_imageView) {
         _imageView = [[UIImageView alloc] init];
        [_imageView setContentMode:(UIViewContentModeScaleAspectFit)];
        [self.contentView addSubview:_imageView];
    }
    return _imageView;
}
#pragma mark - porperty
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        _allowsEditing = YES;
        _showSetHeaderButton = NO;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    [self.contentView setFrame:self.view.bounds];
    [self.imageView setFrame:self.contentView.bounds];
    [self.imageView setImage:_originalImage];

    if (_allowsEditing) {
        WS(weakS);
        [self.editView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakS.view.mas_left);
            make.bottom.equalTo(weakS.view.mas_bottom);
            make.right.equalTo(weakS.view.mas_right);
            make.height.mas_equalTo(70.0);
        }];
        
        if (_showSetHeaderButton) {
            [self.profileButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(weakS.editView.mas_left).with.offset(20);
                make.height.mas_equalTo(19.0);
                make.centerY.equalTo(weakS.editView.mas_centerY);
            }];
        }

        [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakS.editView.mas_right).with.offset(-20);
            make.height.mas_equalTo(19.0);
            make.centerY.equalTo(weakS.editView.mas_centerY);
        }];
    }
    
    [self addGesture];
    
    _scaled = NO;
}

#pragma mark -
- (void)setOriginalImage:(UIImage *)originalImage {
    _originalImage = originalImage;
}

#pragma mark - Gesture
- (void)addGesture {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapViewToDismiss:)];
    [self.view addGestureRecognizer:tapGesture];
    
    UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapViewToScale:)];
    [doubleTapGesture setNumberOfTapsRequired:2];
    [self.view addGestureRecognizer:doubleTapGesture];
    
    [tapGesture requireGestureRecognizerToFail:doubleTapGesture];
}

- (void)tapViewToScale:(UIGestureRecognizer *)gesture {
    if (!_scaled) {
        [self.contentView setZoomScale:2.0 animated:YES];
    }else {
        [self.contentView setZoomScale:1.0 animated:YES];
    }
    
    _scaled = !_scaled;
}

- (void)tapViewToDismiss:(UIGestureRecognizer *)gesture {
    if (_allowsEditing) {
        CGPoint touchPoint = [gesture locationInView:self.view];
        if (!CGRectContainsPoint(self.editView.frame, touchPoint)) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - EditViewFunctions
- (void)deleteCurrentImage:(UIButton *)button {
}

- (void)makeCurrentImageAHeader:(UIButton *)button {
}

#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}
- (UIModalTransitionStyle)modalTransitionStyle {
    return UIModalTransitionStyleCrossDissolve;
}
@end
