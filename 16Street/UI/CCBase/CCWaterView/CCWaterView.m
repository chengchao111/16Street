//
//  CCWaterView.m
//  16Street
//
//  Created by apple on 2018/10/11.
//  Copyright © 2018年 toerax. All rights reserved.
//

#import "CCWaterView.h"

@implementation CCWaterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI{
    
    [self addSubview:self.collectionView];
}


/**
 瀑布流表示图
 
 @return 返回 waterfallCollectionView
 */
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        LMJVerticalFlowLayout *layout = [[LMJVerticalFlowLayout alloc] initWithDelegate:self];
        _collectionView = [[UICollectionView alloc]initWithFrame:self.frame collectionViewLayout:layout];
        _collectionView.backgroundColor = BasicViewColor;
        //隐藏滑动条
        _collectionView.showsVerticalScrollIndicator = NO;
    }
    return _collectionView;
}

@end
