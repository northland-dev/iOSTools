//
//  FSQNLogger.m
//  Ready
//
//  Created by mac on 2018/11/28.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "FSQNLogger.h"

@interface FSQNLoggerWriter : NSObject<QNNOutputDelegate>
@property(nonatomic,copy)NSString *host;
@end

@implementation FSQNLoggerWriter

- (void)qnTcpPing:(NSString *)host complete:(void(^)(FSQNLoggerWriter *writer))complete{
    
    [QNNTcpPing start:host port:80 count:10 output:self complete:^(QNNTcpPingResult *result) {
        CGFloat percentage = 0.0;
        if (result.count <= 0) {
            percentage = 1.0;
        }else{
            percentage = MAX(0, MIN(1, (CGFloat)result.loss/(CGFloat)result.count));
        }
        
        NSNumber *perNumber = [NSNumber numberWithFloat:percentage];
        NSString *perStr = [NSNumberFormatter localizedStringFromNumber:perNumber numberStyle:(NSNumberFormatterPercentStyle)];
        NSDictionary *param = @{@"loss":perStr,@"total":[NSString stringWithFormat:@"%ld",result.count],@"host":host,@"avgTime":[NSString stringWithFormat:@"%.0f",result.avgTime]};
        [RyzeMagicStatics ryze_addEventName:@"DataSta_Host_Connect_Info" withParams:param];
        if (complete) {
            complete(self);
        }
    }];
}


- (void)write:(NSString *)line {
    NSLog(@"FSQNLoggerWriter %@",line);
}
@end


@interface FSQNLogger(){
    dispatch_queue_t _dealHostQueue;
}
@property(nonatomic,strong)NSMutableArray *hosts;
@property(nonatomic,strong)NSMutableArray *hostCheckers;

@end
@implementation FSQNLogger
static id obj = nil;
+ (instancetype)shareLogger {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [[FSQNLogger alloc] init];
    });
    return obj;
}
- (instancetype)init {
    if (self = [super init]) {
        _dealHostQueue = dispatch_queue_create("fsqnlogger.ready.queue", 0);
    }
    return self;
}

- (void)willCheckUrls:(NSDictionary *)urlDicts {
    dispatch_async(_dealHostQueue, ^{
        for (NSString *url in urlDicts.allValues) {
            NSURLComponents *components = [NSURLComponents componentsWithString:url];
            if (!components.host) {
                continue;
            }
            
            NSString *host = components.host;
            if ([self.hosts containsObject:host]) {
                continue;
            }
            
            [self.hosts addObject:host];
            
            FSQNLoggerWriter *writer = [[FSQNLoggerWriter alloc] init];
            writer.host = host;
            [self.hostCheckers addObject:writer];
        }
    
        [self startCheck];
    });
}

- (void)startCheck{
//    FSQNLoggerWriter *writer = [self.hostCheckers firstObject];
//    [writer qnTcpPing:writer.host complete:^(FSQNLoggerWriter *writer) {
//        dispatch_async(_dealHostQueue, ^{
//            [self.hostCheckers removeObject:writer];
//            [self startCheck];
//        });
//    }];
    
    for (FSQNLoggerWriter *writer in self.hostCheckers) {
        [writer qnTcpPing:writer.host complete:^(FSQNLoggerWriter *writer) {
            
        }];
    }
    
}

- (void)checkUrl:(NSString *)host {
    FSQNLoggerWriter *writer = [[FSQNLoggerWriter alloc] init];
    writer.host = host;
    [writer qnTcpPing:host complete:^(FSQNLoggerWriter *writer) {
        
    }];
}

- (NSMutableArray *)hosts {
    if (!_hosts) {
        _hosts = [NSMutableArray array];
    }
    return _hosts;
}

- (NSMutableArray *)hostCheckers {
    if (!_hostCheckers) {
        _hostCheckers = [NSMutableArray array];
    }
    return _hostCheckers;
}
@end

