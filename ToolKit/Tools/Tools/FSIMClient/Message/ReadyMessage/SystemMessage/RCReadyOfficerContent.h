//
//  RCReadyOfficerContent.h
//  Ready
//
//  Created by mac on 2018/8/29.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "RCBaseModelContent.h"

@interface RCReadyOfficerContent : RCBaseModelContent
//0  1h5  2profile
@property(nonatomic,assign)NSInteger linkType;
@property(nonatomic,strong)NSString *linkName;
@property(nonatomic,strong)NSString *linkImage;
@property(nonatomic,strong)NSString *linkDesc;
@property(nonatomic,strong)NSString *linkPath;

@end
