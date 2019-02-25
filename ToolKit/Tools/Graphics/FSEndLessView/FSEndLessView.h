//
//  FSEndLessView.h
//  Ready
//
//  Created by mac on 2019/1/10.
//  Copyright © 2019年 Fission. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSEndLessCell.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,FSEndLessViewStyle){
    FSEndLessViewStyleVertical,
    FSEndLessViewStyleHorizontal,
};

@class FSEndLessView;
@protocol FSEndLessViewDataSource,FSEndLessViewDelegate;
@interface FSEndLessView : UIView <UIScrollViewDelegate>

@property(nonatomic,strong,readonly)UIScrollView *contentView;
// default FSEndLessViewStyleVertical
@property(nonatomic,assign,readonly)FSEndLessViewStyle style;
//
@property(nonatomic,assign)id<FSEndLessViewDelegate> delegate;
@property(nonatomic,assign)id<FSEndLessViewDataSource> dataSource;
@property(nonatomic,assign)BOOL disableEndless;
- (void)setBeginIndex:(NSInteger)index;

- (instancetype)initWithFrame:(CGRect)frame style:(FSEndLessViewStyle)style;

- (void)createSubviews NS_REQUIRES_SUPER;

// 刷新可视视图   会调用 FSEndLessViewDataSource 的方法
- (void)reload NS_REQUIRES_SUPER;

- (nullable __kindof FSEndLessCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier;

// TODO:
- (__kindof FSEndLessCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier forInfoIndex:(NSInteger)InfoIndex;

@end

@protocol FSEndLessViewDelegate <UIScrollViewDelegate>

@optional
- (void)endLessViewWillChangeToIndex:(NSInteger)infoIndex changeProgress:(CGFloat)progress;
- (void)endLessViewDidChangeToIndex:(NSInteger)infoIndex;
@end

@protocol FSEndLessViewDataSource <NSObject>

@optional
- (NSUInteger)numberOfLessViewContent:(FSEndLessView *)endLessView;
/**
 @param InfoIndex 0 ~ Count
 */
- (FSEndLessCell *)endLessView:(FSEndLessView *)endLessView viewForInfoIndex:(NSInteger)InfoIndex;

@end

NS_ASSUME_NONNULL_END
