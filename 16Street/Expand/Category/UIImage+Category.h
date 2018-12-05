//
//  UIImage+Category.h
//  New16Hour
//
//  Created by apple on 2018/8/1.
//  Copyright © 2018年 ChengChao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Category)
//翻转图片
- (UIImage *)fixOrientation;

//剪裁图片
- (UIImage *)cutImage:(UIImage*)image WithbgImageViewSize:(CGSize)size;

//压缩图片
- (UIImage *)imageWithImage:(UIImage*)image
               scaledToSize:(CGSize)newSize;
//颜色转image
+ (UIImage*)getImageWithColor:(UIColor*)color andHeight:(CGFloat)height;

+ (UIImage *)stringToImage:(NSString *)str;

@end
