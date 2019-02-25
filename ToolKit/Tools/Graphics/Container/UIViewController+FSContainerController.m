//
//  UIViewController+FSContainerController.m
//  Ready
//
//  Created by mac on 2018/7/19.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "UIViewController+FSContainerController.h"

@implementation UIViewController (FSContainerController)
- (FSContainerController *)fs_containerController {
    UIViewController *parentViewController = self.parentViewController;
    while (parentViewController != nil) {
        if([parentViewController isKindOfClass:[FSContainerController class]]){
            return (FSContainerController *)parentViewController;
        }
        parentViewController = parentViewController.parentViewController;
        
        NSString *className = NSStringFromClass([parentViewController class]);
        NSLog(@"parentViewController className %@",className);
    }
    return nil;
}
@end
