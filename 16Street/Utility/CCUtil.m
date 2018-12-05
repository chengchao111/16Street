//
//  CCUtil.m
//  16Street
//
//  Created by apple on 2018/10/11.
//  Copyright © 2018年 toerax. All rights reserved.
//

#import "CCUtil.h"

@implementation CCUtil

/**
 创建标签
 @param text 文字
 @param textColor w文字颜色
 @param textAlignment 格式
 @param numberOfLines 行数
 @return UIlabel
 */
+ (UILabel *)createLabelWithText:(NSString *)text textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment numberOfLines:(NSInteger)numberOfLines font:(UIFont *)font{
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    
    label.text = text;
    
    label.font = font;
    
    label.textAlignment = textAlignment;
    
    label.textColor = textColor;
    
    label.numberOfLines = numberOfLines;
    
    return label;
}


/**
 * 创建标签
 */
+ (UILabel *)createLabelWithText:(NSString *)text color:(UIColor *)textColor font:(UIFont *)font{
    return [self createLabelWithText:text textColor:textColor textAlignment:(NSTextAlignmentCenter) numberOfLines:1 font:font];
}



/**
 * 创建按钮
 */
+ (UIButton *)createBtnTitle:(NSString *)title titleColor:(UIColor *)titleColor backgroundColor:(UIColor *)backgroundColor bgImageName:(NSString *)bgImageName target:(id)target action:(SEL)action{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.frame = CGRectMake(0, 0, 0, 0);
    
    [btn setTitle:title forState:UIControlStateNormal];
    
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    
    [btn setBackgroundColor:backgroundColor];
    
    [btn setImage:[UIImage imageNamed:bgImageName] forState:UIControlStateNormal];
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
    
}



/**
 * 创建imageView
 */
+ (UIImageView *)createImageViewWithImageName:(NSString *)imageName{
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:IMAGE(imageName)];
    
    return imageView;
}

/**
 * 创建视图
 */
+ (UIView *)createViewViewWithBackgroundColor:(UIColor *)backgroundColor{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    
    view.backgroundColor = backgroundColor;
    
    return view;
}

+(UITextField *)creatTextFieldWithPlaceHolder:(NSString *)placeHolder{
    UITextField *textFiled = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    textFiled.placeholder = placeHolder;
    return textFiled;
}




@end
