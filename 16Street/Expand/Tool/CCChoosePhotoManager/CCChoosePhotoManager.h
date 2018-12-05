//
//  CCChoosePhotoManager.h
//  16Street
//
//  Created by apple on 2018/11/13.
//  Copyright © 2018年 toerax. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TZImagePickerController.h>
NS_ASSUME_NONNULL_BEGIN
typedef void(^ChoosePhotosCompltion)(NSArray *images);

@interface CCChoosePhotoManager : NSObject<TZImagePickerControllerDelegate>
/**
 *
 *图片选择器
 */
+(void)choosePhotosWithController:(UIViewController *)rootVC MaxImageCount:(NSInteger)count fromSystemPhotosLibraayCompltion:(ChoosePhotosCompltion)compltionBlock;

@end

NS_ASSUME_NONNULL_END
