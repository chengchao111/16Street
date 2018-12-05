//
//  CCLoginView.m
//  16Street
//
//  Created by apple on 2018/10/11.
//  Copyright © 2018年 toerax. All rights reserved.
//

#import "CCLoginView.h"

@interface CCLoginView ()



@end

@implementation CCLoginView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = BasicViewColor;
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI{
    [self addSubview:self.backBtn];
    [self addSubview:self.goLoginBtn];
    [self addSubview:self.fullStopLabel];
    [self addSubview:self.goRegisterBtn];
    [self addSubview:self.phoneTextfield];
    [self addSubview:self.phoneLine];
    [self addSubview:self.passwordTextfield];
    [self addSubview:self.passwordLine];
    [self addSubview:self.phoneCodeLoginBtn];
    [self addSubview:self.forgetPaswordBtn];
    [self addSubview:self.loginBtn];
    [self addSubview:self.userDelegateBtn];
    [self layout];
}

#pragma mark ************* 按钮点击回调************
-(void)buttonClick:(UIButton *)sender{
    if (_buttonBlock) {
        _buttonBlock(sender.tag);
    }
}

#pragma mark ************* 控件约束************
-(void)layout{
    [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kStatusBarHeight + 10);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(34);
        make.left.mas_equalTo(0);
    }];
    
    [_goLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.backBtn.mas_bottom).offset(90);
        make.width.mas_equalTo(46);
        make.height.mas_equalTo(30);
        make.left.mas_equalTo(48);
    }];
    
    [_fullStopLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.goLoginBtn.mas_top).offset(10);
        make.width.mas_equalTo(23);
        make.height.mas_equalTo(30);
        make.left.mas_equalTo(self.goLoginBtn.mas_right);
    }];
    
    [_goRegisterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.goLoginBtn.mas_top);
        make.width.mas_equalTo(46);
        make.height.mas_equalTo(30);
        make.left.mas_equalTo(self.goLoginBtn.mas_right).offset(35);
    }];
    
    [_phoneTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.goLoginBtn.mas_bottom).offset(46);
        make.right.mas_equalTo(-36);
        make.height.mas_equalTo(58);
        make.left.mas_equalTo(36);
    }];
    
    [_phoneLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.phoneTextfield.mas_bottom);
        make.right.mas_equalTo(-36);
        make.height.mas_equalTo(1);
        make.left.mas_equalTo(36);
    }];
    
    [_passwordTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.phoneTextfield.mas_bottom).offset(1);
        make.right.mas_equalTo(-36);
        make.height.mas_equalTo(58);
        make.left.mas_equalTo(36);
    }];
    
    [_passwordLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.passwordTextfield.mas_bottom);
        make.right.mas_equalTo(-36);
        make.height.mas_equalTo(1);
        make.left.mas_equalTo(36);
    }];
    
    [_phoneCodeLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.passwordLine.mas_bottom).offset(14);
        make.left.mas_equalTo(self.passwordLine.mas_left);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(72);
    }];
    
    [_forgetPaswordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.phoneCodeLoginBtn.mas_top);
        make.right.mas_equalTo(self.passwordLine.mas_right);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(60);
    }];
    
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.phoneCodeLoginBtn.mas_bottom).offset(48);
        make.width.mas_equalTo(self.passwordLine.mas_width);
        make.height.mas_equalTo(44);
        make.centerX.mas_equalTo(self.passwordLine.mas_centerX);
    }];
    
    [_userDelegateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom).offset(-NoTababarHeight - 50);
        make.width.mas_equalTo(280);
        make.height.mas_equalTo(14);
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
}

#pragma mark ************* 懒加载************
//返回按钮
-(UIButton *)backBtn{
    if (!_backBtn) {
        _backBtn = [CCUtil createBtnTitle:@"" titleColor:kClearColor backgroundColor:kClearColor bgImageName:@"黑色返回" target:self action:@selector(buttonClick:)];

        _backBtn.tag = 100;
        
    }
    return _backBtn;
}

//登陆
-(UIButton *)goLoginBtn{
    if (!_goLoginBtn) {
        _goLoginBtn = [CCUtil createBtnTitle:@"登陆" titleColor:kBlackColor backgroundColor:kClearColor bgImageName:@"" target:self action:@selector(buttonClick:)];
        _goLoginBtn.titleLabel.font = BOLDSYSTEMFONT(22);
        _goLoginBtn.tag = 101;
    }
    return _goLoginBtn;
}

-(UILabel *)fullStopLabel{
    if (!_fullStopLabel) {
        _fullStopLabel = [CCUtil createLabelWithText:@"。" color:kBlackColor font:0];
        _fullStopLabel.font = BOLDSYSTEMFONT(28);
    }
    return _fullStopLabel;
}


-(UIButton *)goRegisterBtn{
    if (!_goRegisterBtn) {
  
        _goRegisterBtn = [CCUtil createBtnTitle:@"注册" titleColor:Color(202, 202, 202) backgroundColor:kClearColor bgImageName:@"" target:self action:@selector(buttonClick:)];
        _goRegisterBtn.titleLabel.font = BOLDSYSTEMFONT(22);
        _goRegisterBtn.tag = 102;
    }
    return _goRegisterBtn;
}

-(UITextField *)phoneTextfield{
    if (!_phoneTextfield) {
        _phoneTextfield = [CCUtil creatTextFieldWithPlaceHolder:@"请输入您的手机号"];
        _phoneTextfield.font = SYSTEMFONT(14);
        _phoneTextfield.keyboardType = UIKeyboardTypeNumberPad;
        _phoneTextfield.leftViewMode = UITextFieldViewModeAlways;
        UIImageView *leftImage = [[UIImageView alloc]initWithImage:IMAGE(@"注册-电话号码")];
        UIView *phoneView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 20)];
        leftImage.center = phoneView.center;
        [phoneView addSubview:leftImage];
        _phoneTextfield.leftView = phoneView;
    }
    return _phoneTextfield;
}

-(UIView *)phoneLine{
    if (!_phoneLine) {
        _phoneLine = [CCUtil createViewViewWithBackgroundColor:Color(215, 215, 215)];
    }
    return _phoneLine;
}

-(UITextField *)passwordTextfield{
    if (!_passwordTextfield) {
        _passwordTextfield = [CCUtil creatTextFieldWithPlaceHolder:@"请输入您的密码"];
        _passwordTextfield.font = SYSTEMFONT(14);
        _passwordTextfield.leftViewMode = UITextFieldViewModeAlways;
        UIImageView *leftImage = [[UIImageView alloc]initWithImage:IMAGE(@"注册密码")];
        UIView *phoneView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 20)];
        leftImage.center = phoneView.center;
        [phoneView addSubview:leftImage];
        _passwordTextfield.leftView = phoneView;
    }
    return _passwordTextfield;
}

-(UIView *)passwordLine{
    if (!_passwordLine) {
        _passwordLine = [CCUtil createViewViewWithBackgroundColor:Color(215, 215, 215)];
    }
    return _passwordLine;
}

-(UIButton *)phoneCodeLoginBtn{
    if (!_phoneCodeLoginBtn) {
        _phoneCodeLoginBtn = [CCUtil createBtnTitle:@"手机动态码登录" titleColor:Color(255, 178, 51) backgroundColor:kClearColor bgImageName:@"" target:self action:@selector(buttonClick:)];
        _phoneCodeLoginBtn.titleLabel.font = SYSTEMFONT(10);
        _phoneCodeLoginBtn.tag = 103;
        _phoneCodeLoginBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    return _phoneCodeLoginBtn;
}

-(UIButton *)forgetPaswordBtn{
    if (!_forgetPaswordBtn) {
        _forgetPaswordBtn = [CCUtil createBtnTitle:@"忘记密码?" titleColor:Color(255, 178, 51) backgroundColor:kClearColor bgImageName:@"" target:self action:@selector(buttonClick:)];
        _forgetPaswordBtn.titleLabel.font = SYSTEMFONT(10);
        _forgetPaswordBtn.tag = 104;
        _forgetPaswordBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
    return _forgetPaswordBtn;
}


-(UIButton *)loginBtn{
    if (!_loginBtn) {
        _loginBtn = [CCUtil createBtnTitle:@"登陆" titleColor:kWhiteColor backgroundColor:kClearColor bgImageName:@"" target:self action:@selector(buttonClick:)];
        _loginBtn.tag = 105;
        [_loginBtn setBackgroundImage:IMAGE(@"注册按钮") forState:(UIControlStateNormal)];
    }
    return _loginBtn;
}


-(UIButton *)userDelegateBtn{
    if (!_userDelegateBtn) {
        
        NSString *str = @"登陆即代表您已同意【16HOUR多多折隐私调理和用户条款】";
        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:str];
        
        [AttributedStr addAttribute:NSForegroundColorAttributeName
         
                              value:Color(202, 202, 202)
         
                              range:NSMakeRange(0, 9)];
        
        [AttributedStr addAttribute:NSForegroundColorAttributeName
         
                              value:Color(155, 178, 51)
         
                              range:NSMakeRange(9, str.length - 9)];
        _userDelegateBtn = [CCUtil  createBtnTitle:@"" titleColor:Color(155, 178, 51) backgroundColor:kClearColor bgImageName:@"" target:self action:@selector(buttonClick:)];
        [_userDelegateBtn setAttributedTitle:AttributedStr forState:(UIControlStateNormal)];
        _userDelegateBtn.titleLabel.font = SYSTEMFONT(10);
        _userDelegateBtn.tag = 106;
        _userDelegateBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    }
    return _userDelegateBtn;
}

@end
