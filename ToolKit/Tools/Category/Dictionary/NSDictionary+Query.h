//
//  NSDictionary+Query.h
//  Ready
//
//  Created by mac on 2018/7/24.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Query)
- (NSString *)gc_query;
- (NSDictionary *)gc_dictWithQuery:(NSString *)query;
@end


@interface NSArray (Query)

- (NSString *)gc_queryWithKey:(NSString *)key;
@end
