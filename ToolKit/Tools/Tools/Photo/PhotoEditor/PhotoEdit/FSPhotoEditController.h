//
//  FSPhotoEditController.h
//  Lolly
//
//  Created by Charles on 2017/11/4.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import "FSImageEditController.h"
#import "FSPhotoEditProtocol.h"

@interface FSPhotoEditController : FSImageEditController

@property(nonatomic,assign)id<FSPhotoEditControllerDelegate>delegate;

@property(nonatomic,strong)NSString *uploadTitle;
@property(nonatomic,strong)UIButton *upLoadButton;

- (void)clickUpload;
@end
