//
//  FSIMGameInviteContent.h
//  Ready
//
//  Created by jiapeng on 2018/8/2.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FSIMBaseModelContent.h"

typedef NS_ENUM(NSInteger,FSGameMesageState){
    FSGameMesageStateWaiting = 0,
    FSGameMesageStateReject,
    FSGameMesageStateOutOfDate,
    FSGameMesageStateAccept,
    FSGameMesageStateWin,
    FSGameMesageStateLose,
    FSGameMesageStateEqual,
    FSGameMesageStateRejectByOther,
};
@interface FSIMGameInviteContent : FSIMBaseModelContent
@property (nonatomic ,strong) NSString *gameId;
@property (nonatomic ,strong) NSString *groupType;
@property (nonatomic ,strong) NSString *gameName;
@property (nonatomic ,strong) NSString *groupId;

@property (nonatomic ,strong) NSString *gameImage;
@property (nonatomic ,strong) NSString *winUserId;
@property (nonatomic ,assign) FSGameMesageState gameState;

// 倒计时
@property (nonatomic ,assign) NSInteger countDown;
@end
