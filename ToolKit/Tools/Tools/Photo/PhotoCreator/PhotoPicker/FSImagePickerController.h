//
//  FSImagePickerController.h
//  Lolly
//
//  Created by Charles on 2017/11/4.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSImageSelectorProtocol.h"

@interface FSImagePickerController : UIImagePickerController
@property(nonatomic,assign)id<FSImageSelectorDelegate> sourceDelegate;
@end
