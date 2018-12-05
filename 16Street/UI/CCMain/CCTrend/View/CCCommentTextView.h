//
//  CCCommentTextView.h
//  16Street
//
//  Created by apple on 2018/11/28.
//  Copyright © 2018年 toerax. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CCCommentTextView : UIView
@property (strong,nonatomic)UITextView *textView;
@property (strong,nonatomic)UIButton   *cancelBtn;
@property (strong,nonatomic)UIButton   *sureBtn;
@property (strong,nonatomic)UILabel    *textCount;
@property (copy,nonatomic)void(^buttonBlock)(NSInteger tag);
@end

NS_ASSUME_NONNULL_END
