//
//  CCTabBar.h
//  SixTeenHourShoppingMall
//
//  Created by apple on 2018/10/10.
//  Copyright © 2018年 toerax. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CCTabBar : UITabBar
@property (nonatomic, strong) UIButton *centerBtn; //中间按钮

@property (copy,nonatomic)void(^centerBtnBlock)(void);
@end

NS_ASSUME_NONNULL_END
