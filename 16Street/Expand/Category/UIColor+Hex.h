//
//  UIColor+Hex.h
//  New16Hour
//
//  Created by chenfeng on 2018/8/9.
//  Copyright © 2018年 ChengChao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)

//根据颜色值获取颜色
+ (UIColor *)colorOfHex:(int)value;

@end
