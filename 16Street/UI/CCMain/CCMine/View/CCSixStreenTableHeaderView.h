//
//  CCSixStreenTableHeaderView.h
//  16Street
//
//  Created by apple on 2018/10/24.
//  Copyright © 2018年 toerax. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CCSixStreenTableHeaderView : UIView
@property (strong,nonatomic)UIButton *button;
@property (nonatomic,copy)void(^headerBlock)(NSInteger tag);
@end

NS_ASSUME_NONNULL_END
