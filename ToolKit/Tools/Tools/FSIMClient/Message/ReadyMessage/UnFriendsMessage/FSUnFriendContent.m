//
//  FSUnFriendContent.m
//  Ready
//
//  Created by mac on 2018/11/12.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "FSUnFriendContent.h"

@implementation FSUnFriendContent
- (NSURL *)getLinkURL {
    if (self.tipType == 1) {
        NSString *linkText = [FSSharedLanguages CustomLocalizedStringWithKey:@"ChatPage_FriendsDeletedTipsContained"];;
        return [NSURL URLWithString:linkText];
    }else if (self.tipType == 2){
        NSString *linkText = [FSSharedLanguages CustomLocalizedStringWithKey:@"ChatPage_AgreeToAddContained"];
        return [NSURL URLWithString:linkText];
    }
    NSString *link = [FSSharedLanguages CustomLocalizedStringWithKey:@" "];
    return [NSURL URLWithString:link];
}
- (NSRange)getLinkTextRange{
    NSString *text = @"";
    if (self.tipType == 1) {
        NSString *linkText = [FSSharedLanguages CustomLocalizedStringWithKey:@"ChatPage_FriendsDeletedTipsContained"];
        text = [FSSharedLanguages CustomLocalizedStringWithKey:@"ChatPage_FriendsDeletedTips"];
        return [text rangeOfString:linkText];
    }else if (self.tipType == 2){
        NSString *linkText = [FSSharedLanguages CustomLocalizedStringWithKey:@"ChatPage_AgreeToAddContained"];
        text = [FSSharedLanguages CustomLocalizedStringWithKey:@"ChatPage_AgreeToAdd"];
        return [text rangeOfString:linkText];
    }
    return NSMakeRange(NSNotFound, 0);
}
- (NSAttributedString *)getContentDetailAttributedString {
    NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
    style.lineSpacing = 0;
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:12],
                                 NSForegroundColorAttributeName: HexRGB(0x5C4406),
                                 NSParagraphStyleAttributeName: style};
    
    NSString *text = @"";
    if (self.tipType == 1) {
        text = [FSSharedLanguages CustomLocalizedStringWithKey:@"ChatPage_FriendsDeletedTips"];
    }else if (self.tipType == 2){
        text = [FSSharedLanguages CustomLocalizedStringWithKey:@"ChatPage_AgreeToAdd"];
    }
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
- (NSTextCheckingResult *)linkCheckResult {
    NSRange checkRange = [self getLinkTextRange];
    if (checkRange.location != NSNotFound) {
        return [NSTextCheckingResult spellCheckingResultWithRange:checkRange];
    }
    
    return nil;
}
@end
