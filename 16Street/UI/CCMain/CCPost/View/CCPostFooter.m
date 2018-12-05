//
//  CCPostFooter.m
//  16Street
//
//  Created by apple on 2018/11/13.
//  Copyright © 2018年 toerax. All rights reserved.
//

#import "CCPostFooter.h"

@interface CCPostFooter ()

@end

@implementation CCPostFooter

- (void)awakeFromNib {
    [super awakeFromNib];
    self.textField.delegate = self;
    self.textView.delegate = self;
    
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    if (textField == self.textField) {
        //这里的if时候为了获取删除操作,如果没有次if会造成当达到字数限制后删除键也不能使用的后果.
        if (range.length == 1 && string.length == 0) {
            return YES;
        }
        else if (self.textField.text.length >= 30) {
            [MBManager showTips:@"标题长度不能超过30"];
            self.textField.text = [textField.text substringToIndex:30];
            return NO;
        }
    }
    
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    self.textFiledBlock(textField.text);
}

-(void)textViewDidChange:(UITextView *)textView{
    self.textViewBlock(textView.text);
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    if ([textView.text isEqualToString:@"写下你的潮言"]) {
        textView.text = @"";
    }
    return YES;
}

-(BOOL)textViewShouldEndEditing:(UITextView *)textView{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"写下你的潮言";
    }
    return YES;
}




@end
