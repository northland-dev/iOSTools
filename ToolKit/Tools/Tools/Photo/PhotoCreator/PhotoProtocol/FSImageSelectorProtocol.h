//
//  FSImageSelectorProtocol.h
//  Lolly
//
//  Created by Charles on 2017/11/4.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FSImageSelectorDelegate <NSObject>
- (void)imageSelectorSelectedImage:(UIImage *)sourceImage;

@optional
- (void)imageSelectorCilckCancel;

@end
