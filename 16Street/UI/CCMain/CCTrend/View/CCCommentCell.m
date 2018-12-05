//
//  CCCommentCell.m
//  16Street
//
//  Created by apple on 2018/11/23.
//  Copyright © 2018年 toerax. All rights reserved.
//

#import "CCCommentCell.h"
@interface CCCommentCell ()

@property (weak, nonatomic) IBOutlet UILabel *commend;

@end
@implementation CCCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(CCCommendListModel *)model{
    _model = model;
    NSString *str = [NSString stringWithFormat:@"%@回复%@：%@",model.RealName,model.ParentName,model.Content];
    //富文本设置
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:str];
    [attrStr addAttribute:NSForegroundColorAttributeName value:SelectTextColor range:NSMakeRange(0,model.RealName.length)];
    [attrStr addAttribute:NSForegroundColorAttributeName value:SelectTextColor range:NSMakeRange(model.RealName.length + 2,model.ParentName.length)];
    self.commend.attributedText = attrStr;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
