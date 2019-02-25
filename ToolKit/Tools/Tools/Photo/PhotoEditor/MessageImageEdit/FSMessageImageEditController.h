//
//  FSMessageImageEditController.h
//  Lolly
//
//  Created by Charles on 2017/11/4.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import "FSPhotoEditController.h"
#import "FSPhotoEditProtocol.h"

@interface FSMessageImageEditController : FSPhotoEditController

@property(nonatomic,assign)id<FSMessageImageEditControllerDelegate>messageDelegate;

@property(nonatomic,assign)BOOL hideDeleteButton;
@property(nonatomic,assign)BOOL hideSetHeaderButton;
@property(nonatomic,assign)BOOL hideSlider;
@property(nonatomic,assign)NSInteger price;
@end
