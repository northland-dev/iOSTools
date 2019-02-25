//
//  FSIMGameFriendStateMessage.h
//  Ready
//
//  Created by gongruike on 2018/9/12.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "FSIMBaseModelContent.h"

@interface FSIMGameFriendStateMessage : FSIMBaseModelContent

@property(nonatomic,strong)NSString *gameId;
@property(nonatomic,strong)NSString *gameRoomId;
@property(nonatomic,assign)NSInteger gameState;

@end
