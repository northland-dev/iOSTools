//
//  FSStaticJsonSever.m
//  7nujoom
//
//  Created by apple on 7/14/16.
//  Copyright © 2016 Fission. All rights reserved.
//

#import "FSStaticJsonSever.h"
#import "FSJsonCache.h"
#import "FSPlistManager.h"


@implementation FSJsonResult
@end

#define DataKey @"data"
#define StaticJsonRequestKey @"key"
#define VersonKey  @"v"

@interface FSStaticJsonSever()<FSBaseAPIDelegate>

@end
@implementation FSStaticJsonSever
+(FSStaticJsonSever *)sharedJsonSever
{
    return [[FSStaticJsonSever alloc] init];
}
-(instancetype)initWithDelegate:(id<FSStaticJsonSeverDelegate>)delegate{
    if (self = [super init]) {
        [self setDelegate:delegate];
    }
    return self;
}
-(void)dealloc
{
    NSLog(@"FSStaticJsonSever 销毁了");
}
-(void)jsonSeverShouldSyncGetJsonDataForced:(BOOL)forced WithKeys:(NSString *)key, ...{
    NSMutableDictionary *requestParam = [NSMutableDictionary dictionary];
    FSJsonCache *cache = [FSJsonCache sharedCache];

    if (key != nil) {
        va_list args;
        va_start(args, key);
        if (forced) {
            [requestParam setValue:@"0" forKey:key];
        }else{
            NSString *version = [cache JsonVersionInCacheWithKey:key];
            [requestParam setValue:version forKey:key];
        }
        va_end(args);
    }
    NSString *query = [requestParam gc_query];

    FSBaseAPI *base = [[FSBaseAPI alloc] init];
    [base setDelegate:self];
    
    NSString *originalUrl = [[FSGlobalLauncher launcher].allKeyDict objectForKey:KeyJson_infos];
    originalUrl = [originalUrl stringByAppendingString:[NSString stringWithFormat:@"?%@",query]];
    [base getWithURL:originalUrl param:[FSBaseParam new] result:[FSJsonResult class]];
}

-(void)jsonSeverShouldGetJsonDataForced:(BOOL)forced WithKeys:(NSString *)key, ...
{
    NSMutableDictionary *requestParam = [NSMutableDictionary dictionary];
    FSJsonCache *cache = [FSJsonCache sharedCache];
    if (key != nil) {
        va_list args;
        va_start(args, key);
        if (forced) {
            [requestParam setValue:@"0" forKey:key];
        }else{
            NSString *version = [cache JsonVersionInCacheWithKey:key];
            [requestParam setValue:version forKey:key];
        }
        va_end(args);
    }
    NSString *query = [requestParam gc_query];

    FSBaseAPI *base = [[FSBaseAPI alloc] init];
    [base setDelegate:self];
    NSString *originalUrl = [[FSGlobalLauncher launcher].allKeyDict objectForKey:KeyJson_infos];
     originalUrl = [NSString stringWithFormat:@"%@?%@",originalUrl,query];
    [base getWithURL:originalUrl param:[FSBaseParam new] result:[FSJsonResult class]];
}


#pragma mark - functions
-(void)updateDataVersion:(NSString *)versionKey version:(NSString *)version
{
    [[FSJsonCache sharedCache] JsonCacheUpdateVersion:versionKey Version:version];
}
-(NSDictionary *)dealDataShouldReturnedData:(id)data requestKey:(NSString *)key version:(NSString *)version
{
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:data,DataKey,key,StaticJsonRequestKey,version,VersonKey,nil];
    return dict;
}
-(void)jsonSeverClearCache:(Class)objclass
{
    [[FSJsonCache sharedCache] cacheShouldClearCache:objclass];
}
-(id)ObjectsDataFromCache:(Class )cachedClass
{
    NSArray *datas = [[FSJsonCache sharedCache] cachedObjectWithClass:cachedClass];
    return datas;
}
+(BOOL)jsonSeverUpdateDBForObject:(id)object
{
    return YES;
}
+(NSMutableArray *)jsonSeverSearchOrderBy:(NSString *)orderBy where:(NSString *)where searchClass:(Class )className;
{
    return [[FSJsonCache sharedCache] cachedObjectsSearchOrderBy:orderBy where:where searchClass:className];
}
+(id)jsonSeverSearchWhere:(NSString *)where searchClass:(Class)className{
    return [[FSJsonCache  sharedCache] cachedObjectWithClass:className Where:where];
}

-(id)objectDataFromPlist:(Class )className
{
    return nil;
}

-(NSArray *)objectsDataFromPlist:(Class )className plistName:(NSString *)plistName
{
    NSArray *objects = [FSPlistManager readPlistWithClass:className fileName:plistName];
    return objects;
}

-(NSDictionary *)objectsDataFromPlist:(Class )className key:(NSString *)keyType{
    return nil;
}
-(BOOL)saveDictInfoToPlist:(NSString *)plistName data:(id)dictOrArray
{
    BOOL saved = [FSPlistManager writeToPlistDictOrArray:dictOrArray fileName:plistName];
    return saved;
}
#pragma mark -
-(void)baseAPIBAckSuccessDict:(NSDictionary *)dict
{
    if ([self.delegate respondsToSelector:@selector(staticJsonSeverShouldGetLocalData)]) {
        [self.delegate staticJsonSeverShouldGetLocalData];
    }
    
    if ([self.delegate respondsToSelector:@selector(staticJsonSeverFailed:)]) {
        [self.delegate staticJsonSeverFailed:self];
    }
}
- (void)baseAPIFailed:(NSError *)error {
    if ([self.delegate respondsToSelector:@selector(staticJsonSeverShouldGetLocalData)]) {
        [self.delegate staticJsonSeverShouldGetLocalData];
    }
    
    if ([self.delegate respondsToSelector:@selector(staticJsonSeverFailed:)]) {
        [self.delegate staticJsonSeverFailed:self];
    }
}

- (void)baseAPIFailedWithCode:(NSInteger)code {
    if ([self.delegate respondsToSelector:@selector(staticJsonSeverShouldGetLocalData)]) {
        [self.delegate staticJsonSeverShouldGetLocalData];
    }
    
    if ([self.delegate respondsToSelector:@selector(staticJsonSeverFailed:)]) {
        [self.delegate staticJsonSeverFailed:self];
    }
}

- (void)baseAPISuccess:(FSBaseResult *)resultClass {
    FSJsonResult *result = (FSJsonResult *)resultClass;
    
    __weak FSStaticJsonSever *weakSelf = self;
    
    if ([self.delegate respondsToSelector:@selector(staticJsonSever:jsonRespones:)]) {
        NSDictionary *dealdict = [self.delegate staticJsonSever:self jsonRespones:result.dataInfo];
        if (dealdict != nil) {
            id data = [dealdict valueForKey:DataKey];
            NSString *key = [dealdict valueForKey:StaticJsonRequestKey];
            NSString *ver = [dealdict valueForKey:VersonKey];
            [[FSJsonCache sharedCache] cacheDealShouldSavedObjects:data cacheComplete:^{
                [[FSJsonCache sharedCache] JsonCacheUpdateVersion:key Version:ver];
                
                if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(cacheDealSavedObjectsCompleted)]) {
                    
                    [weakSelf.delegate cacheDealSavedObjectsCompleted];
                }
            }];
        }
    }else
    {
        [[FSJsonCache sharedCache] cacheNotDealShouldSavedObjects:result.dataInfo];
    }
}

@end
