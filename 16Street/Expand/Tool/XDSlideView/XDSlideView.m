//
//  XDSlideView.m
//  XDSlideController
//
//  Created by 谢兴达 on 2018/8/9.
//  Copyright © 2018年 谢兴达. All rights reserved.
//

#import "XDSlideView.h"
#import "NSArray+XDhandle.h"
#import "XDSlidePageCache.h"
#import "XDHeaderContentView.h"

typedef NS_ENUM(NSInteger, HeaderContentStatus) {
    HCS_Top,        //headerContener到达顶端
    HCS_Changeing,  //headerContener变化中
    HCS_Ceiling     //headerContener吸顶
};

@interface XDSlideView()<UIScrollViewDelegate, XDHeaderContentViewDelegate>
@property (nonatomic, weak) id <XDSlideViewDataSourceAndDelegate> dataSource;

@property (nonatomic,   weak) __block UIViewController *currentController;  //子控制器容器控制器
@property (nonatomic, strong) __block UIScrollView     *pagesContener;      //子视图容器视图
@property (nonatomic, strong) XDHeaderContentView      *headerContener;     //头部容器视图
@property (nonatomic, strong) XDSlidePageCache         *xdCache;            //缓存

@property (nonatomic, assign) __block NSInteger currentPage;    //当前window中的页面索引
@property (nonatomic, assign) __block NSInteger bufferPage;     //缓冲页（用于掌控页面跳转）

@property (nonatomic, assign) BOOL isBeginPage;
@end

@implementation XDSlideView
#pragma mark -- lazyLoad
- (XDHeaderContentView *)headerContener {
    if (!_headerContener) {
        _headerContener = [[XDHeaderContentView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 0)];
        _headerContener.delegate = self;
    }
    return _headerContener;
}

- (void)dealloc {
    while (_xdCache.caches_kvo.count) {
        [[self scrollViewByTitle:_xdCache.caches_kvo.lastObject] removeObserver:self forKeyPath:@"contentOffset"];
        [_xdCache.caches_kvo removeLastObject];
    }
    
    //清除缓存
    [self clearStack];
}

//更换kvo监听
- (void)kvoForCurrentPage:(NSInteger)currentPage {
    while (_xdCache.caches_kvo.count) {
        [[self scrollViewByTitle:_xdCache.caches_kvo.lastObject] removeObserver:self forKeyPath:@"contentOffset"];
        [_xdCache.caches_kvo removeLastObject];
    }
    
    [[self scrollViewByTitle:_xdCache.caches_titles[currentPage]] addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
    [_xdCache.caches_kvo addObject:_xdCache.caches_titles[currentPage]];
}

- (void)setCacheNumber:(NSUInteger)cacheNumber {
    _cacheNumber = cacheNumber;
    _xdCache.cachenumber = cacheNumber;
}

- (void)setBeginPage:(NSInteger)beginPage {
    if (!_pagesContener || beginPage <= 0 || _isBeginPage) {
        return;
    }
    
    if (beginPage >= _xdCache.caches_titles.count) {
        __assert(0, "XDSlideView_越界了,当前beginPage的数值应该小于标题数组的长度", __LINE__);
    }
    
    _isBeginPage = YES;
    //移除缓存顺序表内所有数据，并把开始页数据放到顶端
    [self clearStack];
    [self jumpToPage:beginPage];
}

//当前页面，当变动时需要更换监听对象
- (void)setCurrentPage:(NSInteger)currentPage {
    if (_xdCache.caches_vc.count <= 0) {
        return;
    }
    _currentPage = currentPage;
    [self kvoForCurrentPage:currentPage];
}

- (void)setSlideBounces:(BOOL)slideBounces {
    if (!_pagesContener) {
        return;
    }
    _slideBounces = slideBounces;
    _pagesContener.bounces = slideBounces;
}

- (void)setHeaderView:(UIView *)headerView {
    if (!self.headerContener) {
        return;
    }
    _headerView = headerView;
    self.headerContener.slideHeader(headerView);
    [self jumpToPage:_currentPage];
    [self resetAllScrollOffset];
}

- (void)setEdgeInsetTop:(CGFloat)edgeInsetTop {
    if (!self.headerContener) {
        return;
    }
    self.headerContener.slideHeaderEdgeTop(edgeInsetTop);
    [self jumpToPage:_currentPage];
    [self resetAllScrollOffset];
}

- (void)setTitleBarItemSize:(CGSize)titleBarItemSize {
    if (!self.headerContener) {
        return;
    }
    _titleBarItemSize = titleBarItemSize;
    self.headerContener.titleBarItemSize(titleBarItemSize);
    [self jumpToPage:_currentPage];
    [self resetAllScrollOffset];
}

- (void)setTitleBarHighlightTintColor:(UIColor *)titleBarHighlightTintColor {
    _titleBarHighlightTintColor = titleBarHighlightTintColor;
    self.headerContener.titleBarHighlightTintColor(titleBarHighlightTintColor);
}

- (void)setTitleBarDefaultTintColor:(UIColor *)titleBarDefaultTintColor {
    _titleBarDefaultTintColor = titleBarDefaultTintColor;
    self.headerContener.titleBarDefaultTintColor(titleBarDefaultTintColor);
}

- (void)setTitleBarBackColor:(UIColor *)titleBarBackColor {
    _titleBarBackColor = titleBarBackColor;
    self.headerContener.titleBarBackColor(titleBarBackColor);
}

- (void)setTitleBartextFont:(UIFont *)titleBartextFont {
    _titleBartextFont = titleBartextFont;
    self.headerContener.titleBarTextFont(titleBartextFont);
}

-(void)setLineColor:(UIColor *)lineColor{
    _lineColor = lineColor;
    self.headerContener.lineColor(lineColor);
}

-(void)setLineSize:(CGSize)lineSize{
    _lineSize = lineSize;
    self.headerContener.lineSize(lineSize);
}

- (void)setTitleBarMarginTop:(CGFloat)titleBarMarginTop {
    if (!self.headerContener) {
        return;
    }
    self.headerContener.titleBarMarginTop(titleBarMarginTop);
    [self jumpToPage:_currentPage];
    [self resetAllScrollOffset];
}

- (instancetype)initWithFrame:(CGRect)frame dataSourceAndDelegateInBaseCongtroller:(id)controller {
    self = [super initWithFrame:frame];
    if (!controller) {
        __assert(0, "需要加入当前控制器，具体用法请看demo", __LINE__);
    }
    
    if (self) {
        if (controller) {
            self.clipsToBounds = YES;
            _currentPage    = 0;
            _bufferPage     = 0;
            _dataSource = controller;
            _currentController = controller;
            _xdCache = [[XDSlidePageCache alloc]init];
            
            //只有实现了代理才会创建UI
            if ([self.dataSource respondsToSelector:@selector(xd_slideViewPageTitles)]&&[self.dataSource respondsToSelector:@selector(xd_slideViewChildControllerToSlideView:forIndex:)]) {
                [self creatMainUI];
            }
        }
    }
    return self;
}

- (void)creatMainUI {
    _pagesContener = [[UIScrollView alloc]initWithFrame:self.bounds];
    if (@available(iOS 11.0, *)) {
        _pagesContener.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        _currentController.automaticallyAdjustsScrollViewInsets = NO;
    }
    _pagesContener.pagingEnabled = YES;
    _pagesContener.showsVerticalScrollIndicator = NO;
    _pagesContener.showsHorizontalScrollIndicator = NO;
    _pagesContener.alwaysBounceHorizontal = NO;
    _pagesContener.bounces = NO;
    _pagesContener.delegate = self;
    [self addSubview:_pagesContener];
    
    [self addSubview:self.headerContener];
    
    [self reloadate];
}

- (void)reloadate {
    if (!_pagesContener) {
        return;
    }
    
    NSArray *titles = [self.dataSource xd_slideViewPageTitles];
    if ([titles hasRepeatItemInArray]) {
        __assert(0, "标题数组中不能出现重复项", __LINE__);
    }
    
    _pagesContener.contentSize = CGSizeMake(self.bounds.size.width * titles.count, self.bounds.size.height);
    _xdCache.caches_titles = titles;
    self.headerContener.titleBarTitles(titles);
    [self resectAllScrollFrame];
    [self resetAllScrollOffset];
    [self jumpToPage:_currentPage];
    [self pageIndexDidChangedToPage:_currentPage];
}

//返回缓存控制器
- (UIViewController *)dequeueReusablePageForIndex:(NSInteger)index {
    if (index < 0 || index > _xdCache.caches_titles.count-1) {
        __assert(0, "索引越界了", __LINE__);
    }
    NSString *title = _xdCache.caches_titles[index];
    return [_xdCache.caches_vc objectForKey:title];
}

//滑动到某页
- (void)changeToPage:(NSInteger)page {
    UIViewController *pageVc = [self.dataSource xd_slideViewChildControllerToSlideView:self forIndex:page];
    NSString *pageTitle = _xdCache.caches_titles[page];
    
    //如果返回的子控制器与缓存中不同，则更新该控制器
    if (pageVc != [self dequeueReusablePageForIndex:page]) {
        [self cancelPageVcByTitle:pageTitle];
        [self addChildPageVc:pageVc atIndex:page];
    }
    
    //加入缓存顺序表
    [self pushDataToStack:pageTitle];
    //赋值当前页，并更换监听
    self.currentPage = page;
    //同步左右页
    [self synchronizeCurrentPageWithRightAndLeftWhenChangeToPage:page];
}

//直接跳转到某页
- (void)jumpToPage:(NSInteger)page {
    [self changeToPage:page];
    _pagesContener.contentOffset = CGPointMake(page*self.bounds.size.width, 0);
}

//页面已经更换处理
- (void)pageIndexDidChangedToPage:(NSInteger)page {
    //页面更换通知，用于改变slideBar状态
    self.headerContener.titleBarChangedToIndex(page);
    if ([self.dataSource respondsToSelector:@selector(xd_slideViewDidChangeToPageController:title:pageIndex:)]) {
        [self.dataSource xd_slideViewDidChangeToPageController:[_xdCache.caches_vc objectForKey:_xdCache.caches_titles[page]] title:_xdCache.caches_titles[page] pageIndex:page];
    }
}

//页面更换算法，可以在这里自定义页面出现时机（当前为无缝相连状态）
- (void)slidePageAppearanceHandleByScrollXvalue:(CGFloat)xValue {
    CGFloat c_w = CGRectGetWidth(self.frame);
    NSInteger page_forward = floor(xValue/c_w);     //前页
    NSInteger page_later   = ceil(xValue/c_w);      //后页
    //更新缓冲页
    if (_bufferPage < page_forward) {
        _bufferPage = page_forward;
        [self pageIndexDidChangedToPage:page_forward];
        
    } else if (_bufferPage > page_later) {
        _bufferPage = page_later;
        [self pageIndexDidChangedToPage:page_later];
    }

    //缓冲页面在前面时，说明是往后滑动， 所以将要出现的是后一页
    if (_bufferPage == page_forward) {
        if (_currentPage != page_later) {
            [self changeToPage:page_later];
        }
        
        //缓冲页面在后面时，说明是往前滑动，所以将要出现的是前一页
    } else if (_bufferPage == page_later) {
        if (_currentPage != page_forward) {
            [self changeToPage:page_forward];
        }
    }
}

//添加子控制器
- (void)addChildPageVc:(UIViewController *)pageVc atIndex:(NSInteger)index {
    if ([_pagesContener isDescendantOfView:self]) {
        [self.currentController addChildViewController:pageVc];
        [pageVc didMoveToParentViewController:self.currentController];
        [_xdCache.caches_vc setObject:pageVc forKey:_xdCache.caches_titles[index]];

        [self resectCurrentScrollFrameByPageVc:pageVc Index:index];
        [self resetCurrentScrollContentOffetAndEdgeInsetByTitle:_xdCache.caches_titles[index]];
    } else {
        __assert(0, "XDSlideView_页面未加入到controller中", __LINE__);
    }
}

//重置当前子控制器子view的frame
- (void)resectCurrentScrollFrameByPageVc:(UIViewController *)pageVc Index:(NSInteger)idx {
    if (pageVc) {
        
        UIView *childView = pageVc.view;
        //如果子视图已经存在那么直接更改位置，否则设置位置并添加子视图
        CGFloat d_bottom = childView.frame.size.height - self.bounds.size.height;
        CGRect childFrame = self.bounds;
        childFrame.origin.x = idx * self.bounds.size.width;
        childFrame.origin.y = 0;
        childView.frame = childFrame;
        
        //由于改变了子控制器视图的大小，但是由于子控制器内的子视图的frame是在控制器开空间的时候渲染的，所以这里需要手动更改子控制器的子视图的大小，由于上端,左右是保持一定的，所以只需要更改宽度和距离下边的大小
        UIScrollView *scrollview = [self scrollViewByTitle:_xdCache.caches_titles[idx]];
        CGRect relateRect = [scrollview convertRect:scrollview.bounds toView:scrollview.superview];
        CGRect scFrame = scrollview.frame;
        scFrame.size.height = relateRect.size.height - d_bottom;
        scFrame.size.width = self.bounds.size.width;
        scrollview.frame = scFrame;
        
        if (![self.pagesContener.subviews containsObject:childView]) {
            [self.pagesContener addSubview:childView];
        }
    }
}

//重置所有子控制器子view的frame
- (void)resectAllScrollFrame {
    __weak typeof(self) weakSelf = self;
    //按照标题的顺序依次设置对应view的frame
    [_xdCache.caches_titles enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [weakSelf resectCurrentScrollFrameByPageVc:[weakSelf.xdCache.caches_vc objectForKey:obj] Index:idx];
    }];
}

//重置当前title的ScrollView的edgeInset
- (void)resetCurrentScrollEdgeInsetTitle:(NSString *)title {
    CGFloat  HC_Height = self.headerContener.headerContentHeight;
    UIScrollView *scrollview = [self scrollViewByTitle:title];
    if (scrollview.scrollIndicatorInsets.top != self.headerContener.headerEdgeTop) {
        scrollview.scrollIndicatorInsets = UIEdgeInsetsMake(self.headerContener.headerEdgeTop, 0, 0, 0);
    }
    
    UIEdgeInsets edgeInset = scrollview.contentInset;
    if (edgeInset.top != HC_Height) {
        edgeInset.top = HC_Height;
        edgeInset.left = 0;
        edgeInset.right = 0;
        scrollview.contentInset = edgeInset;
    }
}

//重置当前title的ScrollView的edgeInset 和 offset
- (void)resetCurrentScrollContentOffetAndEdgeInsetByTitle:(NSString *)title {
    [self resetCurrentScrollEdgeInsetTitle:title];
    CGFloat  HC_Height = self.headerContener.headerContentHeight;
    UIScrollView *scrollview = [self scrollViewByTitle:title];
    if (scrollview.contentOffset.y != -HC_Height-self.headerContener.frame.origin.y) {
        scrollview.contentOffset = CGPointMake(0, -HC_Height-self.headerContener.frame.origin.y);
    }
}

//重置所有的ScrollView的edgeInset 和 offset
- (void)resetAllScrollOffset {
    __weak typeof(self) weakSelf = self;
    [_xdCache.caches_table enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [weakSelf resetCurrentScrollContentOffetAndEdgeInsetByTitle:obj];
    }];
}

//找到对应控制器中的scrollview
- (UIScrollView *)scrollviewInPageVc:(UIViewController *)pageVc {
    if (!pageVc) {
        return nil;
    }
    
    UIScrollView *scrollview = nil;
    if ([pageVc.view isKindOfClass:[UIScrollView class]]) {
        scrollview = (UIScrollView *)pageVc.view;
        
    } else {
        for (UIView *view in pageVc.view.subviews) {
            if ([view isKindOfClass:[UIScrollView class]]) {
                scrollview = (UIScrollView *)view;
                break;
            }
        }
    }
    
    if (!scrollview) {
        __assert(0, "XDSlideView_(控制器中不包含可滚动控件)", __LINE__);
    }
    
    if (@available(iOS 11.0, *)) {
        scrollview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        
    }

    return scrollview;
}

//找到title对应的scrollview
- (UIScrollView *)scrollViewByTitle:(NSString *)title {
    if (!title) {
        return nil;
    }
    
    UIScrollView *scrollview = [_xdCache.caches_sview objectForKey:title];
    if (!scrollview) {
        scrollview = [self scrollviewInPageVc:[_xdCache.caches_vc objectForKey:title]];
        if (scrollview) {
            [_xdCache.caches_sview setObject:scrollview forKey:title];
        }
    }
    return scrollview;
}

//去掉被删掉的子控制器
- (void)cancelPageVcByTitle:(NSString *)title {
    UIViewController *pageVc = [_xdCache.caches_vc objectForKey:title];
    if (pageVc) {
        [pageVc.view removeFromSuperview];
        pageVc.view = nil;
        [pageVc willMoveToParentViewController:nil];
        [pageVc removeFromParentViewController];
        pageVc = nil;
        [_xdCache.caches_vc removeObjectForKey:title];
        [_xdCache.caches_sview removeObjectForKey:title];
        [_xdCache.caches_table removeObject:title];
    }
}

/*
 这里是一个优化策略，原来的思路是直接同步除了当前视图外的其他所有子视图的contentOffset,
 但是当子视图多时，这么多的view联动会非常消耗性能，所以改为现在分两种情况去同步。
 这样每次所需同步数只需要联动两个view
 
 情况1：更改界面时同步（根据headerContent的y去同步当前和左右三个界面的offset）。
 情况2：上下滚动子tableview时同步（根据该tableview的contentOffset.y同步左右两边的子tableview的contentOffset.y）。
 */

//情况1
- (void)synchronizeCurrentPageWithRightAndLeftWhenChangeToPage:(NSInteger)page {
    
    //headerContener的总高度（header+bar）
    CGFloat  HC_Height = self.headerContener.headerContentHeight;
    
    //headerSlideBar的高度
    CGFloat HB_Height = self.headerContener.headerBarHeight;
    
    //bar margin to top
    CGFloat HB_Top = _headerContener.barMarginTop;
    
    //headerContent的y
    CGFloat Header_y = self.headerContener.frame.origin.y;
    
    //当headercontener没有变动空间时直接返回
    if (HB_Top >= HC_Height-HB_Height) {
        return;
        
    } else if (HB_Top < 0) {
        HB_Top = 0;
    }
    
    //所需同步数组
    NSMutableArray <NSString *>* needSynArray = @[].mutableCopy;
    
    //当前视图
    [needSynArray addObject:_xdCache.caches_titles[page]];
    
    //左边视图
    if (page-1 >= 0) {
        [needSynArray addObject:_xdCache.caches_titles[page-1]];
    }
    
    //右边视图
    if (page+1 < _xdCache.caches_titles.count) {
        [needSynArray addObject:_xdCache.caches_titles[page+1]];
    }
    
    __weak typeof(self) weakSelf = self;
    
    [needSynArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIScrollView *child = [weakSelf scrollViewByTitle:obj];
        if (child) {
            
            [weakSelf resetCurrentScrollEdgeInsetTitle:obj];
            
            //子滚动页的offset_Y
            CGFloat child_y = child.contentOffset.y;
            
            if (Header_y >= 0) {
                if (child_y >= -HC_Height && child_y != -HC_Height) {
                    child.contentOffset = CGPointMake(0, -HC_Height);
                }
                
            } else if (Header_y > HB_Height + HB_Top - HC_Height && Header_y < 0 && child.contentOffset.y != -HC_Height-Header_y) {
                child.contentOffset = CGPointMake(0, -HC_Height-Header_y);
                
            } else if (Header_y <= HB_Height + HB_Top - HC_Height) {
                if (child_y <= -HB_Height && child_y != -HB_Height-HB_Top) {
                    child.contentOffset = CGPointMake(0, -HB_Height-HB_Top);
                }
            }
        }
    }];
}

//情况2
- (void)synchronizeRightAndLeftWhenScrollByHCStatus:(HeaderContentStatus)status withCurrentPage:(NSInteger) page {
    
    //headerContener的总高度（header+bar）
    CGFloat  HC_Height = self.headerContener.headerContentHeight;
    
    //headerSlideBar height
    CGFloat HB_Height = self.headerContener.headerBarHeight;
    
    //bar margin to top
    CGFloat HB_Top = _headerContener.barMarginTop;
    
    //headerContent的y
    CGFloat Header_y = self.headerContener.frame.origin.y;
    
    //当headercontener没有变动空间时直接返回
    if (HB_Top >= HC_Height-HB_Height) {
        return;
        
    } else if (HB_Top < 0) {
        HB_Top = 0;
    }
    
    //所需同步数组
    NSMutableArray <NSString *>* needSynArray = @[].mutableCopy;
    
    //左边视图
    if (page-1 >= 0) {
        [needSynArray addObject:_xdCache.caches_titles[page-1]];
    }
    
    //右边视图
    if (page+1 < _xdCache.caches_titles.count) {
        [needSynArray addObject:_xdCache.caches_titles[page+1]];
    }
    
    __weak typeof(self) weakSelf = self;
    
    [needSynArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIScrollView *child = [weakSelf scrollViewByTitle:obj];
        if (child) {
            
            [weakSelf resetCurrentScrollEdgeInsetTitle:obj];
            
            //子滚动页的offset_Y
            CGFloat child_y = child.contentOffset.y;
            
            //状态判定
            switch (status) {
                    //headerContener触顶
                case HCS_Top:
                    if (child_y >= -HC_Height && child_y != -HC_Height) {
                        child.contentOffset = CGPointMake(0, -HC_Height);
                    }
                    break;
                    
                    //headerContener的origin变动中，子滚动页的Offset随着headerContener的origin.y同步变化
                case HCS_Changeing:
                    child.contentOffset = CGPointMake(0, -HC_Height-Header_y);
                    break;
                    
                    //headerContener吸顶
                case HCS_Ceiling:
                    if (child_y <= -HB_Height-HB_Top && child_y != -HB_Height-HB_Top) {
                        child.contentOffset = CGPointMake(0, -HB_Height-HB_Top);
                    }
                    break;
                    
                default:
                    break;
            }
        }
    }];
}

#pragma mark -- KVO For ContentOffset
#pragma mark -- 子控制器scrollview的滚动监听
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    //当前监听的滚动页面
    UIScrollView *scrollView = object;
    
    //所监听滚动的ScrollView的当前内容位置
    CGFloat  S_Y = scrollView.contentOffset.y;
    
    //headerContener的总高度（header+bar）
    CGFloat  HC_Height = _headerContener.headerContentHeight;
    
    //bar margin to top
    CGFloat HB_Top = _headerContener.barMarginTop;
    
    //headerSlideBar的高度
    CGFloat HB_Height = _headerContener.headerBarHeight;
    
    //当headercontener没有变动空间时直接返回
    if (HB_Top >= HC_Height-HB_Height) {
        return;
        
    } else if (HB_Top < 0) {
        HB_Top = 0;
    }
    
    //所监听scrollview是否是当前window中的scrollview
    if (scrollView == [self scrollViewByTitle:_xdCache.caches_titles[self.currentPage]]) {
        
        if (S_Y <= -HC_Height && self.headerContener.frame.origin.y != 0) {
            //headerContener触顶
            CGRect frame = self.headerContener.frame;
            frame.origin.y = 0;
            self.headerContener.frame = frame;
            [self synchronizeRightAndLeftWhenScrollByHCStatus:HCS_Top
                                              withCurrentPage:self.currentPage];
            
            if ([self.dataSource respondsToSelector:@selector(xd_slideViewVerticalScrollOffsetyChanged:)]) {
                [self.dataSource xd_slideViewVerticalScrollOffsetyChanged:0];
            }
            
        } else if(S_Y > -HC_Height && S_Y < -HB_Height-HB_Top) {
            //headerContener的origin变动中（由于有触顶和吸顶两个边界值，在变动范围内的滑动过快越级不会产生影响）
            CGRect frame = self.headerContener.frame;
            frame.origin.y = -S_Y - HC_Height;
            self.headerContener.frame = frame;
            [self synchronizeRightAndLeftWhenScrollByHCStatus:HCS_Changeing
                                              withCurrentPage:self.currentPage];
            
            if ([self.dataSource respondsToSelector:@selector(xd_slideViewVerticalScrollOffsetyChanged:)]) {
                [self.dataSource xd_slideViewVerticalScrollOffsetyChanged:-S_Y - HC_Height];
            }
            
        } else if (S_Y >= -HB_Height-HB_Top && self.headerContener.frame.origin.y != HB_Height + HB_Top - HC_Height) {
            //headerContener吸顶
            CGRect frame = self.headerContener.frame;
            frame.origin.y = HB_Height + HB_Top - HC_Height;
            self.headerContener.frame = frame;
            [self synchronizeRightAndLeftWhenScrollByHCStatus:HCS_Ceiling
                                              withCurrentPage:self.currentPage];
            
            if ([self.dataSource respondsToSelector:@selector(xd_slideViewVerticalScrollOffsetyChanged:)]) {
                [self.dataSource xd_slideViewVerticalScrollOffsetyChanged:HB_Height + HB_Top - HC_Height];
            }
        }
    }
}

#pragma mark -- ScrollDelegate
#pragma mark -- 当前控制器pagesContener的横向滚动监听
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == _pagesContener && !(scrollView.contentOffset.x > scrollView.contentSize.width-scrollView.frame.size.width || scrollView.contentOffset.x < 0)) {
        [self slidePageAppearanceHandleByScrollXvalue:scrollView.contentOffset.x];
    }
    
    if (scrollView == _pagesContener &&
        [self.dataSource respondsToSelector:@selector(xd_slideViewHorizontalScrollOffsetxChanged:)]) {
        [self.dataSource xd_slideViewHorizontalScrollOffsetxChanged:scrollView.contentOffset.x];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (scrollView == _pagesContener) {
        self.currentController.view.userInteractionEnabled = NO;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (scrollView == _pagesContener) {
        self.currentController.view.userInteractionEnabled = YES;
    }
}

#pragma mark -- chache
#pragma mark -- 缓存处理
//清空缓存顺序表及对应对象
- (void)clearStack {
    while (_xdCache.caches_table.count > 0) {
        [self popDataOnStack];
    }
}

//数据出缓存（同时要删除对应的控制器）
- (void)popDataOnStack {
    NSString *title = _xdCache.caches_table.lastObject;
    UIViewController *controller = [_xdCache.caches_vc objectForKey:title];
    if (controller) {
        [self cancelPageVcByTitle:title];
    }
}

//添加数据入缓存
- (void)pushDataToStack:(NSString *)title {
    //最新数据放到表的顶部，如果已经存在，那么就删掉并放到顶部
    NSInteger allStack = self.xdCache.caches_table.count;
    for (int i = 0; i < allStack; i ++) {
        if ([self.xdCache.caches_table[i] isEqualToString:title]) {
            [self.xdCache.caches_table removeObjectAtIndex:i];
            break;
        };
    }
    
    [_xdCache.caches_table insertObject:title atIndex:0];
    while (_xdCache.caches_table.count > _xdCache.cachenumber) {
        [self popDataOnStack];
    }
}

#pragma mark -- XDHeaderContentViewDelegate
- (void)xd_headerContentViewTitleBarTapAtIndexPath:(NSIndexPath *)indexpath {
    UIScrollView *currentScrollview = [self scrollViewByTitle:_xdCache.caches_titles[_currentPage]];
    if (currentScrollview.isTracking) {
        return;
    }
    if (_currentPage != indexpath.row) {
        [self jumpToPage:indexpath.row];
    }
}

@end
