
//
//  CCCommentTextView.m
//  16Street
//
//  Created by apple on 2018/11/28.
//  Copyright © 2018年 toerax. All rights reserved.
//

#import "CCCommentTextView.h"

@implementation CCCommentTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = Color(240, 240, 240);
        [self setUpUI];
        [self layout];
    }
    return self;
}


- (void)buttonClick:(UIButton *)sender{
    NSInteger index = sender.tag - 100;

    if (self.buttonBlock) {
        self.buttonBlock(index);
    }
}

- (void)setUpUI{
  
    [self addSubview:self.sureBtn];
    [self addSubview:self.textCount];
    [self addSubview:self.cancelBtn];
    [self addSubview:self.textView];
   
}

- (void)layout{

    
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-10);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(46);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-8);
    }];

    [self.textCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.sureBtn.mas_left).offset(-8);
        make.height.mas_equalTo(self.sureBtn);
        make.width.mas_equalTo(55);
        make.centerY.mas_equalTo(self.sureBtn);
    }];

    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.height.width.bottom.mas_equalTo(self.sureBtn);
    }];

    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.sureBtn.mas_right);
        make.left.mas_equalTo(self.cancelBtn.mas_left);
        make.bottom.mas_equalTo(self.sureBtn.mas_top).offset(-8);
        make.top.mas_equalTo(self.mas_top).offset(18);
    }];
    
}
#pragma mark ************* 懒加载************

-(UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn = [CCUtil createBtnTitle:@"取消" titleColor:Color(63, 63, 63) backgroundColor:kClearColor bgImageName:@"" target:self action:@selector(buttonClick:)];
        _cancelBtn.tag = 100;
        _cancelBtn.titleLabel.font = SYSTEMFONT(14);
    }
    return _cancelBtn;
}

-(UIButton *)sureBtn{
    if (!_sureBtn) {
        _sureBtn = [CCUtil createBtnTitle:@"确定" titleColor:kWhiteColor backgroundColor:Color(254, 170, 0) bgImageName:@"" target:self action:@selector(buttonClick:)];
        _sureBtn.titleLabel.font = SYSTEMFONT(14);
        _sureBtn.layer.cornerRadius = 6;
        _sureBtn.tag = 101;
    }
    return _sureBtn;
}

-(UILabel *)textCount{
    if (!_textCount) {
        _textCount = [CCUtil createLabelWithText:@"0/140" color:Color(63, 63, 63) font:SYSTEMFONT(14)];
    }
    return _textCount;
}

-(UITextView *)textView{
    if (!_textView) {
        _textView = [[UITextView alloc]init];
        _textView.backgroundColor = kWhiteColor;
        _textView.layer.cornerRadius = 10;
        _textView.layer.borderWidth = 1;
        _textView.layer.borderColor = Color(189, 189, 189).CGColor;
    }
    return _textView;
}

@end
