//
//  FSPhotoEditController.m
//  Lolly
//
//  Created by Charles on 2017/11/4.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import "FSPhotoEditController.h"
#import "UIFont+FSProxima.h"


@interface FSPhotoEditController ()
@property(nonatomic,strong)UIView *toolView;
@property(nonatomic,strong)UIButton *cancleButton;
@end

@implementation FSPhotoEditController

- (UIButton *)cancleButton {
    if (!_cancleButton) {
        _cancleButton = [[UIButton alloc] init];
        [_cancleButton setContentHorizontalAlignment:(UIControlContentHorizontalAlignmentLeft)];
        [_cancleButton.titleLabel setFont:[UIFont systemFontOfSize:16.0]];
        [_cancleButton.titleLabel setTextColor:HexRGBAlpha(0xffffff, 1.0)];
        [_cancleButton setTitle:[FSSharedLanguages CustomLocalizedStringWithKey:@"Cancel"] forState:(UIControlStateNormal)];
        [_cancleButton setBackgroundColor:[UIColor clearColor]];
        [_cancleButton addTarget:self action:@selector(clickCancle) forControlEvents:(UIControlEventTouchUpInside)];
        [self.view addSubview:_cancleButton];
    }
    return _cancleButton;
}

- (UIButton *)upLoadButton {
    if (!_upLoadButton) {
         _upLoadButton = [[UIButton alloc] init];
        [_upLoadButton setContentHorizontalAlignment:(UIControlContentHorizontalAlignmentRight)];
        [_upLoadButton setContentVerticalAlignment:(UIControlContentVerticalAlignmentBottom)];
        [_upLoadButton.titleLabel setFont:[UIFont systemFontOfSize:16.0]];
        [_upLoadButton.titleLabel setTextColor:HexRGBAlpha(0xffffff, 1.0)];
         _uploadTitle = [FSSharedLanguages CustomLocalizedStringWithKey:@"Upload"];
        [_upLoadButton setTitle:_uploadTitle forState:(UIControlStateNormal)];
        [_upLoadButton setBackgroundColor:[UIColor clearColor]];
        [_upLoadButton addTarget:self action:@selector(clickUpload) forControlEvents:(UIControlEventTouchUpInside)];
        [self.view addSubview:_upLoadButton];
    }
    return _upLoadButton;
}

- (void)setUploadTitle:(NSString *)uploadTitle {
    _uploadTitle = uploadTitle;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.uploadTitle = [FSSharedLanguages CustomLocalizedStringWithKey:@"Upload"];
    WS(weakS);
    
    [self.cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(30);
        make.left.equalTo(weakS.view.mas_left).with.offset(20);
        make.bottom.equalTo(weakS.view.mas_bottom).with.offset(-25);
    }];
    
    [self.upLoadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(30);
        make.right.equalTo(weakS.view.mas_right).with.offset(-20);
        make.bottom.equalTo(weakS.view.mas_bottom).with.offset(-25);
    }];
}

- (void)clickCancle {
    [RyzeMagicStatics ryze_addEventName:@"DataSta_Click_PhotoEditPage_Cancel" withParams:nil];

    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)clickUpload {
    
    NSLog(@"clickUpload");
    [RyzeMagicStatics ryze_addEventName:@"DataSta_Click_PhotoEditPage_Send" withParams:nil];
    [self showLoading];
    
    UIImage *sorceImage = nil;//[self sourceImage];
    UIImage *thumbImage = [self cropedImage];

//    if ([self.delegate respondsToSelector:@selector(photoEditController:thumbImage:)]) {
//        [self.delegate photoEditController:sorceImage thumbImage:thumbImage];
//    }
    
    if ([self.delegate respondsToSelector:@selector(photoEditController:sourceImage:thumbImage:)]) {
        [self.delegate photoEditController:self sourceImage:sorceImage thumbImage:thumbImage];
    }
}

#pragma mark -
- (void)showLoading {
    [self.view showLoading];
}
- (void)hideLoading {
    [self.view hideLoading];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    NSLog(@"%s dealloc",__FILE__);
}

@end
