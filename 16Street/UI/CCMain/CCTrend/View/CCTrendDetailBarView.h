//
//  CCTrendDetailBarView.h
//  16Street
//
//  Created by apple on 2018/11/23.
//  Copyright © 2018年 toerax. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CCTrendDetailBarView : UIView
@property (strong,nonatomic)UIButton *shareBtn;
@property (strong,nonatomic)UIButton *commentBtn;
@property (strong,nonatomic)UIButton *like;
@property (copy,nonatomic)void(^BarBtnBlock)(NSInteger index);

@end

NS_ASSUME_NONNULL_END
