//
//  FSEndLessCell.m
//  Ready
//
//  Created by mac on 2019/1/10.
//  Copyright © 2019年 Fission. All rights reserved.
//

#import "FSEndLessCell.h"

@implementation FSEndLessCell

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super init]) {
        _reuseIdentifier = reuseIdentifier;
        [self createSubviews];
    }
    return self;
}
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier forInfoIndex:(NSInteger)infoIndex {
    if (self = [super init]) {
        _reuseIdentifier = reuseIdentifier;
        [self createSubviews];
    }
    return self;
}
- (void)prepareForReuse {}
- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    
}

@end
