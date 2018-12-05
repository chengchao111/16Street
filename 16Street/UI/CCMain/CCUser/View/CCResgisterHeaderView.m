//
//  CCResgisterHeaderView.m
//  16Street
//
//  Created by apple on 2018/11/12.
//  Copyright © 2018年 toerax. All rights reserved.
//

#import "CCResgisterHeaderView.h"

@implementation CCResgisterHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
        [self layout];
    }
    return self;
}


- (void)setUpUI{
    [self addSubview:self.loginBtn];
    [self addSubview:self.registerBtn];
}

#pragma mark ************* Action************
-(void)buttonClick:(UIButton *)sender{
    if (self.buttonBlock) {
        self.buttonBlock(sender.tag - 100);
    }
}

#pragma mark ************* 懒加载************
-(UIButton *)loginBtn{
    if (!_loginBtn) {
        _loginBtn = [CCUtil createBtnTitle:@"登陆" titleColor:DeSelectTextColor backgroundColor:kClearColor bgImageName:@"" target:self action:@selector(buttonClick:)];
        _loginBtn.titleLabel.font = BOLDSYSTEMFONT(22);
        _loginBtn.tag = 100;
    }
    return _loginBtn;
}


-(UIButton *)registerBtn{
    if (!_registerBtn) {
        _registerBtn = [CCUtil createBtnTitle:@"注册" titleColor:SelectTextColor backgroundColor:kClearColor bgImageName:@"" target:self action:@selector(buttonClick:)];
        _registerBtn.titleLabel.font = BOLDSYSTEMFONT(22);
        _registerBtn.tag = 101;
    }
    return _registerBtn;
}

- (void)layout{
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(34);
        make.height.mas_equalTo(30);
        make.top.mas_equalTo(90);
        make.width.mas_equalTo(45);
    }];
    
    [self.registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.loginBtn.mas_right).offset(30);
        make.height.mas_equalTo(30);
        make.top.mas_equalTo(90);
        make.width.mas_equalTo(45);
    }];
}


@end
