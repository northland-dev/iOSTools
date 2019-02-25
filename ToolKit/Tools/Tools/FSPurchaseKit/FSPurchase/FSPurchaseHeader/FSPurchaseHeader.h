//
//  FSPurchaseHeader.h
//  FSPurchase
//
//  Created by Fission on 2/11/2017.
//  Copyright © 2017 Fission. All rights reserved.
//

#ifndef FSPurchaseHeader_h
#define FSPurchaseHeader_h
#import <StoreKit/StoreKit.h>
#import "FSPayment.h"
#import "FSExtraParam.h"

@class FSPayment;
typedef void (^CachePaymentBlock)(BOOL cacheSuccess,FSPayment *payment,SKPaymentTransaction *paymentTraction);
typedef void (^CheckPaymentBlock)(FSPayment *payment);
typedef void (^CompleteBlock)(void);

typedef void (^VerifySuccess)(void);
typedef void (^VerifyFaild)(void);


typedef void (^SuccessBlock)(FSPayment *payment,NSDictionary *dataInfo);
typedef void (^FaildBlock)(FSPayment *payment,NSInteger code,NSError *error);

#define SuccessCode 0
#define FaildByBlankRecipet 6000013
#define RepeatSuccessCode 6000006



#endif /* FSPurchaseHeader_h */
