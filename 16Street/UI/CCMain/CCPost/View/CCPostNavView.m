//
//  CCPostNavView.m
//  16Street
//
//  Created by apple on 2018/11/13.
//  Copyright © 2018年 toerax. All rights reserved.
//

#import "CCPostNavView.h"

@implementation CCPostNavView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
        [self layout];
    }
    return self;
}

-(void)buttonClick:(UIButton *)sender{
    if (self.buttonBlock) {
        self.buttonBlock(sender.tag - 100);
    }
}

- (void)setUpUI{
    [self addSubview:self.backBtn];
    [self addSubview:self.title];
    [self addSubview:self.sendBtn];
}

- (void)layout{
    [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(60);
        make.left.mas_equalTo(self);
    }];
    
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(100);
        make.centerX.mas_equalTo(self);
    }];
    
    [_sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom).offset(-11);
        make.height.mas_equalTo(22);
        make.width.mas_equalTo(44);
        make.right.mas_equalTo(self.mas_right).offset(-20);
    }];
    
    
}

#pragma mark ************* 懒加载************
-(UIButton *)backBtn{
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _backBtn = [CCUtil createBtnTitle:@"" titleColor:kClearColor backgroundColor:kClearColor bgImageName:@"黑色返回" target:self action:@selector(buttonClick:)];
        _backBtn.tag = 100;
    }
    return _backBtn;
}

-(UILabel *)title{
    if (!_title) {
        _title = [CCUtil createLabelWithText:@"SHOW TIME" color:Color(51, 51, 51) font:BOLDSYSTEMFONT(14)];
    }
    return _title;
}

-(UIButton *)sendBtn{
    if (!_sendBtn) {
        _sendBtn = [CCUtil createBtnTitle:@"" titleColor:kClearColor backgroundColor:kClearColor bgImageName:@"发布" target:self action:@selector(buttonClick:)];
        _sendBtn.tag = 101;
    }
    return _sendBtn;
}

@end
