//
//  CCLoginView.h
//  16Street
//
//  Created by apple on 2018/10/11.
//  Copyright © 2018年 toerax. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CCLoginView : UIView
@property (strong,nonatomic)UIButton     *backBtn;
@property (strong,nonatomic)UIButton     *goLoginBtn;
@property (strong,nonatomic)UILabel      *fullStopLabel;
@property (strong,nonatomic)UIButton     *goRegisterBtn;
@property (strong,nonatomic)UITextField  *phoneTextfield;
@property (strong,nonatomic)UIView       *phoneLine;
@property (strong,nonatomic)UITextField  *passwordTextfield;
@property (strong,nonatomic)UIView       *passwordLine;
@property (strong,nonatomic)UIButton     *phoneCodeLoginBtn;
@property (strong,nonatomic)UIButton     *forgetPaswordBtn;
@property (strong,nonatomic)UIButton     *loginBtn;
@property (strong,nonatomic)UIButton     *userDelegateBtn;
@property (nonatomic,copy)void(^buttonBlock)(NSInteger tag);
@end

NS_ASSUME_NONNULL_END
