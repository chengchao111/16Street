//
//  CCUserWithBtnCell.h
//  16Street
//
//  Created by apple on 2018/11/12.
//  Copyright © 2018年 toerax. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CCUserWithBtnCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *button;

@property (strong,nonatomic)NSString *image;

@property (strong,nonatomic)NSString *placeHolder;

@property(copy,nonatomic)void(^textFieldBlock)(NSString *text);

@property (strong,nonatomic)void(^buttonBlock)(CCUserWithBtnCell *cell);
@end

NS_ASSUME_NONNULL_END
