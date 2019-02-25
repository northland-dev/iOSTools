//
//  FSTabBarItem.m
//  Ready
//
//  Created by mac on 2019/1/8.
//  Copyright © 2019年 Fission. All rights reserved.
//

#import "FSTabBarItem.h"

@implementation FSTabBarItem
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.svgaName = [aDecoder decodeObjectForKey:@"svgaName"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.svgaName forKey:@"svgaName"];
}

@end
