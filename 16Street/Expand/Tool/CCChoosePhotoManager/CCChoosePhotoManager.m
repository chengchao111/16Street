//
//  CCChoosePhotoManager.m
//  16Street
//
//  Created by apple on 2018/11/13.
//  Copyright © 2018年 toerax. All rights reserved.
//

#import "CCChoosePhotoManager.h"


@implementation CCChoosePhotoManager
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
