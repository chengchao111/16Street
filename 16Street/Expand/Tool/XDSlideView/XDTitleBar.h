//
//  XDSlideBar.h
//  XDSlideController
//
//  Created by 谢兴达 on 2018/8/9.
//  Copyright © 2018年 谢兴达. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XDTitleBarDelegate <NSObject>
@optional
- (void)xd_titleBarItemTapAtIndex:(NSIndexPath *)idx;
@end

@interface XDTitleBar : UIView
//默认item大小，只读
@property (nonatomic, assign, readonly) CGSize defaultItemSize;

//标题数组
@property (nonatomic, strong) NSArray *titles;

//item大小
@property (nonatomic, assign) CGSize itemSize;

//文字属性
@property (nonatomic, strong) UIColor *highlightTintColor;
@property (nonatomic, strong) UIColor *defaultTintColor;
@property (nonatomic, strong) UIColor *barBackColor;
@property (nonatomic, strong) UIFont *textFont;
@property (nonatomic,strong) UIColor *lineColor;
@property (nonatomic,assign)CGSize lineSize;


@property (nonatomic, weak) id <XDTitleBarDelegate> delegate;

@property (nonatomic, copy) void (^barIndexChangedBlock)(NSInteger index);
@end
