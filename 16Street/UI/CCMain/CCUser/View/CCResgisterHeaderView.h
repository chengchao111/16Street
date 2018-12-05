//
//  CCResgisterHeaderView.h
//  16Street
//
//  Created by apple on 2018/11/12.
//  Copyright © 2018年 toerax. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CCResgisterHeaderView : UIView

@property (strong,nonatomic)UIButton *loginBtn;

@property (strong,nonatomic)UIButton *registerBtn;

@property (copy,nonatomic)void(^buttonBlock)(NSInteger tag);

@end

NS_ASSUME_NONNULL_END
