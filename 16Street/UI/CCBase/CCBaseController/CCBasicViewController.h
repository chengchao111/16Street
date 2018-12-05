//
//  CCBasicViewController.h
//  SixTeenHourShoppingMall
//
//  Created by apple on 2018/10/10.
//  Copyright © 2018年 toerax. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CCBasicViewController : UIViewController

- (void)showBackBtnWithTitle:(NSString *)title;
- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message type:(UIAlertControllerStyle)type  buttonArr:(NSArray *)buttonArr alerAction:(void (^)(NSInteger index))alerAction;

//alert提时间按钮点击事件
- (void)AlertActionWithTag:(NSInteger)tag;
@end

NS_ASSUME_NONNULL_END
