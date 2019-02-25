//
//  FSDanMuGuildView.m
//  Ready
//
//  Created by jiapeng on 2018/10/30.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "FSDanMuGuildView.h"
#import "SVGAPlayer.h"
#import "SVGAParser.h"

@interface FSDanMuGuildView ()
@property (nonatomic ,strong) UILabel *descLabel;
@property (nonatomic ,strong) SVGAPlayer *svgaPlayer;
@property (nonatomic ,strong) SVGAParser *svgaParser;

@end

@implementation FSDanMuGuildView

- (instancetype)init {
    if(self = [super init])
        
    self.backgroundColor =[UIColor clearColor];
    [self addContentView];
    
    return self;
}


-(void)addContentView {
    
    self.descLabel  =[UILabel new];
    self.descLabel.frame =CGRectMake(0, GTFixWidthFlaot(10), ScreenW, GTFixWidthFlaot(20));
    self.descLabel.backgroundColor =[UIColor clearColor];
    self.descLabel.textColor =HexRGB(0x5C4406);
    self.descLabel.textAlignment = NSTextAlignmentCenter;
    self.descLabel.font = [UIFont boldSystemFontOfSize:12];
    self.descLabel.text =[FSSharedLanguages CustomLocalizedStringWithKey:@"WorldCallPage_SlideUpToFold"];;
    [self addSubview:self.descLabel];
    
    _svgaParser = [[SVGAParser alloc] init];
    _svgaPlayer = [[SVGAPlayer alloc] initWithFrame:CGRectMake((ScreenW-GTFixWidthFlaot(60))/2, GTFixWidthFlaot(40), GTFixWidthFlaot(60), GTFixWidthFlaot(100))];
    _svgaPlayer.backgroundColor =[UIColor clearColor];
    [_svgaPlayer setLoops:10000];
    [self addSubview:_svgaPlayer];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"up_slide" ofType:@".svga"];
    NSString *name = [[filePath lastPathComponent] stringByDeletingPathExtension];
    
    __weak typeof(self) weakS = self;
    [self.svgaParser parseWithNamed:name inBundle:[NSBundle mainBundle] completionBlock:^(SVGAVideoEntity * _Nonnull videoItem) {
        [weakS.svgaPlayer setVideoItem:videoItem];
        //[weakS.svgaPlayer startAnimation];
        // 通知开始
    } failureBlock:^(NSError * _Nonnull error) {
        // 通知报错
    }];
    
    [_svgaPlayer startAnimation];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
