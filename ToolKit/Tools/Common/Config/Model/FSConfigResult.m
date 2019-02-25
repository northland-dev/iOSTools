//
//  FSConfigResult.m
//  Lolly
//
//  Created by jiapeng on 2017/11/7.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import "FSConfigResult.h"

@implementation FSConfigResult

- (void)setDataInfo:(NSDictionary *)dataInfo {
    
    self.navsDict =[[NSDictionary alloc] init];
    self.otherDict =[[NSDictionary alloc] init];
    self.hotDict =[[NSDictionary alloc] init];
    
    self.navsDict =[dataInfo objectForKey:@"navs"];
    self.hotDict =[dataInfo objectForKey:@"popular_nations"];
    self.otherDict =[dataInfo objectForKey:@"nations"];
    self.exchangeDict =[dataInfo objectForKey:@"referExchangeRate"];
}

@end
