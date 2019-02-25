//
//  FSGlobalEmptyDataView.m
//  Ready
//
//  Created by gongruike on 2018/9/3.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "FSGlobalEmptyDataView.h"

@implementation FSGlobalEmptyDataView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundLayer = [CAGradientLayer layer];
        [self.backgroundLayer setStartPoint:CGPointMake(0.5, 0)];
        [self.backgroundLayer setEndPoint:CGPointMake(0.5, 1)];
        [self.backgroundLayer setColors:[NSArray arrayWithObjects:(__bridge id)HexRGBAlpha(0xF8C22D, 1.0).CGColor,(__bridge id)HexRGBAlpha(0xFFF100,1.0).CGColor,nil]];
        [self.layer addSublayer:self.backgroundLayer];
        
        self.titleLabel = [UILabel new];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.titleLabel];
        
        self.imageView = [UIImageView new];
        self.imageView.image = [UIImage imageNamed:@"noContent"];
        [self addSubview:self.imageView];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(80);
            make.centerX.equalTo(self.mas_centerX);
            make.width.lessThanOrEqualTo(self.mas_width).multipliedBy(0.9);
        }];
        
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.bottom.equalTo(self.mas_bottom);
            make.width.mas_equalTo(375);
            make.height.mas_equalTo(400);
        }];
        
        [self setTitleString:[FSSharedLanguages CustomLocalizedStringWithKey:@"AllPage_NoRankingYet"]];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.backgroundLayer.frame = self.bounds;
}

#pragma mark - public methods
- (void)setTitleString:(NSString *)string {
    if (![string length]) {
        return;
    }
    NSDictionary *attributes = @{
                                 NSFontAttributeName: [UIFont boldSystemFontOfSize:20],
                                 NSForegroundColorAttributeName: HexRGB(0x5C4406)
                                 };
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:string attributes:attributes];
    self.titleLabel.attributedText = attributedString;
}

@end
