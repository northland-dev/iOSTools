//
//  FSImagePickerController.m
//  Lolly
//
//  Created by Charles on 2017/11/4.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import "FSImagePickerController.h"
#import "FSImageEditController.h"

@interface FSImagePickerController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation FSImagePickerController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self setSourceType:(UIImagePickerControllerSourceTypeCamera)];
        [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:HexRGB(0x5C4406)}];
        [self.navigationBar setTintColor:HexRGB(0x5C4406)];
        [self setDelegate:self];
        [self setAllowsEditing:NO];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *sourceImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    if ([self.sourceDelegate respondsToSelector:@selector(imageSelectorSelectedImage:)]) {
        [self.sourceDelegate imageSelectorSelectedImage:sourceImage];
    }
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark -
- (void)dealloc {
    NSLog(@"销毁了照片选择器");
}


@end
