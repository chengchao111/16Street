//
//  CCCommentFooter.h
//  16Street
//
//  Created by apple on 2018/11/26.
//  Copyright © 2018年 toerax. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCCommendListModel.h"
NS_ASSUME_NONNULL_BEGIN
@interface CCCommentFooter : UIView
@property (strong,nonatomic)UILabel *time;
@property (strong,nonatomic)UIButton *contentBtn;
@property (strong,nonatomic)CCCommendListModel *model;
@property(copy,nonatomic)void(^footerBlock)(void);
@end

NS_ASSUME_NONNULL_END
