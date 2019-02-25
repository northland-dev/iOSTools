//
//  FSProfileImageEditController.h
//  Lolly
//
//  Created by Charles on 2017/11/13.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import "FSMessageImageEditController.h"

@interface FSProfileImageEditController : FSMessageImageEditController
@property(nonatomic,strong)NSArray *photoModels;
@property(nonatomic,assign)id<FSProfileImageEditControllerDelegate> profileDelegate;
@end
