//
//  CCPostNavView.h
//  16Street
//
//  Created by apple on 2018/11/13.
//  Copyright © 2018年 toerax. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CCPostNavView : UIView
@property (strong,nonatomic)UIButton *backBtn;
@property (strong,nonatomic)UILabel  *title;
@property (strong,nonatomic)UIButton *sendBtn;

@property (copy,nonatomic)void(^buttonBlock)(NSInteger tag);
@end

NS_ASSUME_NONNULL_END
