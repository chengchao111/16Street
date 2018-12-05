//
//  CCSixStreenTableHeaderView.m
//  16Street
//
//  Created by apple on 2018/10/24.
//  Copyright © 2018年 toerax. All rights reserved.
//

#import "CCSixStreenTableHeaderView.h"

@implementation CCSixStreenTableHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kWhiteColor;
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI{
    NSArray *imageArr = @[@"会员卡",@"足迹",@"收藏",@"评论"];
    NSArray *titleArr = @[@"会员卡",@"足迹",@"收藏",@"评论"];
    for (int i = 0; i < 4; i ++) {
        UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(20 + (SCREEN_WIDTH - 40)/4 * i, 18, (SCREEN_WIDTH - 40)/4, 34)];
        imageview.image = IMAGE(imageArr[i]);
        [imageview setContentMode:(UIViewContentModeScaleAspectFit)];
        [self addSubview:imageview];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20 + (SCREEN_WIDTH - 40)/4 * i, 54, (SCREEN_WIDTH - 40)/4, 20)];
        label.text = titleArr[i];
        label.font = SYSTEMFONT(14);
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = Color(51, 51, 51);
        [self addSubview:label];
        
        self.button = [UIButton buttonWithType:(UIButtonTypeCustom)];
        self.button.frame = CGRectMake(20 + (SCREEN_WIDTH - 40)/4 * i, 0, (SCREEN_WIDTH - 40)/4, CGRectGetHeight(self.bounds));
        _button.tag = 100 + i;
        self.button.backgroundColor = kClearColor;
        self.button.titleLabel.font = SYSTEMFONT(14);
        [self.button addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:self.button];
    }
   
}

-(void)buttonClick:(UIButton *)sender{
    if (_headerBlock) {
        _headerBlock(sender.tag - 100);
    }
}

@end
