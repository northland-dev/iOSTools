//
//  FSCollectionView.h
//  Ready
//
//  Created by mac on 2018/7/20.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FSScrollView;
@interface FSCollectionView : UICollectionView<UIGestureRecognizerDelegate,UIScrollViewDelegate>
- (void)enableSimultaneouslyRecognize:(BOOL)enable;

- (void)showEmptyDataView:(BOOL)show;
@end
