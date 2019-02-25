//
//  UIView+GC.m
//  FlyShow
//
//  Created by 高超的开发 on 14-8-27.
//  Copyright (c) 2014年 牟亚军. All rights reserved.
//

#import "UIView+GC.h"
#import "NSString+GC.h"
#import "UIBezierPath+ShadowPath.h"

@implementation UIView (GC)
+ (UIView *)titleBgView:(NSString *)titletText
{
    UIView *_titleBgView;
    if (!_titleBgView) {
        _titleBgView = [[UIView alloc] init];
        
        UILabel *titleLab = [[UILabel alloc] init];
        //titleLab.text = @"我的账户";
        [titleLab setTextColor:[UIColor whiteColor]];
        titleLab.font = [UIFont systemFontOfSize:17];
        CGFloat Width = [NSString WidthFromString:titleLab.text withFont:17];
        titleLab.frame = CGRectMake(0, 0, Width, 20);
        titleLab.textAlignment = NSTextAlignmentCenter;
        [_titleBgView addSubview:titleLab];
        _titleBgView.frame = CGRectMake(0, 0, 50, 20);
        
    }
    //    [_titleBgView setBackgroundColor:[UIColor blueColor]];
    return _titleBgView;
}
-(void) setMaskByRoundingCorners:(UIRectCorner)corners CornerSize:(CGSize)size
{
    UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:size];
    CAShapeLayer* shape = [[CAShapeLayer alloc] init];
    shape.frame = self.bounds;
    [shape setPath:rounded.CGPath];
     self.layer.mask = shape;
}

- (void)addShadow
{
    // draw shadow
    self.layer.masksToBounds = NO;
    //-3 up 3 down
    self.layer.shadowOffset = CGSizeMake(0, 3);
    self.layer.shadowOpacity = 0.6;
    self.layer.shadowPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, CGRectGetHeight(self.bounds) - 3, CGRectGetWidth(self.bounds), 3)].CGPath;
}
-(UIImage *)shooootView{
    
    CGRect rect = self.bounds;
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (context == NULL)
    {
        return nil;
    }
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, -rect.origin.x, -rect.origin.y);
    if( [self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]){
        [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    }else{
        [self.layer renderInContext:context];
    }
    CGContextRestoreGState(context);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    NSData *newImageData = UIImageJPEGRepresentation(image, 0.9);
    image = [UIImage imageWithData:newImageData];
    UIGraphicsEndImageContext();
    return image;
}
@end
