//
//  FSIMSystemContent.m
//  Ready
//
//  Created by gongruike on 2018/9/17.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "FSIMSystemContent.h"

@implementation FSIMSystemContent

#pragma mark - list
- (UIImage *)getSummaryImage {
    return [UIImage imageNamed:@"AppIcon"];
}

- (NSString *)getSummaryTitleString {
    return [FSSharedLanguages CustomLocalizedStringWithKey:@"Ready"];
}

- (NSString *)getSummaryContentString {
    return [self.content stringForKey:[FSSharedLanguages SharedLanguage].language];
}

#pragma mark - detail
- (NSString *)getContentTitleString {
    return [self.titleContent stringForKey:[FSSharedLanguages SharedLanguage].language];
}

- (NSString *)getContentDetailString {
    NSString *detailString = [self.content stringForKey:[FSSharedLanguages SharedLanguage].language];
    if ([self shouldAddLink]) {
        detailString = [NSString stringWithFormat:@"%@ %@", detailString, [self getLinkTextString]];
    }
    return detailString?:@" ";
}

- (NSString *)getContentImageURLString {
    return [NSString stringWithFormat:@"%@%@", ImageResourceUrl, self.image];
}

- (NSAttributedString *)getContentDetailAttributedString {
    NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
    style.lineSpacing = 2;
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14],
                                 NSForegroundColorAttributeName: HexRGB(0x5C4406),
                                 NSParagraphStyleAttributeName: style};
    return [[NSAttributedString alloc] initWithString:[self getContentDetailString] attributes:attributes];
}

- (BOOL)shouldAddLink {
    if (self.systemTemplate == 2 || self.systemTemplate == 10) {
        return YES;
    }
    return NO;
}

- (NSRange)getLinkTextRange {
    NSString *systemContentString = [self getContentDetailString];
    NSString *linkTextString = [self getLinkTextString];
    if (!linkTextString) {
        return NSMakeRange(NSNotFound, 0);
    }
    return [systemContentString rangeOfString:linkTextString];
}

- (NSString *)getLinkTextString {
    if (self.systemTemplate == 10)
        return @"Click Here";
    else
        return [self.linkContent stringForKey:[FSSharedLanguages SharedLanguage].language];
}

- (NSURL *)getLinkURL {
    return [NSURL URLWithString:self.link];
}

@end
