//
//  UITabBar+SvgaItem.h
//  Ready
//
//  Created by mac on 2019/1/9.
//  Copyright © 2019年 Fission. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITabBar+Container.h"

NS_ASSUME_NONNULL_BEGIN
@class FSTabBarItem;
@interface UITabBar (SvgaItem)
@property(nonatomic,strong)UIView *svgaContainer;

- (void)playSvgaWithName:(NSString *)name atIndex:(NSInteger)index;
- (void)playSvgaWithItem:(FSTabBarItem *)item;
@end

NS_ASSUME_NONNULL_END
