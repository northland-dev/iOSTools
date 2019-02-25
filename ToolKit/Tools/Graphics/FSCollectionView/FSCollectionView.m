//
//  FSCollectionView.m
//  Ready
//
//  Created by mac on 2018/7/20.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "FSCollectionView.h"
#import "GTCommont.h"
@interface FSCollectionView()
{
    BOOL _enable;
}
@property (nonatomic, strong) UIImageView   *emptyImageView;
@property (nonatomic, strong) UIView *backView;

@end
@implementation FSCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        
        [self setBackgroundView:self.backView];
        
        [self.emptyImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.top.equalTo(self.mas_top).offset(14);
            make.width.mas_equalTo(GTFixWidthFlaot(100));
            make.height.mas_equalTo(GTFixWidthFlaot(130));
        }];
    }
    return self;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (!_enable) {
        [scrollView setContentOffset:CGPointZero];
        return;
    }
    
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    CGFloat contentSizeHeight = scrollView.contentSize.height;
    CGFloat contentViewHeight = CGRectGetHeight(scrollView.bounds);
    
    if (contentOffsetY >= contentSizeHeight - contentViewHeight) {
        _enable = YES;
    }
    
    if (contentOffsetY < 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kNSNotificationSuperScrollShouldEnable object:nil];
        _enable = NO;
    }

}
- (void)enableSimultaneouslyRecognize:(BOOL)enable {
    _enable = enable;
}
- (void)showEmptyDataView:(BOOL)show {
    [self.emptyImageView setHidden:!show];
}
- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        [_backView setBackgroundColor:[UIColor clearColor]];
    }
    return _backView;
}
- (UIImageView *)emptyImageView {
    if (!_emptyImageView) {
        _emptyImageView = [UIImageView new];
        _emptyImageView.image = GamePlaceHolderImage;
        [_emptyImageView setBackgroundColor:[UIColor clearColor]];
        [_emptyImageView.layer setCornerRadius:12];
        [_emptyImageView.layer setMasksToBounds:YES];
        [self.backView addSubview:_emptyImageView];
    }
    return _emptyImageView;
}
@end
