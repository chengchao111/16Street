//
//  XDHeaderContentView.m
//  XDSlideController
//
//  Created by 谢兴达 on 2018/8/9.
//  Copyright © 2018年 谢兴达. All rights reserved.
//

#import "XDHeaderContentView.h"
#import "XDTitleBar.h"

@interface XDHeaderContentView()<XDTitleBarDelegate>
@property (nonatomic, assign) __block CGFloat headerContentHeight;
@property (nonatomic, assign) __block CGFloat headerBarHeight;
@property (nonatomic, assign) __block CGFloat headerHeight;
@property (nonatomic, assign) __block CGFloat headerEdgeTop;
@property (nonatomic, assign) __block CGFloat barMarginTop;

@property (nonatomic, strong)XDTitleBar *bar;
@property (nonatomic, strong) UIView *headerView;
@end
@implementation XDHeaderContentView
#pragma mark -- lazyload
- (XDTitleBar *)bar {
    if (!_bar) {
        _bar = [[XDTitleBar alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 0)];
        _bar.delegate = self;
    }
    return _bar;
}

#pragma mark -- headerContener赋值
- (void (^)(NSArray *))titleBarTitles {
    __weak typeof(self) weakSelf = self;
    return ^(NSArray *titles) {
        if (![weakSelf.bar isDescendantOfView:weakSelf]) {
            [weakSelf addSubview:weakSelf.bar];
        }
        weakSelf.bar.titles = titles;
    };
}

- (CGFloat (^)(UIView *))slideHeader {
    __weak typeof(self) weakSelf = self;
    return ^(UIView *header) {
        if (weakSelf.headerView) {
            [weakSelf.headerView removeFromSuperview];
            weakSelf.headerView = nil;
        }
        weakSelf.headerView = header;
        if (![weakSelf.headerView isDescendantOfView:weakSelf]) {
            [weakSelf addSubview:weakSelf.headerView];
        }
        [weakSelf resetFrame];
        return weakSelf.headerHeight;
    };
}

- (void (^)(NSInteger))titleBarChangedToIndex {
    __weak typeof(self) weakSelf = self;
    return ^(NSInteger index) {
        if (weakSelf.bar.barIndexChangedBlock) {
            weakSelf.bar.barIndexChangedBlock(index);
        }
    };
}

- (void (^)(CGFloat))slideHeaderEdgeTop {
    __weak typeof(self) weakSelf = self;
    return ^(CGFloat edgetop) {
        weakSelf.headerEdgeTop = edgetop > 0 ? edgetop : 0;
        [weakSelf resetFrame];
    };
}

#pragma mark -- bar属性
- (CGFloat (^)(CGSize))titleBarItemSize {
    __weak typeof(self) weakSelf = self;
    return ^(CGSize itemSize) {
        weakSelf.bar.itemSize = itemSize;
        [weakSelf resetFrame];
        return weakSelf.headerBarHeight;
    };
}

- (void (^)(UIColor *))titleBarBackColor {
    __weak typeof(self) weakSelf = self;
    return ^(UIColor *color) {
        weakSelf.bar.barBackColor = color;
    };
}

- (void (^)(UIColor *))titleBarDefaultTintColor {
    __weak typeof(self) weakSelf = self;
    return ^(UIColor *color) {
        weakSelf.bar.defaultTintColor = color;
    };
}

- (void (^)(UIColor *))titleBarHighlightTintColor {
    __weak typeof(self) weakSelf = self;
    return ^(UIColor *color) {
        weakSelf.bar.highlightTintColor = color;
    };
}


-(void (^)(UIFont *))titleBarTextFont{
    __weak typeof(self) weakSelf = self;
    return ^(UIFont *font){
        weakSelf.bar.textFont = font;
    };
}

-(void (^)(UIColor *))lineColor{
     __weak typeof(self) weakSelf = self;
    return ^(UIColor *color){
        weakSelf.bar.lineColor = color;
    };
}

-(void (^)(CGSize))lineSize{
    __weak typeof(self) weakSelf = self;
    return ^(CGSize size){
        weakSelf.bar.lineSize = size;
    };
}


- (void (^)(CGFloat))titleBarMarginTop {
    __weak typeof(self) weakSelf = self;
    return ^(CGFloat marginTop) {
        weakSelf.barMarginTop = marginTop > 0 ? marginTop : 0;
    };
}

#pragma mark -- 初始化
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _headerBarHeight = self.bar.defaultItemSize.height;
        _headerContentHeight = _headerBarHeight;
        _headerHeight = 0;
        _headerEdgeTop = 0;
        _barMarginTop = 0;
        [self addSubview:self.bar];
        [self resetFrame];
    }
    return self;
}

//重置XDHeaderContentView的frame
- (void)resetFrame {
    if ([self.headerView isDescendantOfView:self]) {
        CGRect headerFrame = _headerView.frame;
        headerFrame.origin.x = 0;
        headerFrame.origin.y = _headerEdgeTop;
        headerFrame.size.width = self.bounds.size.width;
        _headerView.frame = headerFrame;
        _headerHeight = CGRectGetHeight(headerFrame);
    }
    
    CGRect barFrame = self.bar.frame;
    barFrame.origin.x = 0;
    barFrame.origin.y = CGRectGetMaxY(_headerView.frame);
    barFrame.size.width = self.bounds.size.width;
    self.bar.frame = barFrame;
    _headerBarHeight = CGRectGetHeight(barFrame);
    
    CGRect cframe = self.bounds;
    CGFloat headerWidth = self.bounds.size.width;
    CGFloat headerContentHeight = CGRectGetHeight(self.headerView.frame) + CGRectGetHeight(self.bar.frame)  + _headerEdgeTop;
    
    cframe.size.width = headerWidth;
    cframe.size.height = headerContentHeight;
    self.frame = cframe;
    _headerContentHeight = CGRectGetHeight(cframe);
}

#pragma mark -- barDelegate
- (void)xd_titleBarItemTapAtIndex:(NSIndexPath *)idx {
    if ([self.delegate respondsToSelector:@selector(xd_headerContentViewTitleBarTapAtIndexPath:)]) {
        [self.delegate xd_headerContentViewTitleBarTapAtIndexPath:idx];
    }
}

@end
