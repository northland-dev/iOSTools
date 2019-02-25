//
//  FSPhotoSelector.m
//  Lolly
//
//  Created by Charles on 2017/11/4.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import "FSPhotoSelector.h"
#import "FSBeautyCameraController.h"
#import "FSImagePickerController.h"
#import "FSMessageImageEditController.h"
#import "FSProfileImageEditController.h"
#import "FSPhotoEditController.h"
#import "FSPhotoUploader.h"
#import "FSLoadingView.h"
#import "FSPhotoListSever.h"

@interface FSPhotoSelector()<FSImageSelectorDelegate,FSPhotoEditControllerDelegate,
FSMessageImageEditControllerDelegate,FSPhotoListSeverDelegate,FSProfileImageEditControllerDelegate>

@property(nonatomic,assign)id<FSPhotoSelectorDelegate> delegate;
@property(nonatomic,assign)UIViewController *photoCreator;
@property(nonatomic,assign)FSPhotoEditorType editorType;
@property(nonatomic,strong)FSPhotoUploader  *uploader;
@property(nonatomic,strong)FSPhotoListSever *photoListSever;
@property(nonatomic,strong)NSMutableArray *photoIds;
@end

@implementation FSPhotoSelector
+ (instancetype)photoSelectorWithEditType:(FSPhotoEditorType)editorType {
    FSPhotoSelector *selector = [[FSPhotoSelector alloc] init];
    selector.editorType = editorType;
    selector.uploader = [FSPhotoUploader defaultUploader];
    return selector;
}
-(void)showPhotoSelectorInController:(UIViewController<FSPhotoSelectorDelegate> *)controller
                        selectorType:(FSPhotoSelectorType)selectorType {
    if (selectorType == FSPhotoSelectorTypeNone) {
        return;
    }
    
    if (FSPhotoSelectorTypeCamera == selectorType) {
        FSBeautyCameraController *beautyCameraController = [[FSBeautyCameraController alloc] init];
        [beautyCameraController setSourceDelegate:self];
        [controller presentViewController:beautyCameraController animated:YES completion:nil];
        self.photoCreator = beautyCameraController;
    }else if (FSPhotoSelectorTypePhoto == selectorType){
        FSImagePickerController *imagePickerControler = [[FSImagePickerController alloc] init];
        [imagePickerControler setSourceDelegate:self];
        [controller presentViewController:imagePickerControler animated:YES completion:nil];
        self.photoCreator = imagePickerControler;
    }
    self.delegate = controller;
}

#pragma mark - FSImageSelectorDelegate
- (void)imageSelectorSelectedImage:(UIImage *)sourceImage {
    
    UIViewController *topController = self.photoCreator;
    
    if (self.editorType == FSPhotoEditorTypePhoto) {
        FSPhotoEditController *photoEditor = [[FSPhotoEditController alloc] init];
        [photoEditor setImage:sourceImage];
        [photoEditor setDelegate:self];
        [topController presentViewController:photoEditor animated:YES completion:nil];
    }else if (self.editorType == FSPhotoEditorTypeMessage){
        FSMessageImageEditController *messageEditor = [[FSMessageImageEditController alloc] init];
        [messageEditor setImage:sourceImage];
        [messageEditor setMessageDelegate:self];
        [topController presentViewController:messageEditor animated:YES completion:nil];
    }else if (self.editorType == FSphotoEditorTypeProfile){
        FSProfileImageEditController *profileEditor = [[FSProfileImageEditController alloc] init];
        [profileEditor setImage:sourceImage];
        [profileEditor setProfileDelegate:self];
        [profileEditor setPhotoModels:self.photoModels];
        if (self.userType == FSPhotoUserTypeGuest) {
            // 是用户
            profileEditor.hideSlider = YES;
        }else{
            profileEditor.hideSlider = NO;
        }
        
        [topController presentViewController:profileEditor animated:YES completion:nil];
    }
}
- (void)imageSelectorCilckCancel {
    
}
#pragma mark - FSPhotoEditProtocol
- (void)photoEditController:(UIViewController *)controller sourceImage:(UIImage *)sourceImage thumbImage:(UIImage *)thumbImage {

    WS(weakS);
    
    __weak typeof(controller) weakController = controller;
    [self.uploader photoUploader:sourceImage thumbImage:thumbImage successBlock:^(NSString *sourceUrl, NSString *thumbUrl,FSPhotoUploader *uploader) {
        
        if ([weakS.delegate respondsToSelector:@selector(photoSelectorSelectImage:thumbImage:)]) {
            [weakS.delegate photoSelectorSelectImage:sourceImage thumbImage:thumbImage];
        }
        
        if ([weakS.delegate respondsToSelector:@selector(photoSelectorUploaded:thumbUrl:)]) {
            [weakS.delegate photoSelectorUploaded:sourceUrl thumbUrl:thumbUrl];
        }
        
        [weakController hideLoading];
        [weakController dismissViewControllerAnimated:NO completion:nil];
        [weakS.photoCreator dismissViewControllerAnimated:NO completion:nil];
        
    } faildBlock:^(NSString *sourceUrl, NSString *thumbUrl, NSError *error) {
        [weakController hideLoading];
 
        [[FSToasManager sharedManager] showToastWithTitle:nil message:[FSSharedLanguages CustomLocalizedStringWithKey:@"RegisterPage_PhotoUploadFailed"]];
    }];
}
#pragma mark - FSMessageImageEditControllerDelegate
- (void)messagePhotoEditController:(UIViewController *)controller sourceImage:(UIImage *)sourceImage thumbImage:(UIImage *)thumbImage price:(NSInteger)price
{
    if ([self.delegate respondsToSelector:@selector(photoSelectorUploaded:thumbImage:price:)]) {
        [self.delegate photoSelectorUploaded:sourceImage thumbImage:thumbImage price:price];
    }
    //
    [controller dismissViewControllerAnimated:NO completion:nil];
    [self.photoCreator dismissViewControllerAnimated:NO completion:nil];
    
//    [self.uploader photoUploader:sourceImage thumbImage:thumbImage successBlock:^(NSString *sourceUrl, NSString *thumbUrl) {
//        [weakController hideLoading];
//        if ([weakS.delegate respondsToSelector:@selector(photoSelectorSelectImage:thumbImage:)]) {
//            [weakS.delegate photoSelectorSelectImage:sourceImage thumbImage:thumbImage];
//        }
//        if ([weakS.delegate respondsToSelector:@selector(photoSelectorUploaded:thumbUrl:)]) {
//            [weakS.delegate photoSelectorUploaded:sourceUrl thumbUrl:thumbUrl];
//        }
//        if ([weakS.delegate respondsToSelector:@selector(photoSelectorUploaded:thumbUrl:price:)]) {
//            NSString *pric = [NSString stringWithFormat:@"%ld",price];
//            [weakS.delegate photoSelectorUploaded:sourceUrl thumbUrl:thumbUrl price:pric];
//        }
//
//    } faildBlock:^(NSString *sourceUrl, NSString *thumbUrl, NSError *error) {
//    }];
}
#pragma mark - FSProfileImageEditControllerDelegate
- (void)profilePhotoEditController:(UIViewController *)controller sourceImage:(UIImage *)sourceImage thumbImage:(UIImage *)thumbImage price:(NSInteger)price {

    if (!self.photoListSever) {
        self.photoListSever = [[FSPhotoListSever alloc] init];
        [self.photoListSever setDelegate:self];
    }
    
    WS(weakS);
    __weak typeof(controller) weakController = controller;
    // 非免费的在最后
    NSInteger index = [self.photoModels count] + 1;
    if (0 == price) {
        // sort
        NSInteger freeCount = 0;
        for (FSPhotoModel *photoModel in  self.photoModels) {
            if (photoModel.price == 0) {
                freeCount += 1;
            }
        }
        // 新传的位置在免费的最后
        index = freeCount + 1;
    }
    
    [self.uploader photoUploader:sourceImage thumbImage:thumbImage successBlock:^(NSString *sourceUrl, NSString *thumbUrl,FSPhotoUploader *uploader) {
        [weakS.photoListSever photoListSeverUploadPhoto:price photoIndex:index orignalUrl:sourceUrl thumbUrl:thumbUrl photoIds:weakS.photoIds completeBlock:^(BOOL success, NSArray *photoIds, FSPhotoModel *photoModel, NSError *error) {
            [weakController.view hideLoading];
            if (success) {
                if ([weakS.delegate respondsToSelector:@selector(photoSelectorSelectImage:thumbImage:)]) {
                    [weakS.delegate photoSelectorSelectImage:sourceImage thumbImage:thumbImage];
                }
                if ([weakS.delegate respondsToSelector:@selector(photoSelectorUploaded:thumbUrl:)]) {
                    [weakS.delegate photoSelectorUploaded:sourceUrl thumbUrl:thumbUrl];
                }
                if ([weakS.delegate respondsToSelector:@selector(photoSelectorUploaded:photoModel:)]) {
                    [weakS.delegate photoSelectorUploaded:photoIds photoModel:photoModel];
                }

                [weakController dismissViewControllerAnimated:NO completion:nil];
                [weakS.photoCreator dismissViewControllerAnimated:NO completion:nil];
            }else{
                [weakController showAlertWithMessage:[FSSharedLanguages CustomLocalizedStringWithKey:@"uploadFaild"]];
            }
        }];
        
        
    } faildBlock:^(NSString *sourceUrl, NSString *thumbUrl, NSError *error) {
        [weakController hideLoading];
        [weakController showAlertWithMessage:[FSSharedLanguages CustomLocalizedStringWithKey:@"uploadFaild"]];
    }];
}

- (void)showFailedController:(UIViewController *)controller {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:[FSSharedLanguages CustomLocalizedStringWithKey:@"uploadFaild"] preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:[FSSharedLanguages CustomLocalizedStringWithKey:@"Cancel"] style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:cancleAction];
    [controller presentViewController:alert animated:nil completion:nil];
}

- (void)setPhotoModels:(NSArray *)photoModels {
    _photoModels = photoModels;
    NSMutableArray *array = [NSMutableArray array];
    for (FSPhotoModel *model in photoModels) {
        if (model.photoId != nil) {
            [array addObject:model.photoId];
        }
    }
    [self setPhotoIds:array];
}

@end
