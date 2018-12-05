//
//  CCTrendView.h
//  16Street
//
//  Created by apple on 2018/10/10.
//  Copyright © 2018年 toerax. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CCTrendView : UIView
@property (strong,nonatomic)UISegmentedControl *segmentControl;
@property (copy,nonatomic)void(^segmentChangeBlock)(NSInteger index);
@end

NS_ASSUME_NONNULL_END
