//
//  FSRequestTokenResult.h
//  Lolly
//
//  Created by stu on 2017/11/3.
//  Copyright © 2017年 Fission. All rights reserved.
//

@interface FSRequestTokenResult : FSBaseResult

@property (nonatomic, assign) NSInteger code;
@property (nonatomic, strong) NSString *dataInfo;

@end
