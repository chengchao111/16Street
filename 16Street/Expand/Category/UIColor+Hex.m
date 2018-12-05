//
//  UIColor+Hex.m
//  New16Hour
//
//  Created by chenfeng on 2018/8/9.
//  Copyright © 2018年 ChengChao. All rights reserved.
//

#import "UIColor+Hex.h"

@implementation UIColor (Hex)

+ (UIColor *)colorOfHex:(int)value{
    float red   = ((value & 0xFF0000) >> 16) / 255.0;
    float green = ((value & 0xFF00) >> 8) / 255.0;
    float blue  = (value & 0xFF) / 255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

@end
