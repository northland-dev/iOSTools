//
//  FSIMTaskUpdateContent.h
//  Ready
//
//  Created by mac on 2018/8/23.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "FSIMBaseModelContent.h"

@interface FSIMTaskUpdateContent : FSIMBaseModelContent
@property(nonatomic,strong)NSString *taskId;
@property(nonatomic,assign)NSInteger mtype;
@end
