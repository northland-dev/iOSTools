//
//  FSMessageImageEditController.m
//  Lolly
//
//  Created by Charles on 2017/11/4.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import "FSMessageImageEditController.h"
#import "UIColor+Image.h"

@interface FSMessageImageEditController ()
{
    NSInteger _currentPrice;
}
@property(nonatomic,strong)UILabel *priceLabel;
@property(nonatomic,strong)UILabel *moneyLabel;
@property(nonatomic,strong)UISlider *slider;
@end

@implementation FSMessageImageEditController
#pragma mark - property init

- (UISlider *)slider {
    if (!_slider) {
         _slider = [[UISlider alloc] init];
         _slider.minimumValue = 0.0;
         _slider.maximumValue = 100.0;
        [_slider setMaximumTrackTintColor:HexRGB(0xffffff)];
        [_slider setMinimumTrackTintColor:HexRGB(0xAbabab)];
        
        UIImage *sliderImage = [self sliderThumbImage];
        [_slider setThumbImage:sliderImage forState:(UIControlStateNormal)];
        [_slider setThumbImage:sliderImage forState:(UIControlStateHighlighted)];
        
        [_slider setContinuous:YES];
        [_slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:(UIControlEventValueChanged)];
        
        [self.view addSubview:_slider];
    }
    return _slider;
}

- (void)sliderValueChanged:(id)sender{
    float value = floorf(_slider.value);
    NSString *text = [NSString stringWithFormat:@"%.0f %@",value,[FSSharedLanguages CustomLocalizedStringWithKey:@"coins"]];
    [self.moneyLabel setText:text];
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] init];
        [_priceLabel setTextAlignment:(NSTextAlignmentLeft)];
        [_priceLabel setTextColor:HexRGBAlpha(0xffffff, 1.0)];
        [_priceLabel setFont:[UIFont systemFontOfSize:16.0]];
        [_priceLabel setText:[FSSharedLanguages CustomLocalizedStringWithKey:@"selectPrice"]];
        [self.view addSubview:_priceLabel];
    }
    return _priceLabel;
}
- (UILabel *)moneyLabel {
    if (!_moneyLabel) {
         _moneyLabel = [[UILabel alloc] init];
        [_moneyLabel setTextAlignment:(NSTextAlignmentRight)];
        [_moneyLabel setTextColor:HexRGBAlpha(0xAbabab, 1.0)];
        [_moneyLabel setFont:[UIFont systemFontOfSize:16.0]];
        [_moneyLabel setText:[NSString stringWithFormat:@"0 %@",[FSSharedLanguages CustomLocalizedStringWithKey:@"coins"]]];
        [self.view addSubview:_moneyLabel];
    }
    return _moneyLabel;
}
- (void)viewDidLoad {
    // 设置标题
    [super viewDidLoad];

    _currentPrice = 0;
    // Do any additional setup after loading the view.
    WS(weakS);
    
    if (!_hideSlider) {
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakS.mediumBack.mas_left).with.offset(24);
            make.top.equalTo(weakS.mediumBack.mas_bottom).with.offset(25);
            make.height.mas_equalTo(19.0);
        }];
        
        [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakS.mediumBack.mas_right).with.offset(-24);
            make.top.equalTo(weakS.mediumBack.mas_bottom).with.offset(25);
            make.height.mas_equalTo(19.0);
        }];
        
        [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakS.view.mas_left).with.offset(34);
            make.right.equalTo(weakS.view.mas_right).with.offset(-34);
            make.top.equalTo(weakS.moneyLabel.mas_bottom).with.offset(13);
        }];
    }
    
    self.uploadTitle = [FSSharedLanguages CustomLocalizedStringWithKey:@"Send"];
    [self.upLoadButton setTitle:self.uploadTitle forState:(UIControlStateNormal)];
}

- (UIImage *)sliderThumbImage{
    CGRect imageFrame = CGRectMake(0, 0, 20, 20);
    UIColor *color = HexRGBAlpha(0xAbabab, 1.0);
    return [color colorImageWithRect:imageFrame];
}

- (NSInteger)price {
    _price = floorf(_slider.value);
    return _price;
}

- (void)clickUpload {
    
    [RyzeMagicStatics ryze_addEventName:@"DataSta_Click_PhotoEditPage_Send" withParams:nil];

    [self showLoading];
    
    if(!_hideSlider){
        _currentPrice = self.price;
    }else {
        _currentPrice = 0;
    }
    
    // 统计
    if (_currentPrice > 0) {
        [RyzeMagicStatics ryze_addEventName:@"DataSta_Click_TakePhotoPage_SetPrice" withParams:nil];
    }
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        UIImage *sorceImage = [self sourceImage];
        UIImage *cropedImage = [self cropedImage];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([self.messageDelegate respondsToSelector:@selector(messagePhotoEditController:sourceImage:thumbImage:price:)]) {
                [self.messageDelegate messagePhotoEditController:self sourceImage:sorceImage thumbImage:cropedImage price:_currentPrice];
            }
        });
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
