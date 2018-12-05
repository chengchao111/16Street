//
//  CCLounchViewController.m
//  16Street
//
//  Created by apple on 2018/10/16.
//  Copyright © 2018年 toerax. All rights reserved.
//

#import "CCLounchViewController.h"
#import "LyScrollBanner.h"
#import "BasicTabBarController.h"
@interface CCLounchViewController ()<LyScrollBannerDelegate>
@property(nonatomic,strong)NSArray *imageArray;
@property(nonatomic,strong)LyScrollBanner *banner;
@property(strong,nonatomic)UIButton *button;
@end

@implementation CCLounchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:kWhiteColor];
    [self initImageArray];
    [self setUpUI];
    [self layout];
}

- (void)initImageArray{
    if (Is_iPhoneX) {
        _imageArray = @[@"iPhoneX－1.jpg",@"iPhoneX－2.jpg",@"iPhoneX－3.jpg",@"iPhoneX－4.jpg"];
    }else{
        _imageArray = @[@"750－1.jpg",@"750－2.jpg",@"750－3.jpg",@"750－4.jpg"];
    }
}

- (void)setUpUI{
    _banner = [[LyScrollBanner alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT) ImageNameArray:_imageArray];
    [self.view addSubview:_banner];
    [self.view addSubview:self.button];
}

- (void)buttonClick{
    WeakSelf(self);
    [UIView animateWithDuration:2 animations:^{
        weakself.view.alpha = 0.1;

    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        BasicTabBarController *vc = [[BasicTabBarController alloc]init];
        weakself.view.window.rootViewController = vc;
    });
    
}

-(UIButton *)button{
    if (!_button) {
        _button = [CCUtil createBtnTitle:@"跳过" titleColor:kWhiteColor backgroundColor:kClearColor bgImageName:@"" target:self action:@selector(buttonClick)];
        _button.layer.cornerRadius= 15;
        _button.layer.borderColor = kWhiteColor.CGColor;
        _button.layer.borderWidth = 1;
    }
    return _button;
}


-(void)layout{
    [_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(30);
        make.right.mas_equalTo(-30);
        make.top.mas_equalTo(StatusBarHeight + 10);
    }];
}
@end
