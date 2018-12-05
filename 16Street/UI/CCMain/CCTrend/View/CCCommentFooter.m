//
//  CCCommentFooter.m
//  16Street
//
//  Created by apple on 2018/11/26.
//  Copyright © 2018年 toerax. All rights reserved.
//

#import "CCCommentFooter.h"

@implementation CCCommentFooter

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
        [self layout];
    }
    return self;
}

-(void)setModel:(CCCommendListModel *)model{
    _model = model;
    self.time.text = model.AddTimeStr;
}


- (void)buttonClick{
    if (self.footerBlock) {
        self.footerBlock();
    }
    
}

- (void)setUpUI{
    [self addSubview:self.time];
    [self addSubview:self.contentBtn];
}


-(void)layout{
    [_contentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-22);
        make.width.height.mas_equalTo(15);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    
    [_time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(76);
        make.height.mas_equalTo(12);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.right.mas_equalTo(self.contentBtn.mas_right).offset(-20);
    }];
}


-(UIButton *)contentBtn{
    if (!_contentBtn) {
        _contentBtn = [CCUtil createBtnTitle:@"" titleColor:kClearColor backgroundColor:kClearColor bgImageName:@"详情评论" target:self action:@selector(buttonClick)];
        
    }
    return _contentBtn;
}



-(UILabel *)time{
    if (!_time) {
        _time = [CCUtil createLabelWithText:@"" color:NormalColor font:SYSTEMFONT(12)];
        _time.textAlignment = NSTextAlignmentLeft;
    }
    return _time;
}



@end
