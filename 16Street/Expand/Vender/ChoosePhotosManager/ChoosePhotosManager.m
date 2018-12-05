//
//  ChoosePhotosManager.m
//  New16Hour
//
//  Created by apple on 2018/9/3.
//  Copyright © 2018年 ChengChao. All rights reserved.
//

#import "ChoosePhotosManager.h"
#import <TZImagePickerController.h>
@implementation ChoosePhotosManager

#pragma mark --图片选择器
+(void)choosePhotosWithController:(UIViewController *)rootVC MaxImageCount:(NSInteger)count fromSystemPhotosLibraayCompltion:(ChoosePhotosCompltion)compltionBlock{
    
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:count delegate:nil];
    // 获取用户选择的照片
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        if (compltionBlock) {
            compltionBlock(photos);
        }
    }];
    [rootVC presentViewController:imagePickerVc animated:YES completion:nil];
}

@end
