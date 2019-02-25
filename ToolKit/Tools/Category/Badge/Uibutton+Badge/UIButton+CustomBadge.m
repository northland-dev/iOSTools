//
//  UIButton+CustomBadge.m
//  Ready
//
//  Created by mac on 2018/8/30.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "UIButton+CustomBadge.h"

static NSString * const kBadgeViewInitedKey = @"kBadgeViewInited";
static NSString * const kBadgeDotViewsKey = @"kBadgeDotViewsKey";
static NSString * const kBadgeNumberViewsKey = @"kBadgeNumberViewsKey";
static NSString * const kTabIconWidth = @"kTabIconWidth";
static NSString * const kBadgeTop = @"kBadgeTop";

@implementation UIButton (CustomBadge)

-(void)setTabIconWidth:(CGFloat)width{
    [self setValue:@(width) forUndefinedKey:kTabIconWidth];
}

-(void)setBadgeTop:(CGFloat)top{
    [self setValue:@(top) forUndefinedKey:kBadgeTop];
}

-(void)setBadgeStyle:(ButtonCustomBadgeType)type value:(NSInteger)badgeValue{
    NSInteger index = 0;
    if( ![[self valueForKey:kBadgeViewInitedKey] boolValue] ){
        [self setValue:@(YES) forKey:kBadgeViewInitedKey];
        [self addBadgeViews];
    }
    NSMutableArray *badgeDotViews = [self valueForKey:kBadgeDotViewsKey];
    NSMutableArray *badgeNumberViews = [self valueForKey:kBadgeNumberViewsKey];
    
    [badgeDotViews[index] setHidden:YES];
    [badgeNumberViews[index] setHidden:YES];
    
    if(type == kButtonCustomBadgeStyleRedDot){
        [badgeDotViews[index] setHidden:NO];
        
    }else if(type == kButtonCustomBadgeStyleNumber){
        [badgeNumberViews[index] setHidden:NO];
        UILabel *label = badgeNumberViews[index];
        [self adjustBadgeNumberViewWithLabel:label number:badgeValue];
        
    }else if(type == kButtonCustomBadgeStyleNone){
    }
}

-(void)addBadgeViews{
    id idIconWith = [self valueForKey:kTabIconWidth];
    CGFloat tabIconWidth = idIconWith ? [idIconWith floatValue] : 32;
    id idBadgeTop = [self valueForKey:kBadgeTop];
    CGFloat badgeTop = idBadgeTop ? [idBadgeTop floatValue] : 0;
    
    NSInteger itemsCount = 1;//self.items.count;
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
        [self addSubview:redDot];
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
        redNum.layer.borderColor = HexRGB(0xffffff).CGColor;
        redNum.layer.borderWidth = 1.0;
        
        redNum.textAlignment = NSTextAlignmentCenter;
        redNum.font = [UIFont systemFontOfSize:12];
        redNum.textColor = [UIColor whiteColor];
        
        [self addSubview:redNum];
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
