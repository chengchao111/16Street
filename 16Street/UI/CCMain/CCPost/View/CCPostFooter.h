//
//  CCPostFooter.h
//  16Street
//
//  Created by apple on 2018/11/13.
//  Copyright © 2018年 toerax. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CCPostFooter : UICollectionReusableView<UITextViewDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (weak, nonatomic) IBOutlet UILabel *textNumber;

@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (copy,nonatomic)void(^textFiledBlock)(NSString *text);
@property (copy,nonatomic)void(^textViewBlock)(NSString *text);
@end

NS_ASSUME_NONNULL_END
