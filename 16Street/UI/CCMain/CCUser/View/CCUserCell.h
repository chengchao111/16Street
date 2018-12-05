//
//  CCUserCell.h
//  16Street
//
//  Created by apple on 2018/11/12.
//  Copyright © 2018年 toerax. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CCUserCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (strong,nonatomic)NSString *image;
@property (strong,nonatomic)NSString *placeHolder;

@property(copy,nonatomic)void(^textFieldBlock)(NSString *text);
@end

NS_ASSUME_NONNULL_END
