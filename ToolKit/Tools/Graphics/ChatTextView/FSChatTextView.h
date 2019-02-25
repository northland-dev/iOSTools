//
//  FSChatTextView.h
//  Ready
//
//  Created by mac on 2018/7/30.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "FSBaseView.h"
#import "GCTextView.h"

@interface FSChatTextView : FSBaseView<UITextViewDelegate>
@property(nonatomic,strong,readonly)NSString *text;
@property(nonatomic,assign)id<UITextViewDelegate>delegate;
@property(nonatomic,strong)GCTextView *textView;

- (void)setDraftText:(NSString *)text;
@end
