//
//  GCCornerImageView.h
//  Ready
//
//  Created by mac on 2018/12/21.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GCCornerImageView : UIImageView{
    CAShapeLayer *_shapeLayer;
    CAShapeLayer *_maskLayer;
}
@property(nonatomic,assign)CGFloat cornerRadius;
@property(nonatomic,assign)CGFloat lineWidth;

@end

NS_ASSUME_NONNULL_END
