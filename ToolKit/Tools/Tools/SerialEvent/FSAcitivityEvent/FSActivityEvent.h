//
//  FSActivityEvent.h
//  Ready
//
//  Created by mac on 2018/11/20.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "FSSerialEvent.h"
#import "FSPopupModel.h"

@class FSActivityEvent;
typedef void(^FSActivityEventAction)(FSPopupModel *popupmodel, FSActivityEvent *activityEvent);

@interface FSActivityEvent : FSSerialEvent
@property(nonatomic,strong)FSPopupModel *popupmodel;
@property(nonatomic,copy)FSActivityEventAction action;
@end
