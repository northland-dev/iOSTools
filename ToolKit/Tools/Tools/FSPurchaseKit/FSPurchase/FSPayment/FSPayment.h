//
//  FSPayment.h
//  FSPurchase
//
//  Created by Fission on 2/11/2017.
//  Copyright © 2017 Fission. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FSPurchaseHeader.h"
#import "FSExtraParam.h"

@interface FSPayment : NSObject<NSCoding>
@property (nonatomic,copy)NSString *applicationUserName;
@property (nonatomic,copy)NSString *ser;
@property (nonatomic,copy)NSString *productId;
@property (nonatomic,copy)NSString *transactionId;

@property (nonatomic,copy)FSExtraParam *extra;

+ (instancetype)paymentWithPaymentTraction:(SKPaymentTransaction *)paymentTransaction;

- (BOOL)isSamePayment:(FSPayment *)object;

@end
