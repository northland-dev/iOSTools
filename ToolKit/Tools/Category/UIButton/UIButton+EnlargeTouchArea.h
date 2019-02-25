//
//  UIButton+EnlargeTouchArea.h
//  7nujoom
//
//  Created by air on 2018/4/1.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (EnlargeTouchArea)

- (void)setEnlargeEdgeWithTop:(CGFloat) top right:(CGFloat) right bottom:(CGFloat) bottom left:(CGFloat) left;

- (void)setEnlargeEdge:(CGFloat) size;

@end
