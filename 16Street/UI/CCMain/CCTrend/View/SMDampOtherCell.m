//
//  SMDampOtherCell.m
//  collectionView瀑布流
//
//  Created by apple on 2018/9/4.
//  Copyright © 2018年 ChengChao. All rights reserved.
//

#import "SMDampOtherCell.h"

@interface SMDampOtherCell ()

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UILabel *invitationStatus;
@end

@implementation SMDampOtherCell

/**
 model set方法
 
 @param model 返回model数据，处理数据
 */
-(void)setModel:(SMTrendListModel *)model{
    //图片
//    [self.imageView sd_setImageWithURL:[NSURL URLWithString:Image_Url_Path(model.img)] placeholderImage:IMAGE(@"defaultHead")];
    //标题
    self.title.text = model.title;
    
    //帖子状态，
    if (model.news.length > 0) {
        self.invitationStatus.hidden = NO;
    }else{
        self.invitationStatus.hidden = YES;
    }
    self.invitationStatus.text = model.news;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.layer.cornerRadius = 10;
    _button.layer.cornerRadius = 5;
    _button.layer.borderWidth = 1;
     _invitationStatus.layer.cornerRadius = 3;
    _button.layer.borderColor = [UIColor redColor].CGColor;
}

- (IBAction)buttonClick:(id)sender {
    if (_gotoLookBlock) {
        _gotoLookBlock(self);
    }
}
@end
