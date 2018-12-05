//
//  CCWelfareHeaderView.h
//  16Street
//
//  Created by apple on 2018/11/20.
//  Copyright © 2018年 toerax. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CWCarousel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCWelfareHeaderView : UIView
@property (strong,nonatomic)UIButton *classBtn;
@property (strong,nonatomic)UISegmentedControl *segmentCotrol;
@property (strong,nonatomic)CWCarousel *bannerView;
@property (strong,nonatomic)UILabel    *title;
@property (strong,nonatomic)UIButton   *moreBtn;
@property(copy,nonatomic)void(^segBlock)(NSInteger index);
@property(copy,nonatomic)void(^bannerBlock)(NSInteger index);
@property(copy,nonatomic)void(^buttonBlock)(NSInteger index);
@end

NS_ASSUME_NONNULL_END
