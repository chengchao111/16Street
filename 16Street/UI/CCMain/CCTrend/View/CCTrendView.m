//
//  CCTrendView.m
//  16Street
//
//  Created by apple on 2018/10/10.
//  Copyright © 2018年 toerax. All rights reserved.
//

#import "CCTrendView.h"

@implementation CCTrendView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}


-(void)setUpUI{
  
    [self addSubview:self.segmentControl];
    [self layout];
}

- (void)layout{
    
    [_segmentControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(@40);
        make.top.mas_equalTo(0);
    }];
}


-(UISegmentedControl *)segmentControl{
    if (!_segmentControl) {
        
        NSArray *itemArr = @[@"潮流",@"潮牌",@"潮搭",@"潮服",@"潮人"];
        _segmentControl = [[UISegmentedControl alloc]initWithItems:itemArr];
        _segmentControl.backgroundColor = kWhiteColor;
        _segmentControl.tintColor = kWhiteColor;
        NSDictionary* selectedTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:17],
                                                 NSForegroundColorAttributeName: Color(227, 93, 57)};
        NSDictionary* unSelectedTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:17],
                                                   NSForegroundColorAttributeName: Color(142, 142, 142)};
        [_segmentControl setTitleTextAttributes:unSelectedTextAttributes forState:UIControlStateNormal];
        [_segmentControl setTitleTextAttributes:selectedTextAttributes forState:(UIControlStateSelected)];
        [_segmentControl addTarget:self action:@selector(actionValueChanged) forControlEvents:UIControlEventValueChanged];
        _segmentControl.apportionsSegmentWidthsByContent = NO;
        _segmentControl.selectedSegmentIndex = 0;
        
    }
    return _segmentControl;
}


-(void)actionValueChanged{
    if (_segmentChangeBlock) {
        _segmentChangeBlock(_segmentControl.selectedSegmentIndex);
    }
}

@end
