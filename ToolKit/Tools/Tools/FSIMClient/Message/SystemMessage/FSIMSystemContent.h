//
//  FSIMSystemContent.h
//  Ready
//
//  Created by gongruike on 2018/9/17.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "FSIMBaseModelContent.h"

@interface FSIMSystemContent : FSIMBaseModelContent

// 1、图片
// 2、链接
// 3、普通文本
// 10、跳转到profile页面
// 11 jackpot
@property (nonatomic, assign) NSInteger      systemTemplate;  //类型11是奖池

@property (nonatomic, strong) NSString      *image;           //11是奖池 生效奖励类型0金币 1是钻石

@property (nonatomic, strong) NSString      *link; // 地址     //11是奖池 生效奖励数量
@property (nonatomic, strong) NSDictionary  *linkContent;

@property (nonatomic, strong) NSDictionary  *titleContent; // 标题
@property (nonatomic, strong) NSDictionary  *content; // 具体内容

// 最近聊天列表界面
- (UIImage *)getSummaryImage;
- (NSString *)getSummaryTitleString;
- (NSString *)getSummaryContentString;

// 聊天详情界面
- (NSString *)getContentTitleString;
- (NSString *)getContentDetailString;
- (NSString *)getContentImageURLString;

- (NSAttributedString *)getContentDetailAttributedString;

// 链接相关方法
- (BOOL)shouldAddLink;
- (NSRange)getLinkTextRange;
- (NSString *)getLinkTextString;
- (NSURL *)getLinkURL;

@end
