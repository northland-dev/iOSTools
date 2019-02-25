//
//  FSIMFriendsMessageContent.h
//  Ready
//
//  Created by jiapeng on 2018/8/2.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FSIMBaseModelContent.h"

@interface FSIMFriendsMessageContent : FSIMBaseModelContent
@property (nonatomic ,strong) NSString *messageType;
@property (nonatomic ,strong) NSString *message;
// text/gif/image
@property (nonatomic ,strong) NSString *messageContentType;
@property (nonatomic ,assign) BOOL HaveReadVoice;
@property (nonatomic ,assign) BOOL playAudio;
@end
