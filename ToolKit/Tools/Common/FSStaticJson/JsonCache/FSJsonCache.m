//
//  FSJsonCache.m
//  7nujoom
//
//  Created by apple on 7/14/16.
//  Copyright © 2016 Fission. All rights reserved.
//

#import "FSJsonCache.h"
#import "FSJsonInfoDB.h"

#define VerCacheKey @"ver_cache_"
#define DataCacheKey @"data_cache_"
#define ObjectCacheKey @"Object_cache_"


@interface FSJsonCache()

{
    dispatch_queue_t _cacheObjQueue;
}

@end
@implementation FSJsonCache
+(FSJsonCache *)sharedCache
{
    return [[FSJsonCache alloc] init];
}
-(instancetype)init
{
    static id SharedJsonCache;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if((SharedJsonCache = [super init])!=nil)
        {
            self->_cacheObjQueue = dispatch_queue_create("com.fission.7nujoom.cacheJson", 0);
        }
    });
    
    self = SharedJsonCache;
    return self;
}
-(NSDictionary *)dataInCacheWithKey:(NSString *)key
{
    NSUserDefaults *udf = [NSUserDefaults standardUserDefaults];
    NSString *dataKey = [NSString stringWithFormat:@"%@%@",DataCacheKey,key];
    NSMutableDictionary *rDict = [udf valueForKey:dataKey];
    return rDict;
}
-(NSString *)JsonVersionInCacheWithKey:(NSString *)key
{
    
    NSUserDefaults *udf = [NSUserDefaults standardUserDefaults];
    NSString *cacheKey = [NSString stringWithFormat:@"%@%@",VerCacheKey,key];
    NSString *ver = [udf valueForKey:cacheKey];
    if (ver != nil) {
        return ver;
    }
    return @"0";
}
-(void)JsonCacheUpdateVersion:(NSString *)key Version:(NSString *)version;
{
    NSUserDefaults *udf = [NSUserDefaults standardUserDefaults];
    NSString *cacheKey = [NSString stringWithFormat:@"%@%@",VerCacheKey,key];
    [udf setValue:version forKey:cacheKey];
    [udf synchronize];
}
-(void)cacheDealShouldSavedObjects:(NSArray *)data cacheComplete:(void (^)())complete
{
    // 取到处理的数据
    dispatch_async(_cacheObjQueue, ^{
        BOOL deleted = NO;
        BOOL saveSucess = NO;
        for (id obj in data) {
            if (!deleted) {
                // 存储执行一次删除操作
                [[obj class] deleteWithWhere:nil];
                deleted = YES;
            }
            saveSucess = [[FSJsonInfoDB getUsedDBHelper] insertToDB:obj];
            if (saveSucess == NO) {
                break;
            }
        }
        if (saveSucess) {
            if(complete){
                dispatch_async(dispatch_get_main_queue()    , ^{
                    complete();
                });
            }
        }
    });
}
-(NSMutableArray *)cachedObjectsSearchOrderBy:(NSString *)orderBy where:(NSString *)where searchClass:(Class )className;
{
    NSMutableArray *data = [className searchWithWhere:where orderBy:orderBy offset:0 count:0];
    return data;
}
-(id)cachedObjectWithClass:(Class)ckind Where:(NSString *)where{
    return [ckind searchSingleWithWhere:where orderBy:nil];
}
-(id)cachedObjectWithClass:(Class)ckind
{
    NSMutableArray *data = [ckind searchWithWhere:nil orderBy:nil offset:0 count:0];
    return data;
}
-(BOOL)cacheObjectUpdateInDB:(id)object;
{
   return [object updateToDB];
}
-(void)cacheNotDealShouldSavedObjects:(NSDictionary *)dict
{
    NSUserDefaults *udf = [NSUserDefaults standardUserDefaults];

    NSArray *keys = [dict allKeys];
    for (NSString *key in keys) {
        NSDictionary *dataDict = [dict valueForKey:key];
        if ([[dataDict valueForKey:@"c"] intValue] == 0) {
            id data = [dataDict valueForKey:@"d"];
            if (data) {
                NSString *cacheDataKey = [NSString stringWithFormat:@"%@%@",DataCacheKey,key];
                [udf setObject:data forKey:cacheDataKey];
            }
        }else
        {
            // 数据相同
        }
        
        
        NSString *ver = [dataDict valueForKey:@"v"];
        if (ver) {
            NSString *cacheKey = [NSString stringWithFormat:@"%@%@",VerCacheKey,key];
            [udf setValue:ver forKey:cacheKey];
        }
        
        [udf synchronize];
    }
    
}
-(void)cacheShouldClearCache:(Class)cacheClass
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [cacheClass deleteWithWhere:nil];
    });
}
@end
