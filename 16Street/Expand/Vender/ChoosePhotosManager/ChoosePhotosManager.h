//
//  ChoosePhotosManager.h
//  New16Hour
//
//  Created by apple on 2018/9/3.
//  Copyright © 2018年 ChengChao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ChoosePhotosCompltion)(NSArray *images);

@interface ChoosePhotosManager : NSObject

/**
 *
 *图片选择器
 */
+(void)choosePhotosWithController:(UIViewController *)rootVC MaxImageCount:(NSInteger)count fromSystemPhotosLibraayCompltion:(ChoosePhotosCompltion)compltionBlock;

@end
