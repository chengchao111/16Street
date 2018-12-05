//
//  SMDampNomalCell.h
//  collectionView瀑布流
//
//  Created by apple on 2018/9/4.
//  Copyright © 2018年 ChengChao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMTrendListModel.h"
@interface SMDampNomalCell : UICollectionViewCell

@property (strong,nonatomic) SMTrendListModel *model;

/**
 照片
 */
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

/**
 按钮block
 */
@property(copy,nonatomic)void(^buttonClickBlock)(SMDampNomalCell *cell,NSInteger tag);

@end
