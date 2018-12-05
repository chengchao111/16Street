//
//  CCWelfareHeaderView.m
//  16Street
//
//  Created by apple on 2018/11/20.
//  Copyright © 2018年 toerax. All rights reserved.
//

#import "CCWelfareHeaderView.h"
#import "CCBannerCell.h"
static NSString *bannerIdentifier = @"CCBannerCell";

@implementation CCWelfareHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
        [self layout];
    }
    return self;
}

#pragma mark ************* Action************
- (void)buttonClick:(UIButton *)sender{
    if (self.buttonBlock) {
        self.buttonBlock(sender.tag - 100);
    }
}

-(void)segmentCotrolChange:(UISegmentedControl *)sender{
    NSInteger index = sender.selectedSegmentIndex;
    if (self.segBlock) {
        self.segBlock(index);
    }
}

#pragma mark ************* UI************
- (void)setUpUI{
    
     [self addSubview:self.bannerView];
    NSArray *imageArr = @[@"折上折",@"超市",@"百货",@"家居",@"美食"];
    CGFloat with = (SCREEN_WIDTH - 32)/5;
    for (int i = 0; i < imageArr.count; i ++) {
        _classBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _classBtn.frame = CGRectMake(16 + with*i,self.bannerView.bottom+10, with, 82);
        [_classBtn setTitle:imageArr[i] forState:(UIControlStateNormal)];
        [_classBtn setImage:IMAGE(imageArr[i]) forState:(UIControlStateNormal)];
        _classBtn.titleLabel.font = SYSTEMFONT(12);
        [_classBtn setContentMode:(UIViewContentModeScaleToFill)];
        _classBtn.tag = 100 + i;
        [_classBtn setTitleColor:Color(155, 155, 155) forState:(UIControlStateNormal)];
        [self initButton:self.classBtn];
        [_classBtn addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:self.classBtn];
        
        [_classBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(with);
            make.height.mas_equalTo(82);
            make.top.mas_equalTo(self.bannerView.mas_bottom).offset(10);
            make.left.mas_equalTo(self.mas_left).offset(16 + i * with);
        }];
    }
    [self addSubview:self.segmentCotrol];
    [self addSubview:self.moreBtn];
    [self addSubview:self.title];
   
}
#pragma mark ************* 约束************
- (void)layout{
    [_bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.height.mas_equalTo(214);
    }];
   
    
    [_segmentCotrol mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bannerView.mas_bottom).offset(self.classBtn.height+20);
        make.left.mas_equalTo(10);
        make.width.mas_equalTo(SCREEN_WIDTH -20);
        make.height.mas_equalTo(30);
    }];
    
    [_moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.mas_equalTo(self.segmentCotrol.mas_bottom).offset(10);
        make.right.mas_equalTo(-22);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(25);
    }];
    
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(22);
        make.top.mas_equalTo(self.segmentCotrol.mas_bottom).offset(10);
        make.height.mas_equalTo(25);
        make.right.mas_equalTo(self.moreBtn.mas_left).offset(20);
    
    }];
    
   
}

#pragma mark ************* 懒加载************
-(UISegmentedControl *)segmentCotrol{
    if (!_segmentCotrol) {
        NSArray *titleArray = @[@"好价",@"福利",@"好店",@"上新",@"好物"];
        NSDictionary *selectTitle = [NSDictionary dictionaryWithObjectsAndKeys:SelectTextColor,NSForegroundColorAttributeName,BOLDSYSTEMFONT(22),NSFontAttributeName,nil];
        NSDictionary *normalTitle = [NSDictionary dictionaryWithObjectsAndKeys:NormalColor,NSForegroundColorAttributeName,BOLDSYSTEMFONT(22),NSFontAttributeName,nil];
        _segmentCotrol = [[UISegmentedControl alloc]initWithItems:titleArray];
        _segmentCotrol.tintColor = kClearColor;
        [_segmentCotrol setTitleTextAttributes:selectTitle forState:(UIControlStateSelected)];
        [_segmentCotrol setTitleTextAttributes:normalTitle forState:(UIControlStateNormal)];
        _segmentCotrol.selectedSegmentIndex = 0;
        [_segmentCotrol addTarget:self action:@selector(segmentCotrolChange:) forControlEvents:(UIControlEventValueChanged)];
    }
    return _segmentCotrol;
}

-(CWCarousel *)bannerView{
    if (!_bannerView) {
        CWFlowLayout *layout = [[CWFlowLayout alloc]initWithStyle:CWCarouselStyle_H_3];
        _bannerView = [[CWCarousel alloc] initWithFrame:CGRectZero
                                           delegate:nil
                                         datasource:nil
                                         flowLayout:layout];
        _bannerView.translatesAutoresizingMaskIntoConstraints = NO;
        _bannerView.isAuto = YES;
        _bannerView.autoTimInterval = 2;
        _bannerView.endless = YES;
        _bannerView.backgroundColor = kWhiteColor;
        [_bannerView registerViewClass:[CCBannerCell class] identifier:bannerIdentifier];
        
    }
    return _bannerView;
}


-(UILabel *)title{
    if (!_title) {
        _title = [CCUtil createLabelWithText:@"今日入住" color:DeSelectTextColor font:SYSTEMFONT(14)];
        _title.textAlignment = NSTextAlignmentLeft;
        _title.font = SYSTEMFONT(14);
    }
    return _title;
}

-(UIButton *)moreBtn{
    if (!_moreBtn) {
        _moreBtn = [CCUtil createBtnTitle:@"更多" titleColor:DeSelectTextColor backgroundColor:kClearColor bgImageName:@"进入更多" target:self action:@selector(buttonClick:)];
        [_moreBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 50, 0, 0)];
        [_moreBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 0)];
        _moreBtn.tag = 105;
        _moreBtn.titleLabel.font = SYSTEMFONT(14);
    }
    return _moreBtn;
}


-(void)initButton:(UIButton*)btn{
    //使图片和文字水平居中显示
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    
    //文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(btn.imageView.frame.size.height ,-btn.imageView.frame.size.width, 0.0,0.0)];
    
    //图片距离右边框距离减少图片的宽度，其它不边
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0.0, 0.0,10, -btn.titleLabel.bounds.size.width)];
}
@end
