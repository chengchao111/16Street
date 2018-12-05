//
//  CCGoodShopCell.m
//  16Street
//
//  Created by apple on 2018/11/21.
//  Copyright © 2018年 toerax. All rights reserved.
//

#import "CCGoodShopCell.h"
#import "CCHomePageBannerModel.h"
@interface CCGoodShopCell ()
@property (weak, nonatomic) IBOutlet UIImageView *goodImage;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *subTitle;
@property (weak, nonatomic) IBOutlet UIButton *weixinBtn;
@property (weak, nonatomic) IBOutlet UIButton *zhiFuBaoBtn;
@property (weak, nonatomic) IBOutlet UIView *viewHeight;

@end

@implementation CCGoodShopCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(void)setModel:(CCHomePageListModel *)model{
    _model = model;
    
    [self.goodImage sd_setImageWithURL:[NSURL URLWithString:Image_Url_Path(model.imgIn)]];
    self.name.text = model.name;
    self.title.text = model.circle;
    self.subTitle.text = model.info;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
