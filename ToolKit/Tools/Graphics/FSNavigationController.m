//
//  FSNavigationController.m
//  Ready
//
//  Created by jiapeng on 2018/7/19.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "FSNavigationController.h"
#import "UIColor+Image.h"
#import "FSHomeViewController.h"
#import "FSSeniorGameController.h"
#import "FSMessageController.h"
#import "UIViewController+FSContainerController.h"
#import "FSChatController.h"
#import "FSTabRankController.h"

@interface FSNavigationController ()<UIGestureRecognizerDelegate,UINavigationBarDelegate,UINavigationControllerDelegate>
@property(nonatomic, strong) NSMutableArray *titles;

@end

@implementation FSNavigationController{
    UIImageView *navBarHairlineImageView;
};

+ (void)initialize {
    // 获取特定类的所有导航条
//    UINavigationBar *navigationBar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[self class]]];
//
//    // 方式1：使用自己的图片替换原来的返回图片
//    navigationBar.backIndicatorImage = [UIImage imageNamed:@"Nav_back"];
//    navigationBar.backIndicatorTransitionMaskImage = [UIImage imageNamed:@"Nav_back"];
//
//    // 方式2：设置返回图片颜色
//    navigationBar.tintColor = HexRGBAlpha(0x5C4406, 1.0);
    //
    
}

-(void)back{
    [self popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationBar];
    
    self.titles = [[NSMutableArray alloc] init];
    self.navigationBar.translucent = NO;
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:HexRGB(0x5C4406),
                                                           NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0],
                                                           NSVerticalGlyphFormAttributeName: @(0)}];

    self.navigationBar.layer.shadowColor = HexRGB(0xD4CEBB).CGColor;
    self.navigationBar.layer.shadowOffset = CGSizeMake(0, 2);
    self.navigationBar.layer.shadowOpacity = 0.3;
    self.navigationBar.layer.shadowRadius = 4;
    self.navigationBar.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.navigationBar.bounds].CGPath;
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (!self.showBackTitle) {
        viewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                                           style:UIBarButtonItemStylePlain
                                                                                          target:nil
                                                                                          action:nil];
        
        [self.titles addObject:self.navigationBar.topItem.title ?: @""];
    }    

    viewController.hidesBottomBarWhenPushed = [self checkClass:viewController];
    [super pushViewController:viewController animated:animated];
}


- (BOOL)checkClass:(UIViewController *)viewVc
{
    NSArray *Array = @[[FSHomeViewController class], [FSMessageController class], [FSSeniorGameController class],[FSTabRankController class]];

    BOOL hide = YES;

    for (Class vc in Array) {
        if ([viewVc isKindOfClass:vc]) {
            return NO;
        }
    }
    return hide;
}


- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated {
    if (!self.showBackTitle) {
        if (self.viewControllers.count > 1) {
            NSString *title = [self.titles firstObject];
            UIViewController *target = self.viewControllers[1];
            target.navigationItem.backBarButtonItem.title = title;
            self.titles = [[NSMutableArray alloc] init];
            [self.titles addObject:title ?: @""];
        }
    }
    
    return [super popToRootViewControllerAnimated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {

    if (!self.showBackTitle) {
        UIViewController *targetViewController = self.viewControllers.lastObject;
        targetViewController.navigationItem.backBarButtonItem.title = [self.titles lastObject];
        [self.titles removeLastObject];
    }
    
    NSLog(@"gc: ========== popViewControllerAnimated");
    
    return [super popViewControllerAnimated:animated];
}


- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *) view;
    }
    
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    
    return nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    navBarHairlineImageView.hidden = !self.showBottomLine;
}
- (BOOL)hidesBottomBarWhenPushed {
    
    return YES;
}
- (UIViewController *)childViewControllerForStatusBarStyle{
    return self.topViewController;
}
- (UIViewController *)childViewControllerForStatusBarHidden {
    return self.topViewController;
}
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    NSLog(@"willShowViewController");
}
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    NSLog(@"didShowViewController");
}
//- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {
//
//    if ([self.topViewController isKindOfClass:[FSChatController class]]) {
//        [self popToRootViewControllerAnimated:YES];
//    }else{
//        [self popViewControllerAnimated:YES];
//    }
//    return YES;
//}


@end
