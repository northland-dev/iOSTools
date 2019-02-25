//
//  FSPayment.m
//  FSPurchase
//
//  Created by Fission on 2/11/2017.
//  Copyright © 2017 Fission. All rights reserved.
//

#import "FSPayment.h"

@implementation FSPayment

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        [self setTransactionId:[aDecoder decodeObjectForKey:@"transactionId"]];
        [self setSer:[aDecoder decodeObjectForKey:@"ser"]];
        [self setApplicationUserName:[aDecoder decodeObjectForKey:@"applicationUserName"]];
        [self setProductId:[aDecoder decodeObjectForKey:@"productId"]];
        [self setExtra:[aDecoder decodeObjectForKey:@"extra"]];
    }
    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.transactionId forKey:@"transactionId"];
    [aCoder encodeObject:self.ser forKey:@"ser"];
    [aCoder encodeObject:self.applicationUserName forKey:@"applicationUserName"];
    [aCoder encodeObject:self.productId forKey:@"productId"];
    [aCoder encodeObject:self.extra forKey:@"extra"];
}
+ (instancetype)paymentWithPaymentTraction:(SKPaymentTransaction *)paymentTransaction {
    
    FSPayment *payment = [[FSPayment alloc] init];
    
    NSString *ser = [self enCodeSerString];
    if (ser == nil) {
        ser = @"";
    } 
    [payment setSer:ser];
    
    NSString *tranId = paymentTransaction.transactionIdentifier;
    if (tranId == nil) {
        tranId = @"";
    }
    [payment setTransactionId:tranId];
    
    NSString *productId = paymentTransaction.payment.productIdentifier;
    [payment setProductId:productId];
    
    NSString *applicationUserName = paymentTransaction.payment.applicationUsername;
    [payment setApplicationUserName:applicationUserName];

    return payment;
}

-(BOOL)isSamePayment:(FSPayment *)object
{
    if (![self.transactionId isEqualToString:object.transactionId]) {
        return NO;
    }
    
    if (![self.productId isEqualToString:object.productId]) {
        return NO;
    }
    
    return YES;
}

+(NSString *)enCodeSerString
{
    NSURL *receiptURL = [[NSBundle mainBundle] appStoreReceiptURL];
    BOOL exist = [[NSFileManager defaultManager] fileExistsAtPath:[receiptURL path]];
    if (!exist) {
        //回调
        return nil;
    }
    // 从沙盒中获取到购买凭据
    NSData *receiptData = [NSData dataWithContentsOfURL:receiptURL];
    NSString *encodeStr = [receiptData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    return encodeStr;
}
@end
