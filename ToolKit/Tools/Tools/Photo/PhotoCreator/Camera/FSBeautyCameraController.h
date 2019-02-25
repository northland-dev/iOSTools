//
//  FSBeautyCameraController.h
//  Lolly
//
//  Created by Charles on 2017/11/3.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import "FSBaseViewController.h"
#import "FSImageSelectorProtocol.h"

@interface FSBeautyCameraController : FSBaseViewController

@property(nonatomic,assign)id<FSImageSelectorDelegate> sourceDelegate;

@end
