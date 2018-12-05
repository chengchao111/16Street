//
//  CCPostCell.h
//  16Street
//
//  Created by apple on 2018/11/13.
//  Copyright © 2018年 toerax. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CCPostCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UIButton *deletBtn;
@property (strong,nonatomic)UIImage *photo;
@property (copy,nonatomic)void(^deleteBtnBlock)(CCPostCell *cell);
@end

NS_ASSUME_NONNULL_END
