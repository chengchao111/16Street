//
//  Api.h
//  项目框架
//
//  Created by apple on 2018/7/24.
//  Copyright © 2018年 ChengChao. All rights reserved.
//

#ifndef Api_h
#define Api_h

//#define BaseURL                 @"https://mall.api.16hour.com:4431/"
#define BaseURL                 @"https://mall.api.16hour.com/"

#define Image_Url_Path(a) [NSString stringWithFormat:@"%@%@",@"http://static.16hour.com/",a]

/*
 用户登录
 params : {phone : Long;timestamp : Long;password : String}
 */
#define loginUrl @"api/sign/in"

#pragma mark --潮show列表接口
/*
 location : Integer //推送位置： 1.潮流 2.潮牌 3.潮搭 4.潮服 5.潮人 必填
 page : Integer //页码 默认为1 选填
 rows : Integer //每页数据条数 默认 10 选填
 timestamp : Long //时间戳 选填
 */
#define TrendListUrl @"api/trend/list"


#pragma mark --获取摄影师信息
/*
 fkId : Long //用户id 必填
 timestamp : Long //时间戳 选填
 */
#define GetPhotographerInfoUrl @"api/trend/memberInfo"


#pragma mark --获取单个用户潮show列表
/*
 page : Integer //页码 默认为1 选填
 rows : Integer //每页数据条数 默认 10 选填
 fkId : Long //用户id 必填
 timestamp : Long //时间戳 选填
 */
#define GetPhotographerListUrl @"api/trend/memberList"


#pragma mark --发布潮show接口
/*
 File[] //摄影图片 多个图片文件
 intro : String //内容 必填
 title : String //潮show标题 必填
 fkId : String //用户id 必填
 timestamp : Long //时间戳 选填
 
 */
#define AddTrendUrl @"api/trend/addTrend"

/*
 加载首页信息
 params id : Long //用户ID 必填
 timestamp : Long //时间戳 选填
 
 */
#define HomePageUrl @"api/home/index"

/*
 获取商品列表
 mchId : Integer //店铺ID 选填 选填
 id : Long //用户ID 必填
 page : Integer //页码 默认为1 选填
 rows : Integer //每页数据条数 默认 10 选填
 type : Integer //获取的类型： 1:好价 、 2:好物 、 3:上新 必填
 timestamp : Long //时间戳 选填
 */
#define GoodsList @"api/goods/list"

/*
 获取店铺列表
 params id : Long //用户ID 必填
 page : Integer //页码 默认为1 选填
 rows : Integer //每页数据条数 默认 10 选填
 timestamp : Long //时间戳 选填
 
 */
#define ShopList @"api/merchant/list"

#pragma mark ************* 评论************
#pragma mark --  添加评论
/*
 
 params -- 添加评论
 pId : long //评论的父ID 默认0 选填
 id : Long //用户ID 必填
 content : String //评论内容 必填
 type : Integer //评价类型： 1:商户详情 、 2:商品详情 、 3:活动详情  ，4推荐详情 必填
 fkId : Long //评论对应实体的ID 必填
 timestamp : Long //时间戳 选填
 */
#define AddCommentUrl @"api/comment/add"

#pragma mark --  获取评论列表
/*
 params --获取评论列表
 id : Long //用户ID 必填
 page : Integer //页码 默认为1 选填
 type : Integer //评价类型：1、商户详情2、商品详情 3、活动详情 4、推荐详情 必填
 rows : Integer //每页数据条数 默认 10 选填
 fkId : Long //评论对应实体的ID 必填
 timestamp : Long //时间戳 选填
 */
#define GetCommentListUrl @"api/comment/list"

#pragma mark --  获取指定用户的评论信息
/*
 params -- 获取指定用户的评论信息
 id : Long //用户ID 必填
 page : Integer //页码 默认为1 选填
 rows : Integer //每页数据条数 默认 10 选填
 timestamp : Long //时间戳 选填
 */


#define GetUserCommentUrl @"api/comment/member"
#pragma mark --  删除评论
/*
 params --删除评论
 id : Long //用户ID 必填
 cId : Long //被删除的评论ID 必填
 timestamp : Long //时间戳 选填
 */
#define DeleteCommentUrl @"api/comment/del"

#endif /* Api_h */
