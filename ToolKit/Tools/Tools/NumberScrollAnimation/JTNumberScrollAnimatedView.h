//
//  JTNumberScrollAnimatedView.h
//  JTNumberScrollAnimatedView
//
//  Created by Jonathan Tribouharet
//

#import <UIKit/UIKit.h>

@interface JTNumberScrollAnimatedView : UIView

//@property (strong, nonatomic) NSNumber *value;
@property (strong, nonatomic) NSString *value;

@property (strong, nonatomic) UIColor *textColor;
@property (strong, nonatomic) UIFont *font;
@property (assign, nonatomic) CFTimeInterval duration;
@property (assign, nonatomic) CFTimeInterval durationOffset;
@property (assign, nonatomic) NSUInteger density;//旋转周期
@property (assign, nonatomic) NSUInteger minLength;//最短数字长度
@property (assign, nonatomic) BOOL isAscending;//是否上升旋转

- (void)startAnimation;
- (void)stopAnimation;

@end
