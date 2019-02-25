//
//  GCTextView.h
//  7nujoom
//
//  Created by Charles on 9/6/16.
//  Copyright © 2016 Fission. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GCTextView : UITextView<UITextViewDelegate>
@property(nonatomic,assign)NSInteger limitedNumber;
@property(nonatomic,strong)NSString *placeHolderText;
@property(nonatomic,strong)UIColor *placeHolderColor;
@property(nonatomic,strong)UIFont *placeHolderFont;

- (void)setPlaceHolderMoreLines;
@end
