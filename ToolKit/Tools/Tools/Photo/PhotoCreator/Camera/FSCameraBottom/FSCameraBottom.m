//
//  FSCameraBottom.m
//  Lolly
//
//  Created by Charles on 2017/11/3.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import "FSCameraBottom.h"

@interface FSCameraBottom()

@property (nonatomic,strong) UIButton *cancleButton;
@property (nonatomic,strong) UIButton *shootButton;
@property (nonatomic,strong) UIButton *rotateButton;

@end
@implementation FSCameraBottom


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self setBackgroundColor:HexRGB(0x000000)];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    WS(weakS);

    [self.shootButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakS.mas_centerX);
        make.centerY.equalTo(weakS.mas_centerY);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(60);
    }];

    [self.cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakS.mas_left).with.offset(20);
        make.top.equalTo(weakS.mas_top).with.offset(40);
        make.bottom.equalTo(weakS.mas_bottom).with.offset(-40);
        make.right.equalTo(weakS.shootButton.mas_left).with.offset(0);
    }];

    [self.rotateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakS.mas_right).with.offset(-22);
        make.top.equalTo(weakS.mas_top).with.offset(39);
        make.height.mas_equalTo(24);
        make.width.mas_equalTo(29);
    }];
}

#pragma mark - property init
- (UIButton *)cancleButton {
    if (!_cancleButton) {
         _cancleButton = [[UIButton alloc] init];
        [_cancleButton setTitle:[FSSharedLanguages CustomLocalizedStringWithKey:@"PhotoCancel"] forState:(UIControlStateNormal)];
        [_cancleButton setContentHorizontalAlignment:(UIControlContentHorizontalAlignmentLeft)];
        [_cancleButton addTarget:self action:@selector(clickCancleButton) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:_cancleButton];
    }
    return _cancleButton;
}

- (UIButton *)shootButton {
    if (!_shootButton) {
        _shootButton = [[UIButton alloc] init];
        [_shootButton setImage:[UIImage imageNamed:@"photo_shoot"] forState:(UIControlStateNormal)];
        [_shootButton addTarget:self action:@selector(clickShootButton) forControlEvents:(UIControlEventTouchUpInside)];

        [self addSubview:_shootButton];
    }
    return _shootButton;
}

- (UIButton *)rotateButton {
    if (!_rotateButton) {
        _rotateButton = [[UIButton alloc] init];
        [_rotateButton setImage:[UIImage imageNamed:@"photo_rotate"] forState:(UIControlStateNormal)];
        [_rotateButton addTarget:self action:@selector(clickRotateButton) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:_rotateButton];
    }
    return _rotateButton;
}

- (void)clickCancleButton {
    if ([self.delegate respondsToSelector:@selector(cameraBottomTouchCancle:)]) {
        [self.delegate cameraBottomTouchCancle:self];
    }
}
- (void)clickShootButton {
    if ([self.delegate respondsToSelector:@selector(cameraBottomTouchShoot:)]) {
        [self.delegate cameraBottomTouchShoot:self];
    }
}
- (void)clickRotateButton {
    if ([self.delegate respondsToSelector:@selector(cameraBottomTouchRotate:)]) {
        [self.delegate cameraBottomTouchRotate:self];
    }
}

#pragma mark - dealloc
- (void)dealloc {
    NSLog(@"销毁了 cameraBottom");
}
@end
