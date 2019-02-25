//
//  FSExtraParam.h
//  FSPurchase
//
//  Created by Charles on 2017/11/2.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FSExtraParam : NSObject<NSCoding,NSCopying>
@property(nonatomic,copy)NSString *roomId;
@property(nonatomic,copy)NSString  *coupon_code;
@end
