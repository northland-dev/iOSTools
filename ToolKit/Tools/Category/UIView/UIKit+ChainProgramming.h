//
//  UIKit+ChainProgramming.h
//  Link
//
//  Created by luyee on 2018/8/3.
//  Copyright © 2018年 luyee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ChainProgramming)

- (UIView * (^)(UIColor *))cp_borderColor;
- (UIView * (^)(CGFloat))cp_borderWidth;
- (UIView * (^)(NSInteger cornerValue, CGFloat radius))cp_BezierCornerRadius;    // cornerValue = 1111 上左 上右 下左 下右
- (UIView * (^)(CGFloat))cp_cornerRadius;
- (UIView * (^)(UIColor *))cpBgColor;
- (UIView * (^)(BOOL))cpHidden;
- (UIView * (^)(NSInteger))cpTag;
- (UIView * (^)(CGRect))cpFrame;
- (UIView * (^)(CGPoint))cpCenter;
- (UIView * (^)(BOOL))cpUserInteractionEnabled;
- (UIView * (^)(UIView *))cpAdd;
- (UIView * (^)(UIView *))cpRemove;
- (UIView * (^)(BOOL))cpClips;

@end

@interface UILabel (ChainProgramming)

- (UILabel * (^)(NSString *))cpTxt;
- (UILabel * (^)(UIColor *))cpTxtColor;
- (UILabel * (^)(UIFont *))cpFont;
- (UILabel * (^)(NSTextAlignment))cpTxtAlignment;
- (UILabel * (^)(NSInteger))cpLinesNumber;
- (UILabel * (^)(NSArray <NSString *>*strArr, NSArray <UIFont *>*fontArr, NSArray <UIColor *>*colorArr))setupStrings_Fonts_Colors;
//- (UIView * (^)())cp;
//- (UIView * (^)())cp;
//- (UIView * (^)())cp;


@end

@interface UIButton (ChainProgramming)

+ (UIButton *)cpNew;        // 以类型设置方法开始
- (UIButton * (^)(UIFont *))cpFont;
- (UIButton * (^)(id, SEL))cpTouchUpInsideEvent;
- (UIButton * (^)(BOOL))cpSelected;
- (UIButton * (^)(CGFloat))cpTitleImageEdgeInsets;

- (UIButton * (^)(NSString *))cpTitleNormal;
- (UIButton * (^)(NSString *))cpTitleSelected;
- (UIButton * (^)(NSString *))cpTitleDisabled;
- (UIButton * (^)(UIColor *))cpTitleColorNormal;
- (UIButton * (^)(UIColor *))cpTitleColorSelected;
- (UIButton * (^)(UIColor *))cpTitleColorHighlighted;
- (UIButton * (^)(UIColor *))cpTitleColorDisabled;
- (UIButton * (^)(UIImage *))cpBgImageNormal;
- (UIButton * (^)(UIImage *))cpBgImageSelected;
- (UIButton * (^)(UIImage *))cpBgImageHighLighted;
- (UIButton * (^)(UIImage *))cpBgImageDisabled;
- (UIButton * (^)(UIImage *))cpImageNormal;
- (UIButton * (^)(UIImage *))cpImageSelected;
- (UIButton * (^)(UIImage *))cpImageHighLighted;
- (UIButton * (^)(UIImage *))cpImageDisabled;

@end

@interface UIImage (ChainProgramming)

+ (UIImage *(^)(UIColor *, UIColor *))cpColorChangeImg;

+ (UIImage *(^)(UIColor *, CGSize))cpColorImg;

+ (UIImage * (^)(NSString *))cpWithName;
//- (UIImage * (^)())cp;
//- (UIImage * (^)())cp;

@end


@interface UIImageView (ChainProgramming)

- (UIImageView * (^)(UIImage *))cpImage;
//- (UIImageView * (^)())cp;
//- (UIImageView * (^)())cp;

@end

@interface UITextView (ChainProgramming)

//- (UITextView * (^)())cp;

@end

@interface UITextField (ChainProgramming)

//- (UITextField * (^)())cp;

@end

@interface UITableView (ChainProgramming)

- (UITableView * (^)(Class))cpRegisterCellClass;     // cell的id就是register class的名字
- (UITableView * (^)(UITableViewCellSeparatorStyle))cpSeparatorStyle;
- (UITableView * (^)(UIColor *))cpSeparatorColor;
- (UITableView * (^)(id))cpDataSource;
- (UITableView * (^)(BOOL))cpHasFooterView;
- (UITableView * (^)(void))cpAfterReload;
- (UITableViewCell * (^)(NSString *))cellWithId;
- (UITableView * (^)(CGFloat estimatedRowHeight))cpEstimatedRowHeight;

@end

@interface UIScrollView (ChainProgramming)

- (UIScrollView * (^)(CGSize))cpContentSize;
- (UIScrollView * (^)(BOOL))cpPagingEnabled;
- (UIScrollView * (^)(id))cpDelegate;
- (UIScrollView * (^)(BOOL))cpScrollEnabled;

//- (UIScrollView * (^)())cp;
//- (UIScrollView * (^)())cp;

@end



@interface UIWindow (ChainProgramming)

- (UIWindow * (^)(UIWindowLevel))cpWindowLevel;
- (UIWindow * (^)(void))cpMakeKeyAndVisible;
- (UIWindow * (^)(void))cpResignKeyWindow;

@end

@interface UICollectionView (ChainProgramming)

+ (UICollectionView * (^)(UICollectionViewFlowLayout *layout))newCollection;
- (UICollectionView * (^)(Class))cpRegisterCellClass;
- (UICollectionView * (^)(id))cpDataSource;
- (UICollectionView * (^)(void))cpAfterReload;
- (UICollectionViewCell * (^)(NSString *cellId, NSIndexPath *indexPath))cellWithId;

@end

@interface UICollectionViewCell (ChainProgramming)

//- (UICollectionViewCell * (^)())cp;

@end


@interface UIColor (ChainProgramming)

+ (UIColor * (^)(CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha))cpRGBAlpha;
+ (UIColor * (^)(CGFloat red, CGFloat green, CGFloat blue))cpRGB;
+ (UIColor * (^)(NSString *hexValue, CGFloat alpha))cpHexAlpha;
+ (UIColor * (^)(NSString *hexValue))cpHex;

@end

@interface UIFont (ChainProgramming)

+ (UIFont * (^)(CGFloat fontSize, NSString * fontName))cpNameFont;
+ (UIFont * (^)(CGFloat fontSize, UIFontWeight fontWeight))cpWeightFont;
+ (UIFont * (^)(CGFloat fontSize))cpBoldFont;
+ (UIFont * (^)(CGFloat fontSize))cpFont;

@end

@interface UICollectionViewFlowLayout (ChainProgramming)

- (UICollectionViewFlowLayout * (^)(CGSize size))estimatdItemSize;
- (UICollectionViewFlowLayout * (^)(NSString *scrollDirection))cpDirection;
- (UICollectionViewFlowLayout * (^)(CGFloat vertical, CGFloat horizontal))cpSectionInset;

@end
