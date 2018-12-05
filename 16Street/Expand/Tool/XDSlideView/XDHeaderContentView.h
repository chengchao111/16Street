//
//  XDHeaderContentView.h
//  XDSlideController
//
//  Created by 谢兴达 on 2018/8/9.
//  Copyright © 2018年 谢兴达. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XDHeaderContentViewDelegate <NSObject>
@optional
- (void)xd_headerContentViewTitleBarTapAtIndexPath:(NSIndexPath *)indexpath;
@end

@interface XDHeaderContentView : UIView
@property (nonatomic, weak) id <XDHeaderContentViewDelegate> delegate;
//对外数据，只读
@property (nonatomic, assign, readonly) CGFloat headerContentHeight;    //总高度（headerBarHeight + headerHeight）
@property (nonatomic, assign, readonly) CGFloat headerBarHeight;        //xdslideBar的高度
@property (nonatomic, assign, readonly) CGFloat headerHeight;           //所赋值的header的高度
@property (nonatomic, assign, readonly) CGFloat headerEdgeTop;          //header的上方空余
@property (nonatomic, assign, readonly) CGFloat barMarginTop;           //slideBar悬停上边距

//标题数组
- (void (^)(NSArray *titles))titleBarTitles;

//设置header并返回头高度
- (CGFloat (^)(UIView *header))slideHeader;

//headerConterSlideBar变动通知
- (void (^)(NSInteger index))titleBarChangedToIndex;

//上方空余空间
- (void (^)(CGFloat edgeTop))slideHeaderEdgeTop;

#pragma mark -- 标题栏
- (CGFloat (^)(CGSize itemsize))titleBarItemSize;
- (void (^)(UIColor *color))titleBarHighlightTintColor;
- (void (^)(UIColor *color))titleBarDefaultTintColor;
- (void (^)(UIColor *color))titleBarBackColor;
- (void (^)(UIFont  *font))titleBarTextFont;

- (void (^)(UIColor *color))lineColor;
- (void (^)(CGSize size))lineSize;

//标题栏上边距
- (void (^)(CGFloat edgeTop))titleBarMarginTop;
@end
