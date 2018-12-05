//
//  CCHomePageListModel.h
//  16Street
//
//  Created by apple on 2018/11/21.
//  Copyright © 2018年 toerax. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CCHomePageListModel : NSObject
/**
 微信链接
 */
@property (strong,nonatomic)NSString *wxLink;

/**
 *店铺所在商圈 店铺专有字段
 */
@property (strong,nonatomic)NSString *circle;
/**
 *活动时间
 */
@property (strong,nonatomic)NSString *time;
/**
 链接
 */
@property (strong,nonatomic)NSString *link;
/**
 图片
 */
@property (strong,nonatomic)NSString *imgIn;
/**
 *支付宝优惠信息 店铺专有字段
 */
@property (strong,nonatomic)NSString *zfbInfo;

/**
 *商品品牌
 */
@property (strong,nonatomic)NSString *brand;

/**
 *区分商品还是店铺  true商品 false 店铺
 */
@property(strong,nonatomic)NSString *isGoods;

/**
 经度
 */
@property (strong,nonatomic)NSString *lat;
/**
 * 纬度
 */
@property (strong,nonatomic)NSString *lng;
/**
 *商品折扣价格
 */
@property (strong,nonatomic)NSString *discount;
/**
 支付宝链接
 */
@property (strong,nonatomic)NSString *zfbLink;
/**
 *商品tags，或门店区）比如锦江区
 */
@property (strong,nonatomic)NSString *regionName;
/**
 *商品tags
 */
@property (strong,nonatomic)NSString *tag;
/**
 *商品（店铺）名称
 */
@property (strong,nonatomic)NSString *name;
/**
 *商品的所属类型： 1:好价 、 2:好物 、 3:上新
 */
@property (strong,nonatomic)NSString *type;
/**
 *商品（门店）说明
 */
@property (strong,nonatomic)NSString *info;
/**
 *商品(门店)ID
 */
@property (strong,nonatomic)NSString *Id;

/**
 *微信优惠信息 店铺专有字段
 */
@property (strong,nonatomic)NSString *wxInfo;
/**
 *商品标签，多个标签用逗号隔开的
 */
@property (strong,nonatomic)NSString *label;
/**
 店铺名称
 */
@property (strong,nonatomic)NSString *merchantsName;
/**
 *价格
 */
@property (strong,nonatomic)NSString *price;
/**
 *门店Id
 */
@property (strong,nonatomic)NSString *merchantsId;

@end

NS_ASSUME_NONNULL_END
