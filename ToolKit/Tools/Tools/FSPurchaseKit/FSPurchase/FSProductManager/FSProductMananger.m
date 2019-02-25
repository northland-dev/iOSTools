//
//  FSProductMananger.m
//  FSPurchase
//
//  Created by Charles on 2017/11/1.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import "FSProductMananger.h"
@interface FSProductMananger()<SKProductsRequestDelegate>
{
    SKProductsRequest *_productsRequest;
}
@property(nonatomic,strong)NSMutableDictionary *allProducts;
@property(nonatomic,strong)NSMutableDictionary *responseProducts;

@end
@implementation FSProductMananger
static id productManager;
- (NSMutableDictionary *)allProducts {
    if (!_allProducts) {
        _allProducts = [NSMutableDictionary dictionary];
    }
    return _allProducts;
}
- (void)requestProducts:(NSSet<NSString *> *)productIds {
    
    // 查找是否在列表中
    NSMutableSet *unDefinedSet = [NSMutableSet set];
    // 要返回的列表
    NSMutableDictionary *shouldResponeDict = [NSMutableDictionary dictionary];
    BOOL haveUnDefinedProduct = NO;
    for (NSString *productId in productIds) {
        if (![[self.allProducts allKeys] containsObject:productId]) {
            haveUnDefinedProduct = YES;
            [unDefinedSet addObject:productId];
        }else{
            SKProduct *product = [self.allProducts objectForKey:productId];
            [shouldResponeDict setObject:product forKey:productId];
        }
    }
    // 返回的结果
    self.responseProducts = shouldResponeDict;

    if (!haveUnDefinedProduct) {
        // 都存在
        if([self.delegate respondsToSelector:@selector(productManager:productSets:)]){
            [self.delegate productManager:self productSets:self.responseProducts];
        }
        // 不需要请求了
        return;
    }
    
    if (!_productsRequest) {
         _productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:unDefinedSet];
        [_productsRequest setDelegate:self];
    }
    [_productsRequest start];
}
#pragma mark - SKProductsRequestDelegate
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    
    for (SKProduct *product in response.products) {
        [self.responseProducts setObject:product forKey:product.productIdentifier];
        [self.allProducts setObject:product forKey:product.productIdentifier];
    }
    
    if ([self.delegate respondsToSelector:@selector(productManager:productSets:)]) {
        [self.delegate productManager:self productSets:self.responseProducts];
    }
    
    _productsRequest = nil;
}
#pragma mark - SKRequestDelegate
- (void)request:(SKRequest *)request didFailWithError:(NSError *)error {
    if ([self.delegate respondsToSelector:@selector(productManager:productSets:)]) {
        [self.delegate productManager:self productSets:self.responseProducts];
    }
    
    _productsRequest = nil;
}
#pragma mark -
- (void)cancleRequest{
    if (_productsRequest) {
        [_productsRequest cancel];
    }
    _productsRequest = nil;
}

#pragma mark - init
+ (instancetype)sharedManager{
    return [[FSProductMananger alloc] init];
}
- (instancetype)init{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if ((productManager = [super init]) != nil) {}
    });
    self = productManager;
    return self;
}
+ (id)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        productManager = [super allocWithZone:zone];
    });
    return productManager;
}
+ (id)copyWithZone:(struct _NSZone *)zone {
    return productManager;
}

@end
