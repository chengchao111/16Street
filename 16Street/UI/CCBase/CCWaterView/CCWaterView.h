//
//  CCWaterView.h
//  16Street
//
//  Created by apple on 2018/10/11.
//  Copyright © 2018年 toerax. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMJVerticalFlowLayout.h"
//#import "SMDampNomalCell.h"
//#import "SMDampOtherCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface CCWaterView : UIView<LMJVerticalFlowLayoutDelegate>

@property (strong,nonatomic)UICollectionView *collectionView;

@end

NS_ASSUME_NONNULL_END
