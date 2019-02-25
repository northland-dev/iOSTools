//
//  Recognize+Ctrl.m
//  7nujoom
//
//  Created by luyee on 2018/6/26.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "Recognize+Ctrl.h"
#import <objc/runtime.h>



@implementation UIViewController (Recognize)

+ (void)load{
    Method imp_ViewDidLoad = class_getInstanceMethod(self.class, @selector(viewDidLoad));
    Method imp_RecongnizeViewDidLoad = class_getInstanceMethod(self.class, @selector(recognizeViewDidLoad));
    method_exchangeImplementations(imp_ViewDidLoad, imp_RecongnizeViewDidLoad);
    
    
    Method imp_ViewDidAppear = class_getInstanceMethod(self.class, @selector(viewDidAppear:));
    Method imp_RecongnizeViewDidAppear = class_getInstanceMethod(self.class, @selector(recognizeViewDidAppear:));
    method_exchangeImplementations(imp_ViewDidAppear, imp_RecongnizeViewDidAppear);
}

- (void)recognizeViewDidLoad {
    [self recognizeViewDidLoad];
//    NSLog(@"%@ : ViewDidLoad", NSStringFromClass(self.class));
}

-  (void)recognizeViewDidAppear:(BOOL)animated{
    [self recognizeViewDidAppear:animated];
//    NSLog(@"%@ : ViewDidAppear", NSStringFromClass(self.class));
}


@end
