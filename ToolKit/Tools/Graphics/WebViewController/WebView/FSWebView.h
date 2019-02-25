//
//  FSWebView.h
//  Ready
//
//  Created by mac on 2018/9/6.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FSWebView : UIWebView<UIGestureRecognizerDelegate>

- (void)setupShouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer;
@end
