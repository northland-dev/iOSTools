//
//  FSEndLessView.m
//  Ready
//
//  Created by mac on 2019/1/10.
//  Copyright © 2019年 Fission. All rights reserved.
//

#import "FSEndLessView.h"
static NSString *NullReuseIdentifierKey = @"nullReuseIdentifierKey";
typedef NS_ENUM(NSInteger,FSEndLessViewDirection){
    FSEndLessViewDirectionNone,
    FSEndLessViewDirectionForent = -1,
    FSEndLessViewDirectionBehind = 1,
};

struct FSEndLessScrollState {
    CGFloat offset;
    FSEndLessViewDirection direct;
    CGFloat stepSize;
};

@interface FSEndLessViewContanier : UIView
@property(nonatomic,strong)FSEndLessCell *cell;
@property(nonatomic,assign)NSInteger cellIndex;
@end
@implementation FSEndLessViewContanier
- (void)addSubview:(UIView *)view {
    [super addSubview:view];
    
    if ([view isKindOfClass:[FSEndLessCell class]]) {
        _cell = (FSEndLessCell *)view;
    }
    __weak typeof(self) weaks = self;
    // 类似UITableViewCell的放置
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weaks);
    }];
}
@end


@interface FSEndLessView(){
    NSInteger _contentsCount;
    NSInteger _currentIndex;
    UIScrollView *_contentView;
    CGPoint _startDragOffset;
}
// beforeIndex & behindIndex 在 _contentsCount 大于等于 2
@property(nonatomic,assign)NSInteger beforeIndex;
@property(nonatomic,assign)NSInteger behindIndex;

@property(nonatomic,strong)FSEndLessViewContanier *beforeContainer;
@property(nonatomic,strong)FSEndLessViewContanier *centerContainer;
@property(nonatomic,strong)FSEndLessViewContanier *behindContainer;

@property(nonatomic,strong)UIView *contentContainer;
@property(nonatomic,strong)NSMutableDictionary<NSString *,NSMutableSet *> *unVisiableCellDict;
@property(nonatomic,strong)NSMutableDictionary<NSString *,FSEndLessCell *> *visiableCellDict;
@property(nonatomic,strong)NSMutableArray *visiableCells;
@end
@implementation FSEndLessView

#pragma mark - initialize
- (instancetype)init {
    if (self = [super init]) {
        // default
        _style = FSEndLessViewStyleVertical;
        [self createSubviews];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _style = FSEndLessViewStyleVertical;
        [self createSubviews];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame style:(FSEndLessViewStyle)style {
    if (self = [super initWithFrame:frame]) {
        _style = style;
        [self createSubviews];
    }
    return self;
}
#pragma mark - defaultLayout
- (void)createSubviews{
    
    __weak typeof(self) weaks = self;
    // 
//    [self addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weaks);
    }];
    
    if (_style == FSEndLessViewStyleVertical) {
        
        [self.contentContainer mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weaks.contentView);
            make.width.equalTo(weaks.contentView);
            make.height.equalTo(weaks.contentView).multipliedBy(3);
        }];
        
        [self.beforeContainer mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weaks.contentContainer.mas_top);
            make.left.width.height.equalTo(weaks);
        }];
        
        [self.centerContainer mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weaks.beforeContainer.mas_bottom);
            make.left.width.height.equalTo(weaks);
        }];

        [self.behindContainer mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weaks.centerContainer.mas_bottom);
            make.left.width.height.equalTo(weaks);
        }];
        
    }else{
        
        [self.contentContainer mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weaks.contentView);
            make.width.equalTo(weaks.contentView).multipliedBy(3);
            make.height.equalTo(weaks.contentView);
        }];
        [self.beforeContainer mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.width.height.equalTo(weaks);
            make.left.equalTo(weaks.contentContainer.mas_left);
        }];

        [self.centerContainer mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.width.height.equalTo(weaks);
            make.left.equalTo(weaks.beforeContainer.mas_right);
        }];

        [self.behindContainer mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.width.height.equalTo(weaks);
            make.left.equalTo(weaks.centerContainer.mas_right);
        }];

    }
    [self setDisableEndless:YES];
    [self reload];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (_style == FSEndLessViewStyleVertical) {
        [self.contentView setContentOffset:CGPointMake(0, CGRectGetHeight(self.bounds))];
    }else{
        [self.contentView setContentOffset:CGPointMake(CGRectGetWidth(self.bounds),0)];
    }
}
#pragma mark -
#pragma mark - public
- (void)setBeginIndex:(NSInteger)index {
    _currentIndex = index;
}
- (void)setDisableEndless:(BOOL)disableEndless {
    if (disableEndless) {
        [self.contentView setBounces:NO];
    }
    _disableEndless = disableEndless;
}

- (void)reload {
    
    if ([self.dataSource respondsToSelector:@selector(numberOfLessViewContent:)]) {
       _contentsCount = [self.dataSource numberOfLessViewContent:self];
    }
    
    if (_contentsCount <= 1) {
        // 取消滚动
        [self.contentView setScrollEnabled:NO];
    }else{
        [self.contentView setScrollEnabled:YES];
    }
    
    if (_contentsCount <= 0) {
        return;
    }
    
//    [self setUnVisiableCellDictInfos];
    
    [self setContainerContent:self.centerContainer withIndex:_currentIndex];

    if (_contentsCount <= 1) {
        return;
    }
    
    if (self.beforeIndex != _currentIndex) {
        [self setContainerContent:self.beforeContainer withIndex:self.beforeIndex];
    }
    
    if (self.behindIndex != _currentIndex) {
        [self setContainerContent:self.behindContainer withIndex:self.behindIndex];
    }
    
    [self setVisiableCellInfos];
}
- (FSEndLessCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier {
    NSMutableSet *cellSet = [self cellSetWithIdentifier:identifier];
    FSEndLessCell *cell = [cellSet anyObject];
    if (cell) {
        // 被使用了
        [cell prepareForReuse];
        [cellSet removeObject:cell];
    }
    return cell;
}
#pragma mark - private
// for more
- (void)setContainerContent:(FSEndLessViewContanier *)container withIndex:(NSInteger)index{
    /**
     视图放入容器中 即放入可视视图字典
     放入循环池的时机
     加载下一个时 复用可视视图中的2个视图 创建一个新的 旧的一个放入循环池
     */
    // 复用可视视图
    // 将当前的视图归拢可视视图
    // visiableCell 已包含所有的可视cell
    // 不可见复用池中放入了cell 准备复用
    // 可视列表中未被使用到的cell ？
    // 先从可视列表中找
    FSEndLessCell *cell = [self visiableCellWithIndex:index];
    if (cell) {
        // 可视列表的cell 从不可见移除
        NSMutableSet *cellSet = [self cellSetWithIdentifier:cell.reuseIdentifier];
        if ([cellSet containsObject:cell]) {
            [cellSet removeObject:cell];
        }
        
        [container addSubview:cell];
        // 更新索引
        [container setCellIndex:index];
        [self setVisiableCell:cell WithIndex:index];
    }else if ([self.dataSource respondsToSelector:@selector(endLessView:viewForInfoIndex:)]) {
        //  可视列表不包含 则去创建 或者 从不可见视图中获取
        FSEndLessCell *cell = [self.dataSource endLessView:self viewForInfoIndex:index];
        [container addSubview:cell];
        [container setCellIndex:index];
        [self setVisiableCell:cell WithIndex:index];
    }
}
- (void)setVisiableCell:(FSEndLessCell *)cell WithIndex:(NSInteger)index {
    if (cell) {
        NSString *key = [NSString stringWithFormat:@"%ld",index];
        [self.visiableCellDict setObject:cell forKey:key];
    }
}
- (FSEndLessCell *)visiableCellWithIndex:(NSInteger)index {
    NSString *key = [NSString stringWithFormat:@"%ld",index];
    FSEndLessCell *cell = [self.visiableCellDict objectForKey:key];
    return cell;
    
}
- (void)reuseEndLessContainerCell:(FSEndLessViewContanier *)container {
    FSEndLessCell *cell = container.cell;
    if (cell) {
        NSMutableSet *cellSet = [self cellSetWithIdentifier:cell.reuseIdentifier];
        [cellSet addObject:cell];
        [cell removeFromSuperview];
    }
}
- (NSMutableSet *)cellSetWithIdentifier:(NSString *)identifier {
    NSString *key = identifier;
    if (!identifier) {
        key = NullReuseIdentifierKey;
    }
    NSMutableSet *cellSet = [self.unVisiableCellDict objectForKey:key];
    if (!cellSet) {
        cellSet = [NSMutableSet set];
        [self.unVisiableCellDict setObject:cellSet forKey:key];
    }
    return cellSet;
}
- (NSInteger)beforeIndex {
    if (_contentsCount <= 1) {
        _beforeIndex = 0;
        return _beforeIndex;
    }
    if (_currentIndex <= 0) {
        _beforeIndex = _contentsCount - 1;
    }else{
        _beforeIndex = _currentIndex - 1;
    }
    
    return _beforeIndex;
}
- (NSInteger)behindIndex {
    if (_contentsCount <= 1) {
        _behindIndex = 0;
        return _behindIndex;
    }
    if (_currentIndex >= _contentsCount - 1) {
        _behindIndex = 0;
    }else{
        _behindIndex = _currentIndex + 1;
    }
    return _behindIndex;
}

- (void)setContainerInfos {
    // 放入复用池
//    [self setUnVisiableCellDictInfos];
    
    if (_contentsCount <= 0) {
        return;
    }

    [self setContainerContent:self.centerContainer withIndex:_currentIndex];
    
    if (_contentsCount <= 1) {
        return;
    }
    
    if (self.beforeIndex != _currentIndex) {
        [self setContainerContent:self.beforeContainer withIndex:self.beforeIndex];
    }
    
    if (self.behindIndex != _currentIndex) {
        [self setContainerContent:self.behindContainer withIndex:self.behindIndex];
    }
    
    [self setVisiableCellInfos];
}
// 更新不可见视图列表
- (void)setUnVisiableCellDictInfos {
    // 放入复用池
    [self reuseEndLessContainerCell:self.centerContainer];
    [self reuseEndLessContainerCell:self.beforeContainer];
    [self reuseEndLessContainerCell:self.behindContainer];
}
// 更新可视列表的信息
- (void)setVisiableCellInfos {
    NSString *current = [NSString stringWithFormat:@"%ld",_currentIndex];
    NSString *before = [NSString stringWithFormat:@"%ld",self.beforeIndex];
    NSString *behind = [NSString stringWithFormat:@"%ld",self.behindIndex];
    
    [self.visiableCellDict removeObjectsForKeys:@[before,current,behind]];
    // 放回复用池
    NSArray *objects = [self.visiableCellDict allValues];
    for (FSEndLessCell *cell in objects) {
        NSMutableSet *set = [self cellSetWithIdentifier:cell.reuseIdentifier];
        [set addObject:cell];
        [cell removeFromSuperview];
    }
    [self.visiableCellDict removeAllObjects];
    
    [self.visiableCellDict setObject:self.centerContainer.cell forKey:current];
    [self.visiableCellDict setObject:self.beforeContainer.cell forKey:before];
    [self.visiableCellDict setObject:self.behindContainer.cell forKey:behind];

}
- (void)adjustDisabledContentOffset{
    if (_style == FSEndLessViewStyleHorizontal) {
        // 水平
        [_contentView setContentOffset:CGPointMake(CGRectGetWidth(_contentView.bounds), 0)];
    }else{
        // 竖向
        [_contentView setContentOffset:CGPointMake(0,CGRectGetHeight(_contentView.bounds))];
    }
}
#pragma mark - delegates
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (scrollView.decelerating) {
        // 不处理
        return;
    }
    _startDragOffset = scrollView.contentOffset;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    struct FSEndLessScrollState state = [self scrollStateWithScrollView:scrollView];
    
    CGFloat offset = state.offset;
    CGFloat stepSize = state.stepSize;
    FSEndLessViewDirection direct = state.direct;
    
    if (stepSize == 0) {
        // scrollView 未初始化完毕
        return;
    }
 
    NSInteger willChangeToIndex = [self indexWithDirection:direct];
    CGFloat progress = fabs(offset/stepSize);
    
    if (progress > 1.0) {
        // undefine operation
        // 未定义操作
        progress = progress - 1.0;
        if (direct == FSEndLessViewDirectionBehind) {
            NSInteger currentIndex = _currentIndex;
            _currentIndex = self.behindIndex;
            willChangeToIndex = [self indexWithDirection:direct];
            // 还原
            _currentIndex = currentIndex;
            
        }else{
            NSInteger currentIndex = _currentIndex;
            _currentIndex = self.beforeIndex;
            willChangeToIndex = [self indexWithDirection:direct];
            // 还原
            _currentIndex = currentIndex;
        }
    }
    
    if (direct != FSEndLessViewDirectionNone) {
        NSLog(@"gc ----方向(%ld) 进度(%f) 将要去的index(%ld)",direct,progress,willChangeToIndex);
        if ([_delegate respondsToSelector:@selector(endLessViewWillChangeToIndex:changeProgress:)]) {
            [_delegate endLessViewWillChangeToIndex:willChangeToIndex changeProgress:progress];
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    struct FSEndLessScrollState state = [self scrollStateWithScrollView:scrollView];

//    CGFloat offset = state.offset;
    CGFloat stepSize = state.stepSize;
    FSEndLessViewDirection direct = state.direct;
    CGPoint contentOffset = scrollView.contentOffset;
    
    // 修正位置
    NSInteger nextIndex = _currentIndex;
    CGFloat shouldOffset = 0;
    if (_style == FSEndLessViewStyleHorizontal) {
        CGFloat maxOffsetX = scrollView.contentSize.width - CGRectGetWidth(scrollView.bounds);
        // 水平方向调整
        if (contentOffset.x < 0) {
            // 向左移动
            shouldOffset = contentOffset.x + stepSize;
            //
            nextIndex = self.beforeIndex;
        }else if(contentOffset.x > maxOffsetX){
            // 向右移动
            shouldOffset = contentOffset.x - stepSize;
            nextIndex = self.behindIndex;
        }else{
//            [scrollView setContentOffset:CGPointMake(CGRectGetWidth(self.bounds),0)];
            shouldOffset = CGRectGetWidth(self.bounds);
            nextIndex = [self indexWithDirection:direct];
        }
    }else {
        CGFloat maxOffsetY = scrollView.contentSize.height - CGRectGetHeight(scrollView.bounds);
        // 竖直方向调整
        if (contentOffset.y < 0) {
            // 向下移动
            shouldOffset = contentOffset.y + stepSize;
            //
            nextIndex = self.beforeIndex;
        }else if(contentOffset.y > maxOffsetY){
            // 向上移动
            shouldOffset = contentOffset.y - stepSize;
            nextIndex = self.behindIndex;
        }else{
            shouldOffset = CGRectGetHeight(self.bounds);
            nextIndex = [self indexWithDirection:direct];
        }
    }
   
    
    if (_style == FSEndLessViewStyleVertical) {
        if (_disableEndless) {
            return;
        }else{
            [scrollView setContentOffset:CGPointMake(0,shouldOffset)];
        }
    }else{
        if (_disableEndless) {
            
        }else{
            [scrollView setContentOffset:CGPointMake(shouldOffset,0)];
        }
    }
    
    
    if (_currentIndex != nextIndex) {
        _currentIndex = nextIndex;
        
        [self setContainerInfos];
        NSLog(@"gc ----方向(%ld) 进度(%f) 选中了的index(%ld)",direct,1.0,_currentIndex);
    }
    
    if ([_delegate respondsToSelector:@selector(endLessViewDidChangeToIndex:)]) {
        [_delegate endLessViewDidChangeToIndex:_currentIndex];
    }
}
- (struct FSEndLessScrollState)scrollStateWithScrollView:(UIScrollView *)scrollView {
    struct FSEndLessScrollState scrollState;
    CGFloat offset = 0;
    CGPoint contentOffset = scrollView.contentOffset;
    CGFloat stepSize = 0;
    
    FSEndLessViewDirection direct = FSEndLessViewDirectionNone;
    if (_style == FSEndLessViewStyleVertical) {
        offset = contentOffset.y - _startDragOffset.y;
        direct = [self directionWithOffset:offset];
        stepSize = CGRectGetHeight(scrollView.bounds);
    }else{
        offset = contentOffset.x - _startDragOffset.x;
        direct = [self directionWithOffset:offset];
        stepSize = CGRectGetWidth(self.bounds);
    }
    
    scrollState.direct = direct;
    scrollState.offset = offset;
    scrollState.stepSize = stepSize;
    
    return scrollState;
}
- (FSEndLessViewDirection)directionWithOffset:(CGFloat)offset {
    FSEndLessViewDirection direct = FSEndLessViewDirectionNone;
    if (offset < 0) {
        direct = FSEndLessViewDirectionForent;
    }else if(offset == 0){
        direct = FSEndLessViewDirectionNone;
    }else{
        direct = FSEndLessViewDirectionBehind;
    }
    return direct;
}
- (NSInteger)indexWithDirection:(FSEndLessViewDirection)direct {
    NSUInteger willChangeToIndex = _currentIndex;
    switch (direct) {
        case FSEndLessViewDirectionBehind:
            if (_currentIndex >= _contentsCount - 1) {
                willChangeToIndex = 0;
            }else{
                willChangeToIndex = _currentIndex + 1;
            }
            break;
        case FSEndLessViewDirectionForent:
            if (_currentIndex <= 0) {
                willChangeToIndex = _contentsCount - 1;
            }else{
                willChangeToIndex = _currentIndex - 1;
            }
            break;
        default:
            break;
    }
    return willChangeToIndex;
}

#pragma mark - getters
- (UIScrollView *)contentView {
    if (!_contentView) {
         _contentView = [[UIScrollView alloc] init];
        [_contentView setDelegate:self];
        [_contentView setPagingEnabled:YES];
        [_contentView setDelaysContentTouches:NO];
        [_contentView setShowsVerticalScrollIndicator:NO];
        [_contentView setShowsHorizontalScrollIndicator:NO];
//        [_contentView setBounces:NO];
        if (@available(iOS 11.0, *)) {
            [_contentView setContentInsetAdjustmentBehavior:(UIScrollViewContentInsetAdjustmentNever)];
        } else {
            // Fallback on earlier versions
        }
        [_contentView setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:_contentView];
    }
    return _contentView;
}
- (NSMutableDictionary *)unVisiableCellDict {
    if (!_unVisiableCellDict) _unVisiableCellDict = [NSMutableDictionary dictionary];
    return _unVisiableCellDict;
}
- (NSMutableDictionary *)visiableCellDict {
    if (!_visiableCellDict) {
        _visiableCellDict = [NSMutableDictionary dictionary];
    }
    return _visiableCellDict;
}
- (NSMutableArray *)visiableCells {
    if (!_visiableCells) {
        _visiableCells = [NSMutableArray array];
    }
    return _visiableCells;
}
- (FSEndLessViewContanier *)centerContainer {
    if (!_centerContainer) {
         _centerContainer = [self createContainer];
        [_centerContainer setBackgroundColor:[UIColor clearColor]];
        [self.contentContainer addSubview:_centerContainer];
    }
    return _centerContainer;
}
- (FSEndLessViewContanier *)behindContainer {
    if (!_behindContainer) {
        _behindContainer = [self createContainer];
        [_behindContainer setBackgroundColor:[UIColor clearColor]];

        [self.contentContainer addSubview:_behindContainer];
    }
    return _behindContainer;
}
- (FSEndLessViewContanier *)beforeContainer {
    if (!_beforeContainer) {
        _beforeContainer = [self createContainer];
        [_beforeContainer setBackgroundColor:[UIColor clearColor]];
        [self.contentContainer addSubview:_beforeContainer];
    }
    return _beforeContainer;
}
- (FSEndLessViewContanier *)createContainer {
    FSEndLessViewContanier *container = [[FSEndLessViewContanier alloc] init];
    [container setBackgroundColor:[UIColor clearColor]];
    return container;
}
- (UIView *)contentContainer {
    if (!_contentContainer) {
        _contentContainer = [[UIView alloc] init];
        [_contentContainer setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:_contentContainer];
    }
    return _contentContainer;
}
// TODO:
- (FSEndLessCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier forInfoIndex:(NSInteger)InfoIndex {
    return nil;
}

GCDEALLOC();
@end
