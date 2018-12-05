//
//  CCTrendDetailBarView.m
//  16Street
//
//  Created by apple on 2018/11/23.
//  Copyright © 2018年 toerax. All rights reserved.
//

#import "CCTrendDetailBarView.h"

@interface CCTrendDetailBarView ()

@property (strong,nonatomic)UIButton *button;
@end

@implementation CCTrendDetailBarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = Color(255, 255, 255);
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI{
    NSArray *titles = @[@"分享",@"评论",@"点赞"];
    NSArray *nomalImages = @[@"详情分享",@"详情评论",@"详情点赞前"];
    NSArray *selectImages = @[@"详情分享",@"详情评论",@"详情点赞后"];
     CGFloat with = (SCREEN_WIDTH - 2)/3;
    for (int i = 0; i < titles.count ; i ++) {
        _button = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_button setTitle:titles[i] forState:(UIControlStateNormal)];
        [_button setImage:IMAGE(nomalImages[i]) forState:(UIControlStateNormal)];
        [_button setImage:IMAGE(selectImages[i]) forState:(UIControlStateSelected)];
        [_button setTitleColor:DeSelectTextColor forState:(UIControlStateNormal)];
        _button.tag = 100 + i;
        [_button addTarget:selectImages action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:_button];
        
       
        [_button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.width.mas_equalTo(with);
            make.bottom.mas_equalTo(-NoTababarHeight);
            make.left.mas_equalTo(self.mas_left).offset((with + 1)* i);
        }];
    }
    
    for (int i = 0; i < 2; i ++) {
        UIView *view = [CCUtil createViewViewWithBackgroundColor:Color(239, 239, 239)];
        [self addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.button.mas_centerY);
            make.height.mas_equalTo(30);
            make.left.mas_equalTo(with + (with + 1) * i);
            make.width.mas_equalTo(1);
        }];
    }
    
}


- (void)buttonClick:(UIButton *)sender{
    
    sender.selected =! sender.selected;
    if (self.BarBtnBlock) {
        self.BarBtnBlock(sender.tag - 100);
    }
}

@end
