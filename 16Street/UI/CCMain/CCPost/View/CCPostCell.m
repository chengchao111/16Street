//
//  CCPostCell.m
//  16Street
//
//  Created by apple on 2018/11/13.
//  Copyright © 2018年 toerax. All rights reserved.
//

#import "CCPostCell.h"

@implementation CCPostCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)deleteBtnClick:(id)sender {
    if (self.deleteBtnBlock) {
        self.deleteBtnBlock(self);
    }
}

-(void)setPhoto:(UIImage *)photo{
    self.image.image = photo;
    UIImage *image = IMAGE(@"选图");
    NSData *data = UIImagePNGRepresentation(image);
    NSData *data1 = UIImagePNGRepresentation(photo);
    if ([data1 isEqual:data]) {
        self.deletBtn.hidden = YES;
    }else{
        self.deletBtn.hidden = NO;
    }
}

@end
