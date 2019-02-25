//
//  RCActivityHorseRace.m
//  Ready
//
//  Created by jiapeng on 2019/1/4.
//  Copyright © 2019年 Fission. All rights reserved.
//

#import "RCActivityHorseRace.h"

@implementation RCActivityHorseRace

- (NSData *)encode {
    return [self fs_JSONData];
}

- (void)decodeWithData:(NSData *)data {
    NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    FSMarqueeInfo *tempModel =[[FSMarqueeInfo alloc] init];
    
    tempModel.awardAmount =[dataDic int32ForKey:@"awardAmount"];
    tempModel.awardType =[dataDic integerForKey:@"awardType"];
    tempModel.gameId =[NSString stringWithFormat:@"%ld",[dataDic integerForKey:@"gameId"]];
    tempModel.nickname =[dataDic stringForKey:@"nickname"];
    tempModel.ranking =[dataDic integerForKey:@"ranking"];
    tempModel.userId =[NSString stringWithFormat:@"%ld",[dataDic integerForKey:@"userId"]];
    
    self.marqueeInfo =tempModel;
}

+ (NSString *)getObjectName {
    return AwardPoolHorseRace;
}

+ (RCMessagePersistent)persistentFlag {
    return MessagePersistent_NONE;
}

@end
