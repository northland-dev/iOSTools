//
//  NSString+JsonToDictionary.h
//  Ready
//
//  Created by luyee on 2018/8/16.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (DictionaryToJson)

- (NSString *)toJsonString;

@end

@interface NSString (JsonToDictionary)

-(NSDictionary *)toDictionary;

@end
