//
//  FSEndLessCell.h
//  Ready
//
//  Created by mac on 2019/1/10.
//  Copyright © 2019年 Fission. All rights reserved.
//

#import "FSBaseView.h"
NS_ASSUME_NONNULL_BEGIN

@interface FSEndLessCell : FSBaseView

@property(nonatomic,readonly,copy,nullable)NSString *reuseIdentifier;

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;
- (void)prepareForReuse NS_REQUIRES_SUPER;

// TODO:
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier forInfoIndex:(NSInteger)infoIndex;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)new NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
@end

NS_ASSUME_NONNULL_END
