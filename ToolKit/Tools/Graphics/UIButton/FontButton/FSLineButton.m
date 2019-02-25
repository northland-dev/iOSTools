//
//  FSLineButton.m
//  Ready
//
//  Created by mac on 2018/12/25.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "FSLineButton.h"
@interface FSLineButton()
@property(nonatomic,strong)UILabel *textLabel;
@property(nonatomic,strong)UIView *line;
@property(nonatomic,strong)NSMutableDictionary *fontInfo;
@property(nonatomic,strong)NSMutableDictionary *titleInfo;
@end
@implementation FSLineButton

- (instancetype)init {
    if (self = [super init]) {
        [self createSubviews];
    }
    return self;
}
- (void)createSubviews {
    WS(weaks);
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weaks);
        make.width.mas_lessThanOrEqualTo(180);
        make.bottom.equalTo(weaks);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weaks);
        make.width.mas_equalTo(48);
        make.bottom.equalTo(weaks).offset(5);
        make.height.mas_equalTo(5);
    }];
    
    [self setClipsToBounds:NO];
    [self.line setHidden:YES];

}

- (void)setLineColor:(UIColor *)color {
    [self.line setBackgroundColor:color];
}
- (void)setFont:(UIFont *)font forState:(UIControlState)state {
    if (state == self.state) {
        [self.textLabel setFont:font];
    }
    
    [self.fontInfo setObject:font forKey:[NSString stringWithFormat:@"%ld",state]];
}
- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    
    [self.line setHidden:!selected];
    
    NSAttributedString *attrNormal = [self.titleInfo objectForKey:@"normal"];
    NSAttributedString *attrSelect = [self.titleInfo objectForKey:@"select"];
    if (selected) {
        [self.textLabel setAttributedText:attrSelect];
    }else{
        [self.textLabel setAttributedText:attrNormal];
    }
}
- (void)setTitle:(NSString *)title {
    NSDictionary *normalAttr = [self normalTitleAttribute];
    NSDictionary *selectAttr = [self seletedTitleAttribute];
    NSAttributedString *normalAttrText = [[NSAttributedString alloc] initWithString:title attributes:normalAttr];
    NSAttributedString *selectAttrText = [[NSAttributedString alloc] initWithString:title attributes:selectAttr];
    
    [self.titleInfo setObject:normalAttrText forKey:@"normal"];
    [self.titleInfo setObject:selectAttrText forKey:@"select"];
    
    [self.textLabel setAttributedText:normalAttrText];
}
#pragma mark - public attr
- (NSDictionary *)normalTitleAttribute {
    UIFont *font = [UIFont systemFontOfSize:16];
    UIColor *textColor = HexRGB(0x9D8F6A);
    return @{NSFontAttributeName:font,NSForegroundColorAttributeName:textColor};
}
- (NSDictionary *)seletedTitleAttribute {
    UIFont *font = [UIFont boldSystemFontOfSize:20];
    UIColor *textColor = HexRGB(0x5C4406);
    return @{NSFontAttributeName:font,NSForegroundColorAttributeName:textColor};
}
#pragma mark - getter
- (UIView *)line {
    if (!_line) {
         _line = [[UIView alloc] init];
        [_line setUserInteractionEnabled:NO];
        [_line.layer setCornerRadius:2.5];
        [_line.layer setMasksToBounds:YES];
        [_line setBackgroundColor:HexRGB(0xFCDA16)];
        [self addSubview:_line];
    }
    return _line;
}
- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] init];
        [self addSubview:_textLabel];
    }
    return _textLabel;
}
- (NSMutableDictionary *)fontInfo {
    if (!_fontInfo) {
        _fontInfo = [NSMutableDictionary dictionary];
    }
    return _fontInfo;
}
- (NSMutableDictionary *)titleInfo {
    if (!_titleInfo) {
        _titleInfo = [NSMutableDictionary dictionary];
    }
    return _titleInfo;
}
@end
