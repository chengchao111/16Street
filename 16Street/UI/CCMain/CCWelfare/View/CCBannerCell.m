//
//  CCBannerCell.m
//  16Street
//
//  Created by apple on 2018/11/21.
//  Copyright © 2018年 toerax. All rights reserved.
//

#import "CCBannerCell.h"
#import "CCHomePageBannerModel.h"
@implementation CCBannerCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kGrayColor;
        self.layer.cornerRadius = 10;
        [self setUpUI];
        [self layout];
    }
    return self;
}

- (void)setUpUI{
    [self addSubview:self.imageView];
}

-(void)layout{
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
        
    }];
}
-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
        _imageView.backgroundColor = kRedColor;
        _imageView.layer.cornerRadius = 10.0f;
        _imageView.layer.masksToBounds = YES;
//        [_imageView setContentMode:(UIViewContentModeScaleAspectFill)];
    }
    return _imageView;
}

-(void)setModel:(CCHomePageBannerModel *)model{
    _model = model;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:Image_Url_Path(model.img)] placeholderImage:IMAGE(@"listDefaultImage")];
}
@end
