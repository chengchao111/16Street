//
//  XDSlideView.h
//  XDSlideController
//
//  Created by 谢兴达 on 2018/8/9.
//  Copyright © 2018年 谢兴达. All rights reserved.
//  滑动界面

#import <UIKit/UIKit.h>
@class XDSlideView;

@protocol XDSlideViewDataSourceAndDelegate <NSObject>
@required
/**
 数据代理，用于接受标题数组

 @return 标题数组
 */
- (NSArray <NSString *> *)xd_slideViewPageTitles;

/**
 数据代理，用于接受当前控制器

 @param slideView XDSlideView
 @param index 索引
 @return 子控制器
 */
- (UIViewController *)xd_slideViewChildControllerToSlideView:(XDSlideView *)slideView forIndex:(NSInteger)index;

@optional

/**
 已经跳到的当前界面

 @param pageController 当前控制器
 @param pageTitle 标题
 @param pageIndex 索引
 */
- (void)xd_slideViewDidChangeToPageController:(UIViewController *const)pageController title:(NSString *)pageTitle pageIndex:(NSInteger)pageIndex;

/**
 竖直滚动监听
 该代理只有在有header时才会调用，且变动范围为header的高度范围
 @param changedy 竖直offset.y
 */
- (void)xd_slideViewVerticalScrollOffsetyChanged:(CGFloat)changedy;

/**
 水平滚动监听

 @param changedx 水平offset.x
 */
- (void)xd_slideViewHorizontalScrollOffsetxChanged:(CGFloat)changedx;

@end

@interface XDSlideView : UIView
//设置header
@property (nonatomic, strong) UIView *headerView;

//设置开始页面索引，默认为0
@property (nonatomic, assign) NSInteger beginPage;

//最大缓存页数，默认为不限制
@property (nonatomic, assign) NSUInteger cacheNumber;

//靠边后是否可滑动，默认为NO
@property (nonatomic, assign) BOOL slideBounces;

//slideview上方空余空间 (其值要大于0)
@property (nonatomic, assign) CGFloat edgeInsetTop;

#pragma mark -- 标题栏属性
#pragma mark --
@property (nonatomic, assign)  CGSize titleBarItemSize;
@property (nonatomic, strong) UIColor *titleBarHighlightTintColor;
@property (nonatomic, strong) UIColor *titleBarDefaultTintColor;
@property (nonatomic, strong) UIColor *titleBarBackColor;
@property (nonatomic, strong) UIFont  *titleBartextFont;

#pragma mark -- 下划线属性
@property (nonatomic,strong)UIColor *lineColor;
@property (nonatomic,assign)CGSize lineSize;

//标题栏上边距（其范围在 0 ~ edgeInsetTop + headerView.height 之间）
@property (nonatomic, assign) CGFloat titleBarMarginTop;


/**
 初始化XDSlideView

 @param frame frame
 @param controller 主控制器
 @return self
 */
- (instancetype)initWithFrame:(CGRect)frame dataSourceAndDelegateInBaseCongtroller:(id)controller;

/**
 缓存复用

 @param index 索引
 @return 缓存的子控制器
 */
- (UIViewController *)dequeueReusablePageForIndex:(NSInteger)index;

/**
 刷新操作，待以后扩展，用于增添或删除item项，目前先不要使用
 - (void)reloadate;
 */
@end
