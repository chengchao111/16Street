//
//  SMTrendListModel.h
//  SixTeenHourShoppingMall
//
//  Created by apple on 2018/9/11.
//  Copyright © 2018年 TuoYuanCulture. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SMTrendListModel : NSObject

/**
 图片
 */
@property (strong,nonatomic)NSString *img;

/**
 头像
 */
@property (strong,nonatomic)NSString *headImg;


/**
 摄影师名字
 */
@property (strong,nonatomic)NSString *nickname;


/**
 id
 */
@property (strong,nonatomic)NSString *Id;


/**
 标签
 */
@property (strong,nonatomic)NSString *label;

/**
 1:用户，2:编辑推荐
 */
@property (strong,nonatomic)NSString *type;


/**
 标题
 */
@property (strong,nonatomic)NSString *title;


/**
 点赞数量
 */
@property (strong,nonatomic)NSString *likenum;


/**
  用户资质状态：用户资质 0普通 1摄影师 2形象大使
 */
@property (strong,nonatomic)NSString *qualifications;

/**
 摄影师用户Id
 */
@property (strong,nonatomic)NSString *fkId;

/**
 左上角标题
 */
@property (strong,nonatomic)NSString *news;


/**
 * 图片size
 */
@property (nonatomic,assign)CGSize imageSize;

@end
