//
//  FSMessageUnRead.m
//  Ready
//
//  Created by jiapeng on 2018/10/31.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "FSMessageUnRead.h"
#import "FSIMClientSever.h"
#import "FSConversation.h"
@interface FSMessageUnRead ()<FSIMClientReceiveMessageDelegate>
{
    dispatch_queue_t _conversationQueue;

}
@end

@implementation FSMessageUnRead

static FSMessageUnRead *shareInstance;

+ (instancetype)launcher {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[FSMessageUnRead alloc] init];
    });
    return shareInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
         _conversationQueue = dispatch_queue_create("com.ready.conversations", 0);
        [[FSIMClientSever sharedService] addDelegate:self];
        
        [self currentMessageAllNumber];
    }
    return self;
}

- (void)onReceived:(FSIMMessage *)message left:(int)nLeft {
    dispatch_async(_conversationQueue, ^{
        [self conversationSeverGetConversations];
    });
}
- (void)conversationSeverGetConversations {
    dispatch_async(_conversationQueue, ^{
        if (![[FSIMClientSever sharedService] FSIMIsConnected]) {
            return;
        }
        [self currentMessageAllNumber];
    });
}

- (NSString *)addFriendsMessageKey {
    NSString *currentUserId = [LoginSDKManager shareManager].user.userId;
    return [NSString stringWithFormat:@"add_%@",currentUserId];
}

-(void)currentMessageAllNumber {
    
    NSString *addFriendsMessageKey = [self addFriendsMessageKey];
    if (!addFriendsMessageKey) {
        return;
    }
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSArray *userIdArray =[defaults objectForKey:addFriendsMessageKey];
    
    NSInteger friendsNumber =0;
    NSArray* listArray =  [[FSIMClientSever sharedService] conversationList];
    
    //NSLog(@"mmmmmbbbbb 好友 %ld",userIdArray.count);
    
    
    for (int i=0; i<listArray.count; i++) {
        FSConversation *converStaion =[listArray objectAtIndex:i];
        
        //NSLog(@"mmmmmbbbbb aaaa %d",converStaion.unreadMessageCount);
        
        friendsNumber =friendsNumber+converStaion.unreadMessageCount;
    }
    
    //NSLog(@"mmmmmbbbbb 消息 %ld",friendsNumber);

    NSInteger allNumber =userIdArray.count +friendsNumber;
    //NSLog(@"mmmmmbbbbb 全服 %ld",allNumber);
    
    NSNumber *tempAllNumber =[NSNumber numberWithInteger:allNumber];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kNSNotificationCurrentMessageNumber object:tempAllNumber];

    //调用刷新当前总数的方法  刷新数字
}

-(void)removeFridensMessageNumber:(NSString *)userId {
    
    NSString *addFriendsMessageKey = [self addFriendsMessageKey];
    if (!addFriendsMessageKey) {
        return;
    }
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
    NSMutableArray *tempArray =[[NSMutableArray alloc] initWithCapacity:0];
    NSArray *userIdArray =[defaults objectForKey:addFriendsMessageKey];
    [tempArray addObjectsFromArray:userIdArray];
    
    if (userId!=nil) {
        BOOL isHas = [tempArray containsObject:userId];
        if (isHas) {
            [tempArray removeObject:userId];
        }
    }
    
    [defaults setObject:tempArray forKey:addFriendsMessageKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //当前添加好友数
    NSInteger allNumber =tempArray.count;
    
    //NSLog(@"mmmmmbbbbb 正常添加 %ld",allNumber);
    
    //调用 刷新添加好友数字方法
    
    NSNumber *tempAllNumber =[NSNumber numberWithInteger:allNumber];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kNSNotificationCurrentFriendsMessageNumber object:tempAllNumber];
    
    //调用tabbar总数字 方法
    [self currentMessageAllNumber];
    
}

-(void)addFridensMessageNumber:(NSString *)userId {
    
    NSString *addFriendsMessageKey = [self addFriendsMessageKey];
    if (!addFriendsMessageKey) {
        return;
    }
   
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
    NSMutableArray *tempArray =[[NSMutableArray alloc] initWithCapacity:0];
    NSArray *userIdArray =[defaults objectForKey:addFriendsMessageKey];
    [tempArray addObjectsFromArray:userIdArray];
    
    if (userId!=nil) {
        BOOL isHas = [tempArray containsObject:userId];
        if (!isHas) {
            [tempArray addObject:userId];
        }else{
            //return;
        }
    }
    
    [defaults setObject:tempArray forKey:addFriendsMessageKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //当前添加好友数
    NSInteger allNumber =tempArray.count;
    
    //NSLog(@"mmmmmbbbbb 正常添加 %ld",allNumber);
    
    //调用 刷新添加好友数字方法
    
    NSNumber *tempAllNumber =[NSNumber numberWithInteger:allNumber];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kNSNotificationCurrentFriendsMessageNumber object:tempAllNumber];
    
    //调用tabbar总数字 方法
    [self currentMessageAllNumber];
    
}

-(void)cleanFriendsMessageNumber {
    
    NSString *addFriendsMessageKey = [self addFriendsMessageKey];
    if (!addFriendsMessageKey) {
        return;
    }
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
    NSMutableArray *tempArray =[[NSMutableArray alloc] initWithCapacity:0];
    NSArray *userIdArray =[defaults objectForKey:addFriendsMessageKey];
    [tempArray addObjectsFromArray:userIdArray];

    [tempArray removeAllObjects];
    
    [defaults setObject:tempArray forKey:addFriendsMessageKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //当前添加好友数
    NSInteger allNumber =tempArray.count;
    
    //NSLog(@"mmmmmbbbbb 删除后 %ld",allNumber);
    
    //调用 刷新添加好友数字方法
    NSNumber *tempAllNumber =[NSNumber numberWithInteger:allNumber];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kNSNotificationCurrentFriendsMessageNumber object:tempAllNumber];
    
    //调用tabbar总数字 方法
    [self currentMessageAllNumber];
    
}

- (NSString *)temporarySessionKey {
    NSString *currentUserId = [LoginSDKManager shareManager].user.userId;
    return [NSString stringWithFormat:@"sessionKey_%@",currentUserId];

}
//添加临时会话
-(void)addTemporarySession:(NSString *)userId {
    
    NSString *sessionKey = [self temporarySessionKey];
    if (!sessionKey) {
        return;
    }
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
    NSMutableArray *tempArray =[[NSMutableArray alloc] initWithCapacity:0];
    NSArray *userIdArray =[defaults objectForKey:sessionKey];
    [tempArray addObjectsFromArray:userIdArray];
    
    NSMutableDictionary *addDict =[[NSMutableDictionary alloc] initWithCapacity:0];
    
    for (int i=0; i<tempArray.count; i++) {
        NSObject *tempObj =[tempArray objectAtIndex:i];
        if ([tempObj isKindOfClass:[NSDictionary class]]) {
            NSDictionary *tempDict = (NSDictionary *)tempObj;
            NSString *tempUserId =[tempDict stringForKey:@"userId"];
            if ([tempUserId isEqualToString:userId]) {
                return;
            }
        }
    }
   
    NSTimeInterval nowtime =[[NSDate date] timeIntervalSince1970];
    NSNumber *currentTime =[NSNumber numberWithDouble:nowtime];
    
    [addDict setObj:userId forKey:@"userId"];
    [addDict setObj:currentTime forKey:@"currentTime"];
    
    [tempArray addObject:addDict];
    
    [defaults setObject:tempArray forKey:sessionKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

//查询是否超过24小时
-(BOOL)isOverCurrentTime:(NSString *)userId {
    return [self isOverCurrentTime:userId showToast:YES];
}

-(BOOL)isOverCurrentTime:(NSString *)userId showToast:(BOOL)show {
    
    NSString *sessionKey = [self temporarySessionKey];
    if (!sessionKey) {
        return NO;
    }
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSArray *userIdArray =[defaults objectForKey:sessionKey];
    
    for (int i=0; i<userIdArray.count; i++) {
        NSDictionary *tempDict =[userIdArray objectAtIndex:i];
        NSString *tempUserId =[tempDict stringForKey:@"userId"];
        if ([tempUserId isEqualToString:userId]) {
            
            long long currentTime =[self getCurrentDate];
            long long oldTime =[[tempDict numberForKey:@"currentTime"] longLongValue];
            NSLog(@"mmmmvvvvvbbbb %lld,%lld",currentTime,oldTime);
#if Evt == 1
            NSTimeInterval distanceTime = 60 * 60 * 24;
#else
            NSTimeInterval distanceTime = 60 * 30;
#endif
            if (currentTime-oldTime>=distanceTime) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (show) {
                        [[FSToasManager sharedManager] showToastWithTitle:@"" message:[FSSharedLanguages CustomLocalizedStringWithKey:@"GameOverDialog_AddFried"] position:FFToastPositionDefault];
                    }
                });
                return YES;
            }
            
        }
    }
    
    return NO;
}

- (long long)getCurrentDate
{
    NSTimeInterval nowtime =[[NSDate date] timeIntervalSince1970];
    long long theTime =[[NSNumber numberWithDouble:nowtime] longLongValue];
    NSLog(@"=====  %lld",theTime);
    
    return theTime;

}



@end
