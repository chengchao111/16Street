//
//  CCRegisterFooterView.h
//  16Street
//
//  Created by apple on 2018/11/12.
//  Copyright © 2018年 toerax. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CCRegisterFooterView : UIView
@property (strong,nonatomic)UIButton *logBtn;

@property (strong,nonatomic)UIButton *userDelegateBtn;

@property (strong,nonatomic)UIButton *buton;

@property (copy,nonatomic)void(^buttonBlock)(NSInteger tag);

@end

NS_ASSUME_NONNULL_END
