//
//  UITabBar+CustomBadge.m
//  gamecenter
//
//  Created by ZhuGuangwen on 15/9/21.
//  Copyright © 2015年 wepie. All rights reserved.
//

#import "UITabBar+CustomBadge.h"
#import <objc/runtime.h>

static NSString * const kBadgeViewInitedKey = @"kBadgeViewInited";
static NSString * const kBadgeDotViewsKey = @"kBadgeDotViewsKey";
static NSString * const kBadgeNumberViewsKey = @"kBadgeNumberViewsKey";
static NSString * const kTabIconWidth = @"kTabIconWidth";
static NSString * const kBadgeTop = @"kBadgeTop";

@implementation UITabBar (CustomBadge)

-(void)setTabIconWidth:(CGFloat)width{
    [self setValue:@(width) forUndefinedKey:kTabIconWidth];
}

-(void)setBadgeTop:(CGFloat)top{
    [self setValue:@(top) forUndefinedKey:kBadgeTop];
}

-(void)setBadgeStyle:(CustomBadgeType)type value:(NSInteger)badgeValue atIndex:(NSInteger)index{
    if( ![[self valueForKey:kBadgeViewInitedKey] boolValue] ){
        [self setValue:@(YES) forKey:kBadgeViewInitedKey];
        [self addBadgeViews];
    }
    NSMutableArray *badgeDotViews = [self valueForKey:kBadgeDotViewsKey];
    NSMutableArray *badgeNumberViews = [self valueForKey:kBadgeNumberViewsKey];
    
    // 兼容动态变化的tabbar
    if (badgeDotViews.count <= index || badgeNumberViews.count <= index) {
        for (UIView *obj in badgeDotViews) {
            [obj removeFromSuperview];
        }
        
        for (UIView *obj in badgeNumberViews) {
            [obj removeFromSuperview];
        }
        [self setValue:@(YES) forKey:kBadgeViewInitedKey];
        [self addBadgeViews];
        
        // reset
        badgeDotViews = [self valueForKey:kBadgeDotViewsKey];
        badgeNumberViews = [self valueForKey:kBadgeNumberViewsKey];
    }
    
    [badgeDotViews[index] setHidden:YES];
    [badgeNumberViews[index] setHidden:YES];
    
    if(type == kCustomBadgeStyleRedDot){
        [badgeDotViews[index] setHidden:NO];
        
    }else if(type == kCustomBadgeStyleNumber){
        [badgeNumberViews[index] setHidden:NO];
        UILabel *label = badgeNumberViews[index];
        [self adjustBadgeNumberViewWithLabel:label number:badgeValue];
        
    }else if(type == kCustomBadgeStyleNone){
    }
}

-(void)addBadgeViews{
    id idIconWith = [self valueForKey:kTabIconWidth];
    CGFloat tabIconWidth = idIconWith ? [idIconWith floatValue] : 32;
    id idBadgeTop = [self valueForKey:kBadgeTop];
    CGFloat badgeTop = idBadgeTop ? [idBadgeTop floatValue] : 11;
    
    NSInteger itemsCount = self.items.count;
    CGFloat itemWidth = self.bounds.size.width / itemsCount;
    
    //dot views
    NSMutableArray *badgeDotViews = [NSMutableArray new];
    for(int i = 0;i < itemsCount;i ++){
        UIView *redDot = [UIView new];
        redDot.bounds = CGRectMake(0, 0, 6, 6);
        redDot.center = CGPointMake(itemWidth*(i+0.5)+tabIconWidth/2, badgeTop);
        redDot.clipsToBounds = YES;
        redDot.backgroundColor = [UIColor redColor];
        redDot.layer.masksToBounds = YES;
        redDot.layer.cornerRadius = redDot.bounds.size.width/2;
        
        UIView *redView = [UIView new];
        redView.frame = CGRectMake(2, 2, 1, 1);
        redView.layer.masksToBounds = YES;
        redView.layer.cornerRadius = 4;
        redView.backgroundColor = [UIColor redColor];
        [redDot addSubview:redView];
        
        redDot.hidden = YES;
        [self.badgeContainer addSubview:redDot];
        [badgeDotViews addObject:redDot];
    }
    [self setValue:badgeDotViews forKey:kBadgeDotViewsKey];
    
    //number views
    NSMutableArray *badgeNumberViews = [NSMutableArray new];
    for(int i = 0;i < itemsCount;i ++){
        UILabel *redNum = [UILabel new];
        redNum.layer.anchorPoint = CGPointMake(0, 0.5);
        redNum.bounds = CGRectMake(0, 0, 20, 18);
        redNum.center = CGPointMake(itemWidth*(i+0.5)+tabIconWidth/2-10-3, badgeTop + 3);
        redNum.layer.cornerRadius = redNum.bounds.size.height/2;
        redNum.clipsToBounds = YES;
        redNum.backgroundColor = HexRGB(0xFF4E4E);
        redNum.hidden = YES;
        
        redNum.textAlignment = NSTextAlignmentCenter;
        redNum.font = [UIFont systemFontOfSize:12];
        redNum.textColor = [UIColor whiteColor];
        redNum.layer.borderColor = HexRGB(0xffffff).CGColor;
        redNum.layer.borderWidth = 1.0;
        
        [self.badgeContainer addSubview:redNum];
        [badgeNumberViews addObject:redNum];
    }
    [self setValue:badgeNumberViews forKey:kBadgeNumberViewsKey];
}

-(void)adjustBadgeNumberViewWithLabel:(UILabel *)label number:(NSInteger)number{
    [label setText:(number > 99 ? @"99+" : @(number).stringValue)];
    if(number < 10){
        label.bounds = CGRectMake(0, 0, 18, 18);
    }else if(number < 99){
        label.bounds = CGRectMake(0, 0, 22, 18);
    }else{
        label.bounds = CGRectMake(0, 0, 31, 18);
        NSString *originStr = @"99+";
        NSMutableAttributedString *attributedStr01 = [[NSMutableAttributedString alloc] initWithString:originStr];
        [attributedStr01 addAttribute: NSFontAttributeName value: [UIFont proximaFontOfSize:12]
                                range: NSMakeRange(0, originStr.length)];
        [attributedStr01 addAttribute: NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, originStr.length)];
        [attributedStr01 addAttribute: NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(2, 1)];
        label.attributedText = attributedStr01;
    }
}

-(id)valueForUndefinedKey:(NSString *)key{
    return objc_getAssociatedObject(self, (__bridge const void *)(key));
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    objc_setAssociatedObject(self, (__bridge const void *)(key), value, OBJC_ASSOCIATION_COPY);
}

@end
