//
//  SMDampOtherCell.h
//  collectionView瀑布流
//
//  Created by apple on 2018/9/4.
//  Copyright © 2018年 ChengChao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMTrendListModel.h"
@interface SMDampOtherCell : UICollectionViewCell

@property (strong,nonatomic)SMTrendListModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (copy,nonatomic)void(^gotoLookBlock)(SMDampOtherCell *cell);
@end
