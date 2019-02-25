//
//  FSLineButton.h
//  Ready
//
//  Created by mac on 2018/12/25.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FSLineButton : UIButton

//@property(nonatomic,strong)NSString *title;
- (void)setLineColor:(UIColor *)color;
- (void)setTitle:(NSString *)title;
- (void)setFont:(UIFont *)font forState:(UIControlState)state;

- (NSDictionary *)normalTitleAttribute;
- (NSDictionary *)seletedTitleAttribute;
@end

NS_ASSUME_NONNULL_END
