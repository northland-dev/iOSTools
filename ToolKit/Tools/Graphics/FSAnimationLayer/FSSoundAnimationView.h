//
//  FSSoundAnimationView.h
//  Ready
//
//  Created by mac on 2018/10/25.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "FSBaseView.h"
typedef NS_ENUM(NSInteger,FSFillType){
    FSFillTypeGame,
    FSFillTypeDanmu,
    FSFillTypeUnKown,
};
@interface FSSoundAnimationView : FSBaseView
@property(nonatomic,assign)CGFloat scale;
@property(nonatomic,assign)FSFillType fillType;
@end
