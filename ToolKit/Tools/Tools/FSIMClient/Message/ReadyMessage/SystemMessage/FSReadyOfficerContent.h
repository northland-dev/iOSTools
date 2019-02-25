//
//  FSReadyOfficerContent.h
//  Ready
//
//  Created by mac on 2018/8/29.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "FSIMBaseModelContent.h"

@interface FSReadyOfficerContent : FSIMBaseModelContent
@property(nonatomic,assign)NSInteger linkType;
@property(nonatomic,strong)NSString *linkName;
@property(nonatomic,strong)NSString *linkImage;
@property(nonatomic,strong)NSString *linkDesc;
@property(nonatomic,strong)NSString *linkPath;
@end
