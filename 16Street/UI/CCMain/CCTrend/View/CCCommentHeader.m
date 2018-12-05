//
//  CCCommentHeader.m
//  16Street
//
//  Created by apple on 2018/11/23.
//  Copyright © 2018年 toerax. All rights reserved.
//

#import "CCCommentHeader.h"
#import "CCCommendListModel.h"
@implementation CCCommentHeader

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
    [self.headerImage sd_setImageWithURL:[NSURL URLWithString:Image_Url_Path(model.HeadUrl)] placeholderImage:IMAGE(@"defaultHead")];
    self.name.text = model.RealName;
    self.Content.text = model.Content;
}


- (void)setUpUI{
    [self addSubview:self.headerImage];
    [self addSubview:self.name];
    [self addSubview:self.Content];
}

-(void)layout{
    [self.headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(12);
        make.left.mas_equalTo(22);
        make.width.height.mas_equalTo(36);
    }];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headerImage.mas_top);
        make.left.mas_equalTo(self.headerImage.mas_right).offset(18);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(16);
    }];
    
    [self.Content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.name.mas_bottom).offset(4);
        make.left.right.mas_equalTo(self.name);
        make.bottom.mas_equalTo(-10);
    }];
    
}

#pragma mark ************* 懒加载************
-(UIImageView *)headerImage{
    if (!_headerImage) {
        _headerImage = [[UIImageView alloc]init];
        _headerImage.layer.cornerRadius = 18;
        _headerImage.clipsToBounds = YES;
    }
    return _headerImage;
}

- (UILabel *)name{
    if (!_name) {
        _name = [CCUtil createLabelWithText:@"" color:SelectTextColor font:BOLDSYSTEMFONT(12)];
        _name.textAlignment = NSTextAlignmentLeft;
    }
    return _name;
}

-(UILabel *)Content{
    if (!_Content) {
        _Content = [CCUtil createLabelWithText:@"" color:Color(51, 51, 51) font:SYSTEMFONT(12)];
        _Content.textAlignment = NSTextAlignmentLeft;
        _Content.numberOfLines = 0;
    }
    return _Content;
}
@end
