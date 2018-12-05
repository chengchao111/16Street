//
//  CCGoodGoodsCell.m
//  16Street
//
//  Created by apple on 2018/11/22.
//  Copyright © 2018年 toerax. All rights reserved.
//

#import "CCGoodGoodsCell.h"

@interface CCGoodGoodsCell ()
@property (weak, nonatomic) IBOutlet UIImageView *goodImage;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *title;

@end

@implementation CCGoodGoodsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(void)setModel:(CCHomePageListModel *)model{
    
    _model = model;
     [self.goodImage sd_setImageWithURL:[NSURL URLWithString:Image_Url_Path(model.imgIn)]];
    self.name.text = model.name;
    self.title.text = model.info;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
