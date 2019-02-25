//
//  FSPhotoSelector.h
//  Lolly
//
//  Created by Charles on 2017/11/4.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,FSPhotoSelectorType) {
    FSPhotoSelectorTypeNone = 0,
    FSPhotoSelectorTypeCamera,
    FSPhotoSelectorTypePhoto
};

typedef NS_ENUM(NSInteger,FSPhotoEditorType) {
    FSPhotoEditorTypePhoto = 0,
    FSPhotoEditorTypeMessage = 1,
    FSphotoEditorTypeProfile = 2,
};

typedef NS_ENUM(NSInteger,FSPhotoUserType) {
    FSPhotoUserTypeHost = 0,
    FSPhotoUserTypeGuest = 1,
};

@class FSPhotoModel;
@protocol FSPhotoSelectorDelegate<NSObject>
@optional
- (void)photoSelectorSelectImage:(UIImage *)sourceImage thumbImage:(UIImage *)thumbImage;

- (void)photoSelectorUploaded:(NSString *)sourceUrl thumbUrl:(NSString *)thumbUrl;

- (void)photoSelectorUploaded:(NSString *)sourceUrl thumbUrl:(NSString *)thumbUrl price:(NSString *)price;

- (void)photoSelectorUploaded:(UIImage *)sourceImage thumbImage:(UIImage *)thumbImage price:(NSInteger *)price;

- (void)photoSelectorUploaded:(NSArray *)photoIds photoModel:(FSPhotoModel *)newPhoto;

@end

@interface FSPhotoSelector : NSObject
@property(nonatomic,strong)NSArray *photoModels;
@property(nonatomic,assign)FSPhotoUserType userType;
+ (instancetype)photoSelectorWithEditType:(FSPhotoEditorType)editorType;
- (void)showPhotoSelectorInController:(UIViewController<FSPhotoSelectorDelegate> *)controller
                        selectorType:(FSPhotoSelectorType)selectorType;
@end
