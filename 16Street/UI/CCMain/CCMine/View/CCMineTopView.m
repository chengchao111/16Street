//
//  CCMineTopView.m
//  16Street
//
//  Created by apple on 2018/10/11.
//  Copyright © 2018年 toerax. All rights reserved.
//

#import "CCMineTopView.h"

@interface CCMineTopView ()


@end

@implementation CCMineTopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
        [self addLayout];
    }
    return self;
}

#pragma mark ************* 按钮回调************
-(void)buttonCick:(UIButton *)sender{
    if (_buttonBlock) {
        _buttonBlock(sender.tag);
    }
}


#pragma mark ************* UI************
- (void)setUpUI{
    [self addSubview:self.imageView];
    [self addSubview:self.level];
    [self addSubview:self.likeAndFollow];
    [self addSubview:self.nikeName];
    [self addSubview:self.headerBtn];
    [self addSubview:self.levelLog];
    [self addSubview:self.backBtn];
    [self addSubview:self.settingBtn];

}


#pragma mark ************* 懒加载************
//背景
-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithImage:IMAGE(@"背景")];
    }
    return _imageView;
}

//返回按钮
-(UIButton *)backBtn{
    if (!_backBtn) {
        
        _backBtn = [CCUtil createBtnTitle:@"" titleColor:kClearColor backgroundColor:kClearColor bgImageName:@"白色返回" target:self action:@selector(buttonCick:)];
        _backBtn.tag = 100;
        _backBtn.hidden = YES;
    }
    return _backBtn;
}

//设置
-(UIButton *)settingBtn{
    if (!_settingBtn) {
        _settingBtn = [CCUtil createBtnTitle:@"设置" titleColor:kWhiteColor backgroundColor:kClearColor bgImageName:@"" target:self action:@selector(buttonCick:)];
        _settingBtn.tag = 101;
        _settingBtn.titleLabel.font = SYSTEMFONT(14);
    }
    return _settingBtn;
}

//头像
-(UIButton *)headerBtn{
    if (!_headerBtn) {
        _headerBtn = [CCUtil createBtnTitle:@"" titleColor:kClearColor backgroundColor:kClearColor bgImageName:@"defaultHead" target:self action:@selector(buttonCick:)];
        _headerBtn.tag = 102;
        _headerBtn.clipsToBounds = YES;
        _headerBtn.cornerRadius = 27;
        
    }
    return _headerBtn;
}

//级别Log
-(UIImageView *)levelLog{
    if (!_levelLog) {
        _levelLog = [CCUtil createImageViewWithImageName:@"个人主页vip"];
        _levelLog.backgroundColor = kClearColor;
    }
    return _levelLog;
}

//昵称
-(UILabel *)nikeName{
    if (!_nikeName) {
        _nikeName = [CCUtil createLabelWithText:@"11" color:kWhiteColor font:BOLDSYSTEMFONT(14)];
    }
    return _nikeName;
}

//关注和点赞
-(UILabel *)likeAndFollow{
    if (!_likeAndFollow) {
        _likeAndFollow = [CCUtil createLabelWithText:@"11" color:kWhiteColor font:SYSTEMFONT(12)];
    }
    return _likeAndFollow;
}

//认证标示
-(UILabel *)level{
    if (!_level) {
      
        _level = [CCUtil createLabelWithText:@"11" color:kWhiteColor font:SYSTEMFONT(10)];
    }
    return _level;
}


#pragma mark ************* 控件约束************
-(void)addLayout{

    //背景
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    
    [_level mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.imageView.mas_bottom).offset(-30);
        make.width.mas_equalTo(SCREEN_WIDTH - 60);
        make.centerX.mas_equalTo(self);
        make.height.mas_equalTo(14);
    }];

    [_likeAndFollow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.level.mas_top).offset(-6);
        make.width.mas_equalTo(SCREEN_WIDTH - 60);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.height.mas_equalTo(16);
    }];

    [_nikeName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.likeAndFollow.mas_top).offset(-6);
        make.width.mas_equalTo(SCREEN_WIDTH - 60);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.height.mas_equalTo(20);
    }];

    [_headerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.nikeName.mas_top).offset(-6);
        make.width.mas_equalTo(54);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.height.mas_equalTo(54);
    }];

    [_levelLog mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.headerBtn.mas_bottom);
        make.width.mas_equalTo(16);
        make.right.mas_equalTo(self.headerBtn.mas_right);
        make.height.mas_equalTo(16);
    }];

    [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.headerBtn.mas_top).offset(-10);
        make.width.mas_equalTo(60);
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(34);
    }];

    [_settingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.backBtn.mas_centerY);
        make.width.mas_equalTo(60);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(34);
    }];
}
@end
