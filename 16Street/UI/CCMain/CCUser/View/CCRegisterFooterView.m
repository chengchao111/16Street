//
//  CCRegisterFooterView.m
//  16Street
//
//  Created by apple on 2018/11/12.
//  Copyright © 2018年 toerax. All rights reserved.
//

#import "CCRegisterFooterView.h"

@implementation CCRegisterFooterView

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
    [self addSubview:self.logBtn];
    [self addSubview:self.userDelegateBtn];
    [self addSubview:self.buton];
}

#pragma mark ************* Action************

- (void)buttonClick:(UIButton *)sender{

    if (sender.tag == 100) {
        self.logBtn.selected =! self.logBtn.selected;
    }
    
    if (self.buttonBlock) {
        self.buttonBlock(sender.tag - 100);
    }
}

-(UIButton *)logBtn{
    if (!_logBtn) {
        _logBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_logBtn setBackgroundImage:IMAGE(@"协议未选中") forState:(UIControlStateNormal)];
        [_logBtn setImage:IMAGE(@"协议选中") forState:(UIControlStateSelected)];
        [_logBtn addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        _logBtn.tag = 100;
        
    }
    return _logBtn;
}

-(UIButton *)userDelegateBtn{
    if (!_userDelegateBtn) {
        NSString *str = @"我已阅读并同意【16HOME多多折隐私条例和服务条款】";
        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:str];
        [AttributedStr addAttribute:NSForegroundColorAttributeName
                              value:DeSelectTextColor
                              range:NSMakeRange(0, 7)];
        [AttributedStr addAttribute:NSForegroundColorAttributeName
                              value:ThemeOrangeColor
                              range:NSMakeRange(7, str.length - 7)];
        _userDelegateBtn = [CCUtil createBtnTitle:@"" titleColor:DeSelectTextColor backgroundColor:kClearColor bgImageName:@"" target:self action:@selector(buttonClick:)];
         [_userDelegateBtn setAttributedTitle:AttributedStr forState:(UIControlStateNormal)];
        [_userDelegateBtn setContentHorizontalAlignment:(UIControlContentHorizontalAlignmentLeft)];
        _userDelegateBtn.titleLabel.font = SYSTEMFONT(10);
        _userDelegateBtn.tag = 101;
    }
    return _userDelegateBtn;
}

-(UIButton *)buton{
    if (!_buton) {
        _buton = [CCUtil createBtnTitle:@"注册" titleColor:kWhiteColor backgroundColor:kClearColor bgImageName:@"" target:self action:@selector(buttonClick:)];
        _buton.tag = 102;
        [_buton setBackgroundImage:IMAGE(@"注册按钮") forState:(UIControlStateNormal)];
    }
    return _buton;
}

- (void)layout{
    [_logBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(34);
        make.width.mas_offset(16);
        make.height.mas_offset(16);
        make.top.mas_equalTo(14);

    }];
    
    [_userDelegateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.logBtn.mas_right);
        make.right.mas_equalTo(-34);
        make.height.mas_equalTo(16);
        make.top.mas_equalTo(14);
    }];
    
    [_buton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(34);
        make.right.mas_equalTo(-34);
        make.height.mas_equalTo(44);
        make.top.mas_equalTo(48);
    }];
    
    
}


@end
