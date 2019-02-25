//
//  UIKit+ChainProgramming.m
//  Link
//
//  Created by luyee on 2018/8/3.
//  Copyright © 2018年 luyee. All rights reserved.
//

#import "UIKit+ChainProgramming.h"

//@implementation
@implementation UIView (ChainProgramming)

- (UIView * (^)(UIColor *))cp_borderColor{
    return ^(UIColor *borderColor){
        self.layer.borderColor = borderColor.CGColor;
        return self;
    };
}

- (UIView * (^)(CGFloat))cp_borderWidth{
    return ^(CGFloat borderWidth){
        self.layer.borderWidth = borderWidth;
        return self;
    };
}

- (UIView * (^)(NSInteger cornerValue, CGFloat radius))cp_BezierCornerRadius{
    return ^(NSInteger cornerValue, CGFloat radius){
        UIRectCorner corner = 0;
        if (cornerValue / 1000) {
            corner |= UIRectCornerTopLeft;
            cornerValue %= 1000;
        }
        if (cornerValue / 100) {
            corner |= UIRectCornerTopRight;
            cornerValue %= 100;
        }
        if (cornerValue / 10) {
            corner |= UIRectCornerBottomLeft;
            cornerValue %= 10;
        }
        if (cornerValue) {
            corner |= UIRectCornerBottomRight;
        }
        UIBezierPath *path =  [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corner cornerRadii:CGSizeMake(radius, radius)];
        CAShapeLayer* shape = [[CAShapeLayer alloc] init];
        shape.frame = self.bounds;
        [shape setPath:path.CGPath];
        self.layer.mask = shape;
        return self;
    };
    
}

- (UIView * (^)(CGFloat))cp_cornerRadius{
    return ^(CGFloat cornerRadius){
        self.layer.cornerRadius = cornerRadius;
        return self;
    };
}
- (UIView * (^)(UIColor *))cpBgColor{
    return ^(UIColor *bgColor){
        self.backgroundColor = bgColor;
        return self;
    };
}
- (UIView * (^)(BOOL))cpHidden{
    return ^(BOOL hidden){
        self.hidden = hidden;
        return self;
    };
}
- (UIView * (^)(NSInteger))cpTag{
    return ^(NSInteger tag){
        self.tag = tag;
        return self;
    };
}
- (UIView * (^)(CGRect))cpFrame{
    return ^(CGRect frame){
        self.frame = frame;
        return self;
    };
}
- (UIView * (^)(CGPoint))cpCenter{
    return ^(CGPoint center){
        self.center = center;
        return self;
    };
}
- (UIView * (^)(BOOL))cpUserInteractionEnabled{
    return ^(BOOL userInteractionEnabled){
        self.userInteractionEnabled = userInteractionEnabled;
        return self;
    };
}
- (UIView * (^)(UIView *))cpAdd{
    return ^(UIView *subView){
        [self addSubview:subView];
        return self;
    };
}
- (UIView * (^)(UIView *))cpRemove{
    return ^(UIView *subView){
        [subView removeFromSuperview];
        return self;
    };
}

- (UIView * (^)(BOOL))cpClips{
    return ^(BOOL clips){
        self.clipsToBounds = clips;
        return self;
    };
}

@end

@implementation UILabel (ChainProgramming)

- (UILabel * (^)(NSString *))cpTxt{
    return ^(NSString *text){
        self.text = text;
        return self;
    };
}
- (UILabel * (^)(UIColor *))cpTxtColor{
    return ^(UIColor *textColor){
        self.textColor = textColor;
        return self;
    };
}
- (UILabel * (^)(UIFont *))cpFont{
    return ^(UIFont *font){
        self.font = font;
        return self;
    };
}
- (UILabel * (^)(NSTextAlignment))cpTxtAlignment{
    return ^(NSTextAlignment textAlignment){
        self.textAlignment = textAlignment;
        return self;
    };
}
- (UILabel * (^)(NSInteger))cpLinesNumber{
    return ^(NSInteger numberOfLines){
        self.numberOfLines = numberOfLines;
        return self;
    };
}

- (UILabel * (^)(NSArray <NSString *>*strArr, NSArray <UIFont *>*fontArr, NSArray <UIColor *>*colorArr))setupStrings_Fonts_Colors{
    return ^(NSArray <NSString *>*strArr, NSArray <UIFont *>*fontArr, NSArray <UIColor *>*colorArr){
        NSString *preStr = strArr.firstObject;
        NSString *subStr = strArr.lastObject;
        UIFont *font1 = fontArr.firstObject;
        UIFont *font2 = fontArr.lastObject;
        UIColor *color1 = colorArr.firstObject;
        UIColor *color2 = colorArr.lastObject;
        NSString *tmpStr = [NSString stringWithFormat:@"%@%@", preStr, subStr];
        NSMutableAttributedString *distanceAttributedString = [[NSMutableAttributedString alloc] initWithString:tmpStr];
        NSRange r1 = NSMakeRange(0, preStr.length);
        
        [distanceAttributedString addAttribute:NSFontAttributeName
                                         value:font1
                                         range:r1];
        [distanceAttributedString addAttribute:NSForegroundColorAttributeName
                                         value:color1
                                         range:r1];
        if (subStr && subStr.length) {
            NSRange r2 = NSMakeRange(preStr.length, subStr.length);
            [distanceAttributedString addAttribute:NSFontAttributeName
                                             value:font2
                                             range:r2];
            [distanceAttributedString addAttribute:NSForegroundColorAttributeName
                                             value:color2
                                             range:r2];
        }
        self.attributedText = distanceAttributedString;
        return self;
    };
    
};
//- (UIView * (^)())cp
//- (UIView * (^)())cp
//- (UIView * (^)())cp


@end

@implementation UIButton (ChainProgramming)

+ (UIButton *)cpNew{ // 以类型设置方法开始
    UIButton *cpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    return cpBtn;
}

- (UIButton * (^)(NSString *))cpTitleNormal{
    return ^(NSString *title){
        [self setTitle:title forState:UIControlStateNormal];
        return self;
    };
}

- (UIButton * (^)(NSString *))cpTitleSelected{
    return ^(NSString *title){
        [self setTitle:title forState:UIControlStateSelected];
        return self;
    };
}
- (UIButton * (^)(NSString *))cpTitleDisabled{
    return ^(NSString *title){
        [self setTitle:title forState:UIControlStateDisabled];
        return self;
    };
}
- (UIButton * (^)(UIFont *))cpFont{
    return ^(UIFont *font){
        self.titleLabel.font = font;
        return self;
    };
}
- (UIButton * (^)(CGFloat))cpTitleImageEdgeInsets{
    return ^(CGFloat inset){
        [self setTitleEdgeInsets:UIEdgeInsetsMake(0, inset, 0, - inset)];
        [self setImageEdgeInsets:UIEdgeInsetsMake(0, - inset, 0, inset)];
        return self;
    };
}

- (UIButton * (^)(UIColor *))cpTitleColorNormal{
    return ^(UIColor *titleColor){
        [self setTitleColor:titleColor forState:UIControlStateNormal];
        return self;
    };
}
- (UIButton * (^)(UIColor *))cpTitleColorSelected{
    return ^(UIColor *titleColor){
        [self setTitleColor:titleColor forState:UIControlStateSelected];
        return self;
    };
}
- (UIButton * (^)(UIColor *))cpTitleColorHighlighted{
    return ^(UIColor *titleColor){
        [self setTitleColor:titleColor forState:UIControlStateHighlighted];
        return self;
    };
}
- (UIButton * (^)(UIColor *))cpTitleColorDisabled{
    return ^(UIColor *titleColor){
        [self setTitleColor:titleColor forState:UIControlStateDisabled];
        return self;
    };
}

- (UIButton * (^)(UIImage *))cpBgImageNormal{
    return ^(UIImage *bgImage){
        [self setBackgroundImage:bgImage forState:UIControlStateNormal];
        return self;
    };
}

- (UIButton * (^)(UIImage *))cpBgImageSelected{
    return ^(UIImage *bgImage){
        [self setBackgroundImage:bgImage forState:UIControlStateSelected];
        return self;
    };
}

- (UIButton * (^)(UIImage *))cpBgImageHighLighted{
    return ^(UIImage *bgImage){
        [self setBackgroundImage:bgImage forState:UIControlStateHighlighted];
        return self;
    };
}

- (UIButton * (^)(UIImage *))cpBgImageDisabled{
    return ^(UIImage *bgImage){
        [self setBackgroundImage:bgImage forState:UIControlStateDisabled];
        return self;
    };
}


- (UIButton * (^)(UIImage *))cpImageNormal{
    return ^(UIImage *image){
        [self setImage:image forState:UIControlStateNormal];
        return self;
    };
}

- (UIButton * (^)(UIImage *))cpImageSelected{
    return ^(UIImage *image){
        [self setImage:image forState:UIControlStateSelected];
        return self;
    };
}

- (UIButton * (^)(UIImage *))cpImageHighLighted{
    return ^(UIImage *image){
        [self setImage:image forState:UIControlStateHighlighted];
        return self;
    };
}

- (UIButton * (^)(UIImage *))cpImageDisabled{
    return ^(UIImage *image){
        [self setImage:image forState:UIControlStateDisabled];
        return self;
    };
}

- (UIButton * (^)(id, SEL))cpTouchUpInsideEvent{
    return ^(id target, SEL sel){
        [self addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
        return self;
    };
}
- (UIButton * (^)(BOOL))cpSelected{
    return ^(BOOL selected){
        self.selected = selected;
        return self;
    };
}

@end

@implementation UIImage (ChainProgramming)

typedef NS_ENUM(NSUInteger, GradientType) {
    GradientTypeTopToBottom = 0,//从上到小
    GradientTypeLeftToRight = 1,//从左到右
    GradientTypeUpleftToLowright = 2,//左上到右下
    GradientTypeUprightToLowleft = 3,//右上到左下
};

+ (UIImage *)gradientColorImageFromColors:(NSArray*)colors gradientType:(GradientType)gradientType imgSize:(CGSize)imgSize {
    NSMutableArray *ar = [NSMutableArray array];
    for(UIColor *c in colors) {
        [ar addObject:(id)c.CGColor];
    }
    UIGraphicsBeginImageContextWithOptions(imgSize, YES, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, NULL);
    CGPoint start;
    CGPoint end;
    switch (gradientType) {
        case GradientTypeTopToBottom:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(0.0, imgSize.height);
            break;
        case GradientTypeLeftToRight:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(imgSize.width, 0.0);
            break;
        case GradientTypeUpleftToLowright:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(imgSize.width, imgSize.height);
            break;
        case GradientTypeUprightToLowleft:
            start = CGPointMake(imgSize.width, 0.0);
            end = CGPointMake(0.0, imgSize.height);
            break;
        default:
            break;
    }
    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *(^)(UIColor *, UIColor *))cpColorChangeImg{
    return ^(UIColor *preClr, UIColor *subClr){
        UIImage *colorImg = [UIImage gradientColorImageFromColors:@[preClr,subClr] gradientType:GradientTypeLeftToRight imgSize:CGSizeMake(ScreenW, 80)];
        return colorImg;
    };
}

+ (UIImage *(^)(UIColor *, CGSize))cpColorImg{
    return ^(UIColor *color, CGSize size){
        UIImage *colorImg = [UIImage gradientColorImageFromColors:@[color,color] gradientType:GradientTypeLeftToRight imgSize:size];
        return colorImg;
    };
}

+ (UIImage * (^)(NSString *))cpWithName{
    return ^(NSString *imgName){
        UIImage *image = [UIImage imageNamed:imgName];
        return image;
    };
}
//- (UIImage * (^)())cp
//- (UIImage * (^)())cp

@end


@implementation UIImageView (ChainProgramming)

- (UIImageView * (^)(UIImage *))cpImage{
    return ^(UIImage *image){
        self.image = image;
        return self;
    };
}
//- (UIImageView * (^)())cp
//- (UIImageView * (^)())cp

@end

@implementation UITextView (ChainProgramming)

//- (UITextView * (^)())cp

@end

@implementation UITextField (ChainProgramming)

//- (UITextField * (^)())cp

@end

@implementation UITableView (ChainProgramming)

- (UITableView * (^)(Class))cpRegisterCellClass{
    return ^(Class class){
        [self registerClass:class forCellReuseIdentifier:NSStringFromClass(class)];
        return self;
    };
}     // cell的id就是register class的名字
- (UITableView * (^)(UITableViewCellSeparatorStyle))cpSeparatorStyle{
    return ^(UITableViewCellSeparatorStyle separatorStyle){
        self.separatorStyle = separatorStyle;
        return self;
    };
}
- (UITableView * (^)(UIColor *))cpSeparatorColor{
    return ^(UIColor *separatorColor){
        self.separatorColor = separatorColor;
        return self;
    };
}
- (UITableView * (^)(id))cpDataSource{
    return ^(id dataSource){
        self.delegate = dataSource;
        self.dataSource = dataSource;
        return self;
    };
}
- (UITableView * (^)(BOOL))cpHasFooterView{
    return ^(BOOL hasFooterView){
        if (!hasFooterView) {
            self.tableFooterView = UIView.new;
        }
        return self;
    };
}
- (UITableView * (^)(void))cpAfterReload{
    return ^(){
        return self;
    };
}
- (UITableViewCell * (^)(NSString *))cellWithId{
    return ^(NSString *cellId){
        ;
        return [self dequeueReusableCellWithIdentifier:cellId];
    };
}
- (UITableView * (^)(CGFloat estimatedRowHeight))cpEstimatedRowHeight{
    return ^(CGFloat estimatedRowHeight){
        self.estimatedRowHeight = estimatedRowHeight;
        return self;
    };
}


@end

@implementation UIScrollView (ChainProgramming)

- (UIScrollView * (^)(CGSize))cpContentSize{
    return ^(CGSize size){
        self.contentSize = size;
        return self;
    };
}
- (UIScrollView * (^)(BOOL))cpPagingEnabled{
    return ^(BOOL pageingEnable){
        self.pagingEnabled = pageingEnable;
        return self;
    };
}
- (UIScrollView * (^)(id))cpDelegate{
    return ^(id delegate){
        self.delegate = delegate;
        return self;
    };
}
- (UIScrollView * (^)(BOOL))cpScrollEnabled{
    return ^(BOOL scrollEnabled){
        self.scrollEnabled = scrollEnabled;
        return self;
    };
}

//- (UIScrollView * (^)())cp
//- (UIScrollView * (^)())cp

@end



@implementation UIWindow (ChainProgramming)

- (UIWindow * (^)(UIWindowLevel))cpWindowLevel{
    return ^(UIWindowLevel winLevel){
        self.windowLevel = winLevel;
        return self;
    };
}
- (UIWindow * (^)(void))cpMakeKeyAndVisible{
    return ^(){
        return self;
    };
}
- (UIWindow * (^)(void))cpResignKeyWindow{
    return ^(){
        return self;
    };
}

@end

@implementation UICollectionView (ChainProgramming)

+ (UICollectionView * (^)(UICollectionViewFlowLayout *layout))newCollection{
    return ^(UICollectionViewFlowLayout *layout){
        return [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    };
}


- (UICollectionView * (^)(Class))cpRegisterCellClass{
    return ^(Class class){
        [self registerClass:class forCellWithReuseIdentifier:NSStringFromClass(class)];
        return self;
    };
}
- (UICollectionView * (^)(id))cpDataSource{
    return ^(id dataSource){
        self.delegate = dataSource;
        self.dataSource = dataSource;
        return self;
    };
}
- (UICollectionView * (^)(void))cpAfterReload{
    return ^(){
        return self;
    };
}

- (UICollectionViewCell * (^)(NSString *cellId, NSIndexPath *indexPath))cellWithId{
    return ^(NSString *cellId, NSIndexPath *indexPath){
        return [self dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    };
}

@end

@implementation UICollectionViewCell (ChainProgramming)

//- (UICollectionViewCell * (^)())cp

@end

@implementation UIColor (ChainProgramming)

+ (UIColor * (^)(CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha))cpRGBAlpha{
    return ^(CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha){
        return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha];
    };
}
+ (UIColor * (^)(CGFloat red, CGFloat green, CGFloat blue))cpRGB{
    return ^(CGFloat red, CGFloat green, CGFloat blue){
        return UIColor .cpRGBAlpha(red, green, blue, 1.0f);
    };
}
+ (UIColor * (^)(NSString *hexValue, CGFloat alpha))cpHexAlpha{
    return ^(NSString *hexValue, CGFloat alpha){
        hexValue = [[hexValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
        if ([hexValue length] < 6)
            return [UIColor redColor];
        if ([hexValue hasPrefix:@"0X"])
            hexValue = [hexValue substringFromIndex:2];
        if ([hexValue hasPrefix:@"#"])
            hexValue = [hexValue substringFromIndex:1];
        if ([hexValue length] != 6)
            return [UIColor redColor];
        
        NSRange range;
        range.location = 0;
        range.length = 2;
        NSString *rString = [hexValue substringWithRange:range];
        
        range.location = 2;
        NSString *gString = [hexValue substringWithRange:range];
        
        range.location = 4;
        NSString *bString = [hexValue substringWithRange:range];
        
        unsigned int r, g, b;
        [[NSScanner scannerWithString:rString] scanHexInt:&r];
        [[NSScanner scannerWithString:gString] scanHexInt:&g];
        [[NSScanner scannerWithString:bString] scanHexInt:&b];
        
        if (alpha < 0 || alpha > 1.0)
            alpha = 1.0f;
        
        return UIColor .cpRGBAlpha(r, g, b, alpha);
    };
}
+ (UIColor * (^)(NSString *hexValue))cpHex{
    return ^(NSString *hexValue){
        return UIColor .cpHexAlpha(hexValue, 1.0f);
    };
}

@end

@implementation UIFont (ChainProgramming)

+ (UIFont * (^)(CGFloat fontSize, NSString * fontName))cpNameFont{
    return ^(CGFloat fontSize, NSString * fontName){
        return [UIFont fontWithName:fontName size:WidthScale(fontSize)];
    };
}
+ (UIFont * (^)(CGFloat fontSize, UIFontWeight fontWeight))cpWeightFont{
    return ^(CGFloat fontSize, UIFontWeight fontWeight){
        return [UIFont systemFontOfSize:WidthScale(fontSize) weight:fontWeight];
    };
}
+ (UIFont * (^)(CGFloat fontSize))cpBoldFont{
    return ^(CGFloat fontSize){
        return UIFont .cpWeightFont(fontSize, UIFontWeightBold);
    };
}
+ (UIFont * (^)(CGFloat fontSize))cpFont{
    return ^(CGFloat fontSize){
        return UIFont .cpWeightFont(fontSize, UIFontWeightRegular);
    };
}

@end

@implementation UICollectionViewFlowLayout (ChainProgramming)

- (UICollectionViewFlowLayout * (^)(CGSize size))estimatdItemSize{
    return ^(CGSize size){
        self.estimatedItemSize = size;
        return self;
    };
}
- (UICollectionViewFlowLayout * (^)(NSString *scrollDirection))cpDirection{
    return ^(NSString *scrollDirection){
        if ([scrollDirection isEqualToString:@"-"]) {
            self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        }else{
            self.scrollDirection = UICollectionViewScrollDirectionVertical;
        }
        return self;
    };
}
- (UICollectionViewFlowLayout * (^)(CGFloat vertical, CGFloat horizontal))cpSectionInset{
    return ^(CGFloat vertical, CGFloat horizontal){
        self.minimumLineSpacing = HeightScale(vertical);
        self.minimumInteritemSpacing = WidthScale(horizontal);
        self.sectionInset = UIEdgeInsetsMake( HeightScale(vertical), WidthScale(horizontal), HeightScale(vertical), WidthScale(horizontal));
        return self;
    };
}
@end
