//
//  CCMineSettingView.m
//  16Street
//
//  Created by apple on 2018/10/29.
//  Copyright © 2018年 toerax. All rights reserved.
//

#import "CCMineSettingView.h"

@implementation CCMineSettingView

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

    [self addSubview:self.changePassword];
    [self addSubview:self.loginOut];
}


#pragma mark ************* Action************
- (void)buttonClick:(UIButton *)sender{
    if (_buttonBlock) {
        self.buttonBlock(sender.tag - 100);
    }
}
#pragma mark ************* 约束************
- (void)layout{
    [_changePassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.width.mas_equalTo(self);
        make.height.mas_equalTo(58);
        make.centerX.mas_equalTo(self);
    }];
    
    [_loginOut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.changePassword.mas_bottom);
        make.width.height.centerX.mas_equalTo(self.changePassword);
    }];
    
}

#pragma mark ************* 懒加载************
-(UIButton *)changePassword{
    if (!_changePassword) {
        _changePassword = [CCUtil createBtnTitle:@"修改密码" titleColor:kBlackColor backgroundColor:kClearColor bgImageName:@"center_spread" target:self action:@selector(buttonClick:)];
        _changePassword.titleLabel.font = SYSTEMFONT(14);
        _changePassword.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _changePassword.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        _changePassword.imageEdgeInsets = UIEdgeInsetsMake(0, SCREEN_WIDTH - 40, 0, 0);
        _changePassword.tag = 100;
    }
    return _changePassword;
}

-(UIButton *)loginOut{
    if (!_loginOut) {
        _loginOut = [CCUtil createBtnTitle:@"退出登录" titleColor:kOrangeColor backgroundColor:kClearColor bgImageName:@"" target:self action:@selector(buttonClick:)];
        _loginOut.titleLabel.font = SYSTEMFONT(14);
        _loginOut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _loginOut.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        _loginOut.tag = 101;
    }
    return _loginOut;
}

@end
