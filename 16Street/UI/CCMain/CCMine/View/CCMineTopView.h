//
//  CCMineTopView.h
//  16Street
//
//  Created by apple on 2018/10/11.
//  Copyright © 2018年 toerax. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CCMineTopView : UIView

/**
 背景
 */
@property (nonatomic,strong)UIImageView *imageView;

/**
 返回按钮
 */
@property (nonatomic,strong)UIButton *backBtn;

/**
 设置
 */
@property (nonatomic,strong)UIButton *settingBtn;

/**
 y头像
 */
@property (nonatomic,strong)UIButton *headerBtn;

/**
 摄影师或形象大使log
 */
@property (nonatomic,strong)UIImageView *levelLog;

/**
 昵称
 */
@property (nonatomic,strong)UILabel *nikeName;

/**
 点赞和关注
 */
@property (nonatomic,strong)UILabel *likeAndFollow;

/**
 认证标示
 */
@property (nonatomic,strong)UILabel *level;




/**
 按钮回调
 */
@property(nonatomic,copy)void(^buttonBlock)(NSInteger tag);



@end

NS_ASSUME_NONNULL_END
