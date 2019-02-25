//
//  FSUnFriendContent.h
//  Ready
//
//  Created by mac on 2018/11/12.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "FSIMBaseModelContent.h"

@interface FSUnFriendContent : FSIMBaseModelContent
@property(nonatomic,assign)NSInteger tipType;

- (NSURL *)getLinkURL;
- (NSRange)getLinkTextRange;
- (NSAttributedString *)getContentDetailAttributedString;
- (NSTextCheckingResult *)linkCheckResult;
@end
