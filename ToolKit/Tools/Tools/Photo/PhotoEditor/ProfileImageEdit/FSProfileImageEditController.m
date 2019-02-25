//
//  FSProfileImageEditController.m
//  Lolly
//
//  Created by Charles on 2017/11/13.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import "FSProfileImageEditController.h"

@interface FSProfileImageEditController ()

@end

@implementation FSProfileImageEditController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.uploadTitle = [FSSharedLanguages CustomLocalizedStringWithKey:@"Upload"];
    [self.upLoadButton setTitle:self.uploadTitle forState:(UIControlStateNormal)];
}
- (void)clickUpload {
    [RyzeMagicStatics ryze_addEventName:@"DataSta_Click_PhotoEditPage_Send" withParams:nil];
    if (self.price > 0) {
        // 检测
        NSInteger purchaseCount = 0.0;
//        for (FSPhotoModel *photoModel in self.photoModels) {
//            if (photoModel.price != 0) {
//                purchaseCount ++;
//
//                if (purchaseCount >= 3) {
//                    break;
//                }
//            }
//        }
        if (purchaseCount >= 3) {
            [self showAlertWithMessage:[FSSharedLanguages CustomLocalizedStringWithKey:@"maxThreePhoto"]];
            return;
        }
        [RyzeMagicStatics ryze_addEventName:@"DataSta_Click_PhotoEditPage_SetPrice" withParams:nil];
    }
    [self.view showLoading];
    dispatch_async(dispatch_get_global_queue(0, 00), ^{
        
        UIImage *sorceImage = [self sourceImage];
        UIImage *cropedImage = [self cropedImage];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([self.profileDelegate respondsToSelector:@selector(profilePhotoEditController:sourceImage:thumbImage:price:)]) {
                [self.profileDelegate profilePhotoEditController:self sourceImage:sorceImage thumbImage:cropedImage price:self.price];
            }
        });
    });
}

@end
