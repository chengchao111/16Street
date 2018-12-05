//
//  CCBannerCell.h
//  16Street
//
//  Created by apple on 2018/11/21.
//  Copyright © 2018年 toerax. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class CCHomePageBannerModel;
@interface CCBannerCell : UICollectionViewCell
@property(strong,nonatomic)CCHomePageBannerModel *model;
@property (strong,nonatomic)UIImageView *imageView;

@end

NS_ASSUME_NONNULL_END
