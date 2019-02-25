//
//  FSJsonCache.h
//  7nujoom
//
//  Created by apple on 7/14/16.
//  Copyright © 2016 Fission. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FSJsonCache : NSObject

+(FSJsonCache *)sharedCache;

-(NSDictionary *)dataInCacheWithKey:(NSString *)key;

-(NSString *)JsonVersionInCacheWithKey:(NSString *)key;

-(void)JsonCacheUpdateVersion:(NSString *)key Version:(NSString *)version;

-(void)cacheDealShouldSavedObjects:(NSArray *)data cacheComplete:(void (^)())complete;

-(void)cacheNotDealShouldSavedObjects:(NSDictionary *)dict;

-(id)cachedObjectWithClass:(Class)ckind;

-(BOOL)cacheObjectUpdateInDB:(id)object;

-(NSMutableArray *)cachedObjectsSearchOrderBy:(NSString *)orderBy where:(NSString *)where searchClass:(Class )className;

-(id)cachedObjectWithClass:(Class)ckind Where:(NSString *)where;

-(void)cacheShouldClearCache:(Class)cacheClass;

@end
