//
//  UITabBar+SvgaItem.m
//  Ready
//
//  Created by mac on 2019/1/9.
//  Copyright © 2019年 Fission. All rights reserved.
//

#import "UITabBar+SvgaItem.h"
#import "FSTabBarItem.h"
#import "FSSvgaPlayer.h"

@interface UITabBar (SvgaInfo)
@property(nonatomic,strong)NSMutableDictionary *svgaViews;
@property(nonatomic,strong)NSMutableDictionary *svgaPlayers;
@property(nonatomic,strong)UIView *currentPlayer;
@end

@implementation UITabBar (SvgaItem)
@dynamic svgaContainer;

- (void)layoutSvgaContainer {
    [self.svgaContainer setFrame:self.bounds];
    [self.svgaContainer setBackgroundColor:[UIColor redColor]];
    [self.otherContainer addSubview:self.svgaContainer];
}

- (void)playSvgaWithItem:(FSTabBarItem *)item {
    NSUInteger index = [self.items indexOfObject:item];
    NSString *name = item.svgaName;
    [self playSvgaWithName:name atIndex:index];
}

- (void)playSvgaWithName:(NSString *)name atIndex:(NSInteger)index {
    NSUInteger count = self.items.count;
    if (index < 0 || index >= count) {
        return;
    }
    
    // 隐藏前一次的view
    [self.currentPlayer setHidden:YES];

    // 寻找view 适应动态变化的 tabbar
    NSString *viewKey = [NSString stringWithFormat:@"%ld",index];
    FSSvgaPlayer *svgaPlayer = [self svgaPlayerWithViewKey:viewKey];
    UIView *playerView = [self.svgaViews objectForKey:viewKey];
    if (!playerView) {
         playerView = [[UIView alloc] init];
        [self.svgaViews setObject:playerView forKey:viewKey];
        [self.svgaContainer addSubview:playerView];
        
        UIView *player = [svgaPlayer svgePlayerView];
        [playerView addSubview:player];
        
        [player mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(40, 40));
            make.centerX.equalTo(playerView);
            make.centerY.equalTo(playerView);
        }];
        
    }
    
    // update
    CGFloat width = CGRectGetWidth(self.bounds)/count;
    CGFloat height = CGRectGetHeight(self.bounds);
    CGFloat pointX = index * width;
    [playerView setFrame:CGRectMake(pointX, 0, width, height)];
    
    // 将舞台指向新的位置
    self.currentPlayer = playerView;
    [self.currentPlayer setHidden:NO];
    // 播放
    [svgaPlayer playWithPath:name];
}

#pragma mark - setter
- (void)setCurrentPlayer:(UIView *)currentPlayer{
    objc_setAssociatedObject(self, @selector(currentPlayer), currentPlayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark - getter
- (NSMutableDictionary *)svgaViews {
    NSMutableDictionary *svgaViews = objc_getAssociatedObject(self, _cmd);
    if (!svgaViews) {
        svgaViews = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, _cmd, svgaViews, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return svgaViews;
}
-(UIView *)svgaContainer {
    UIView *container = objc_getAssociatedObject(self, _cmd);
    if (!container) {
        container = [[UIView alloc] init];
//        [container setBackgroundColor:HexRGBAlpha(0xffffff, 1)];
        [container setFrame:self.bounds];
        [container setBackgroundColor:[UIColor clearColor]];
        [self.otherContainer addSubview:container];
        objc_setAssociatedObject(self,_cmd, container, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return container;
}
- (UIView *)currentPlayer {
    return objc_getAssociatedObject(self, _cmd);
}
- (NSMutableDictionary *)svgaPlayers {
    NSMutableDictionary *svgaPlayers = objc_getAssociatedObject(self, _cmd);
    if (!svgaPlayers) {
        svgaPlayers = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, _cmd, svgaPlayers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return svgaPlayers;
}
- (FSSvgaPlayer *)svgaPlayerWithViewKey:(NSString *)viewKey {
    FSSvgaPlayer *svgaPlayer = [self.svgaPlayers objectForKey:viewKey];
    if (!svgaPlayer) {
        svgaPlayer = [self svgaPlayer];
        [self.svgaPlayers setObject:svgaPlayer forKey:viewKey];
    }
    return svgaPlayer;
}
- (FSSvgaPlayer *)svgaPlayer {
    FSSvgaPlayer *svgaPlayer = [[FSSvgaPlayer alloc] init];
    svgaPlayer.loopCount = 1;
    svgaPlayer.shouldRemainOnFinish = YES;
    return svgaPlayer;
}

@end
