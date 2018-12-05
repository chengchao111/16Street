//
//  SMDampNomalCell.m
//  collectionView瀑布流
//
//  Created by apple on 2018/9/4.
//  Copyright © 2018年 ChengChao. All rights reserved.
//

#import "SMDampNomalCell.h"
@interface SMDampNomalCell ()



/**
 标题
 */
@property (weak, nonatomic) IBOutlet UILabel *title;

/**
 摄影师头像点击
 */
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;

/**
 点赞
 */
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;

/**
 摄影师头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;

/**
 会员LOg
 */
@property (weak, nonatomic) IBOutlet UIImageView *memberImage;

/**
 摄影师名字
 */
@property (weak, nonatomic) IBOutlet UILabel *name;


/**
 帖子状态
 */
@property (weak, nonatomic) IBOutlet UILabel *invitationStatus;

@end


@implementation SMDampNomalCell


/**
 model set方法

 @param model 返回model数据，处理数据
 */
-(void)setModel:(SMTrendListModel *)model{
    //图片
//    [self.imageView sd_setImageWithURL:[NSURL URLWithString:Image_Url_Path(model.img)] placeholderImage:IMAGE(@"defaultHead")];
    //头像
    [self.headerImage sd_setImageWithURL:[NSURL URLWithString:Image_Url_Path(model.headImg)] placeholderImage:IMAGE(@"defaultHead")];
    //标题
    self.title.text = model.title;
    //发帖者名字
    self.name.text = model.nickname;
    //点赞数量
    [self.rightBtn setTitle:model.likenum forState:(UIControlStateNormal)];
    //帖子状态，
    if (model.news.length > 0) {
        self.invitationStatus.hidden = NO;
    }else{
        self.invitationStatus.hidden = YES;
    }
    self.invitationStatus.text = model.news;
    //用户资质状态
    switch ([model.qualifications integerValue]) {
        case 0://普通用户
        {
            self.memberImage.hidden = YES;
            
        }
            
            break;
        case 1://摄影师
        {
            self.memberImage.hidden = NO;
            [self.memberImage setImage:[UIImage imageNamed:@"首页用的vip"]];
        }
            break;
        case 2://形象大使
        {
            self.memberImage.hidden = NO;
            [self.memberImage setImage:[UIImage imageNamed:@"小形象大使"]];
        }
            break;
            
        default:
            break;
    }
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.cornerRadius = 10;
    _headerImage.layer.cornerRadius = 10;
    _headerImage.clipsToBounds = YES;
    _invitationStatus.layer.cornerRadius = 3;
    // Initialization code
}
- (IBAction)buttonClick:(UIButton *)sender {
    
    if (_buttonClickBlock) {
        _buttonClickBlock(self,sender.tag);
    }
}

@end
