//
//  CCUserCell.m
//  16Street
//
//  Created by apple on 2018/11/12.
//  Copyright © 2018年 toerax. All rights reserved.
//

#import "CCUserCell.h"

@implementation CCUserCell

- (void)awakeFromNib {
    [super awakeFromNib];
     [self.textField addTarget:self action:@selector(textFieldTextDidChange:) forControlEvents:UIControlEventEditingChanged];
    // Initialization code
}

-(void)textFieldTextDidChange:(UITextField *)textField{
    
    if (_textFieldBlock) {
        self.textFieldBlock(self.textField.text);
    }
}

-(void)setPlaceHolder:(NSString *)placeHolder{
   
    self.textField.placeholder = placeHolder;
}

-(void)setImage:(NSArray *)image{
    self.textField.leftViewMode = UITextFieldViewModeAlways;
    UIImageView *leftImage = [[UIImageView alloc]initWithImage:IMAGE(image)];
    UIView *phoneView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 20)];
    leftImage.center = phoneView.center;
    [phoneView addSubview:leftImage];
    self.textField.leftView = phoneView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
