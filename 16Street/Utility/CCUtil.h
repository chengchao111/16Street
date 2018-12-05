//
//  CCUtil.h
//  16Street
//
//  Created by apple on 2018/10/11.
//  Copyright © 2018年 toerax. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface CCUtil : NSObject

/**
 创建标签

 @param frame 标签frame
 @param text 文字
 @param textColor w文字颜色
 @param textAlignment 格式
 @param numberOfLines 行数
 @return UIlabel
 */
+ (UILabel *)createLabelWithText:(NSString *)text textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment numberOfLines:(NSInteger)numberOfLines font:(UIFont *)font;


/**
 * 创建标签
 */
+ (UILabel *)createLabelWithText:(NSString *)text color:(UIColor *)textColor font:(UIFont *)font;



/**
 * 创建按钮
 */
+ (UIButton *)createBtnTitle:(NSString *)title titleColor:(UIColor *)titleColor backgroundColor:(UIColor *)backgroundColor bgImageName:(NSString *)bgImageName target:(id)target action:(SEL)action;

/**
 * 创建imageView
 */
+ (UIImageView *)createImageViewWithImageName:(NSString *)imageName;

/**
 * 创建视图
 */
+ (UIView *)createViewViewWithBackgroundColor:(UIColor *)backgroundColor;

+(UITextField *)creatTextFieldWithPlaceHolder:(NSString *)placeHolder;


@end

NS_ASSUME_NONNULL_END
