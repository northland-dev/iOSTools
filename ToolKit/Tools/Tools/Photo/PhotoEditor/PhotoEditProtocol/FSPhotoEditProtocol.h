//
//  FSPhotoEditProtocol.h
//  Lolly
//
//  Created by Charles on 2017/11/5.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FSPhotoEditProtocol <NSObject>
@optional
- (void)photoEditController:(UIImage *)sourceImage thumbImage:(UIImage *)thumbImage;
@end

@protocol FSPhotoEditControllerDelegate <FSPhotoEditProtocol>
- (void)photoEditController:(UIViewController *)controller
                sourceImage:(UIImage *)sourceImage
                 thumbImage:(UIImage *)thumbImage;

@end

@protocol FSMessageImageEditControllerDelegate <FSPhotoEditProtocol>
@optional
- (void)messagePhotoEditController:(UIViewController *)controller
                       sourceImage:(UIImage *)sourceImage
                        thumbImage:(UIImage *)thumbImage
                             price:(NSInteger)price;
@end

@protocol FSProfileImageEditControllerDelegate <FSPhotoEditProtocol>
@optional
- (void)profilePhotoEditController:(UIViewController *)controller
                       sourceImage:(UIImage *)sourceImage
                        thumbImage:(UIImage *)thumbImage
                             price:(NSInteger)price;
@end
