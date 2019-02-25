//
//  FSStaticJsonSever.h
//  7nujoom
//
//  Created by apple on 7/14/16.
//  Copyright © 2016 Fission. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FSPlistManager.h"
#import "FSBaseRequestResult.h"

@class FSStaticJsonSever;
@protocol FSStaticJsonSeverDelegate <NSObject>

-(NSDictionary *)staticJsonSever:(FSStaticJsonSever *)jsonSever jsonRespones:(NSDictionary *)dataResponse;


@optional
-(void)staticJsonSeverFailed:(FSStaticJsonSever *)jsonSever;

-(void)staticJsonSeverShouldGetLocalData;

-(void)cacheDealSavedObjectsCompleted;

@end


@interface FSJsonResult : FSBaseRequestResult
@property(nonatomic,strong)NSDictionary *dataInfo;
@end

@interface FSStaticJsonSever : NSObject

@property(nonatomic,assign)id<FSStaticJsonSeverDelegate>delegate;

+(FSStaticJsonSever *)sharedJsonSever;

-(instancetype)initWithDelegate:(id<FSStaticJsonSeverDelegate>)delegate;

/**
 *  同步获取静态json资源
 *
 *  @param forced 是否强制更新
 *  @param key    要更新的数据
 */
-(void)jsonSeverShouldSyncGetJsonDataForced:(BOOL)forced WithKeys:(NSString *)key, ...;
/**
 *  获取静态json资源
 *
 *  @param forced 是否强制更新
 *  @param key    要更新的数据
 */
-(void)jsonSeverShouldGetJsonDataForced:(BOOL)forced WithKeys:(NSString *)key, ...;
/**
 *  从数据库中读取对象
 *
 *  @param cachedClass 对象所属的类
 *
 *  @return 一组对象
 */
-(id)ObjectsDataFromCache:(Class )cachedClass;

/**
 *  更新数据版本号
 *
 *  @param versionKey <#versionKey description#>
 *  @param version    <#version description#>
 */
-(void)updateDataVersion:(NSString *)versionKey version:(NSString *)version;
/**
 *  把实体存储到更新到数据库
 *
 *  @param object object
 *
 *  @return 操作结果
 */
+(BOOL)jsonSeverUpdateDBForObject:(id)object;

/**
 *  组装一个字典
 *
 *  @param data    对象
 *  @param key     对象对应的key
 *  @param version 版本号
 *
 *  @return 返回字典
 */
-(NSDictionary *)dealDataShouldReturnedData:(id)data requestKey:(NSString *)key version:(NSString *)version;

/**
 *  从数据库中获取className的对象
 *
 *  @param orderBy   排序方式
 *  @param where     查找条件
 *  @param className 要查找的类别
 *
 *  @return <#return value description#>
 */
+(NSMutableArray *)jsonSeverSearchOrderBy:(NSString *)orderBy where:(NSString *)where searchClass:(Class )className;


+(id)jsonSeverSearchWhere:(NSString *)where searchClass:(Class)className;

/**
 *  清空数据库缓存
 *
 *  @param objclass
 */
-(void)jsonSeverClearCache:(Class)objclass;




#pragma mark -  以下方法还未完成





/**
 *  将模型数据以字典的形式存储到plist列表
 *
 *  @param plistName   plist文件名称
 *  @param dictOrArray 存储格式
 *  @return 返回存储结果
 */
-(BOOL)saveDictInfoToPlist:(NSString *)plistName data:(id)dictOrArray;

/**
 *  从plist中获取模型
 *
 *  @param className 类型名称
 *
 *  @return
 */
-(id)objectDataFromPlist:(Class )className;
/**
 *  获取一组数据
 *
 *  @param className 模型的类型
 *  @param plistName plist名称
 *
 *  @return 模型数组
 */
-(NSArray *)objectsDataFromPlist:(Class )className plistName:(NSString *)plistName;

/**
 *  获取字典存储的数据
 *
 *  @param className <#className description#>
 *  @param keyType   <#keyType description#>
 *
 *  @return <#return value description#>
 */
-(NSDictionary *)objectsDataFromPlist:(Class )className key:(NSString *)keyType;


@end
