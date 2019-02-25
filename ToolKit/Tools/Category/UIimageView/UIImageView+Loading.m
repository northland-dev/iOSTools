//
//  UIImageView+Loading.m
//  Ready
//
//  Created by mac on 2018/9/12.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "UIImageView+Loading.h"

static NSString *indictorKey = @"\11";
@implementation UIImageView (Loading)

- (UIActivityIndicatorView *)indicator {
    return objc_getAssociatedObject(self, &indictorKey);
}

- (void)setIndicator:(UIActivityIndicatorView *)indicator {
    objc_setAssociatedObject(self,&indictorKey, indicator, OBJC_ASSOCIATION_RETAIN);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [[self indicator] setCenter:self.center];
}


- (void)startLoadAnimation {
    if (!self.indicator) {
        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleGray)];
        [indicator setHidesWhenStopped:YES];
        [self setIndicator:indicator];
        
        indicator.center = self.center;
        [self addSubview:indicator];
    }
    
    [[self indicator] startAnimating];
//    [self setBackgroundColor:HexRGBAlpha(0xff0000, 1)];
}

- (void)stopLoadAnimation {
    
    [[self indicator] stopAnimating];
//    [self setBackgroundColor:UIColor.clearColor];
}
@end
