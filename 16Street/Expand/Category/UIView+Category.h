//
//  UIView+Category.h
//  项目框架
//
//  Created by apple on 2018/7/30.
//  Copyright © 2018年 ChengChao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Category)
@property (nonatomic, assign)CGFloat x;
@property (nonatomic, assign)CGFloat y;
@property (nonatomic, assign)CGFloat width;
@property (nonatomic, assign)CGFloat height;
@property (nonatomic, assign)CGFloat centerX;
@property (nonatomic, assign)CGFloat centerY;
@property (nonatomic, assign)CGSize size;
@property(nonatomic, assign) IBInspectable CGFloat borderWidth;
@property(nonatomic, assign) IBInspectable UIColor *borderColor;
@property(nonatomic, assign) IBInspectable CGFloat cornerRadius;

/**
 *  水平居中
 */
- (void)alignHorizontal;

/**
 *  垂直居中
 */
- (void)alignVertical;

/**
 *  判断是否显示在主窗口上
 *
 * @return 是否
 */
- (BOOL)isShowOnWindow;

- (UIViewController *)parentController;
@end
