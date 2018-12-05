//
//  CCMineSettingView.h
//  16Street
//
//  Created by apple on 2018/10/29.
//  Copyright © 2018年 toerax. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CCMineSettingView : UIView
@property (strong,nonatomic)UIButton *changePassword;
@property (strong,nonatomic)UIButton *loginOut;
@property (nonatomic,copy)void(^buttonBlock)(NSInteger tag);
@end

NS_ASSUME_NONNULL_END
