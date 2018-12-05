//
//  CCTrendDetailViewModel.h
//  16Street
//
//  Created by apple on 2018/11/23.
//  Copyright © 2018年 toerax. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CCCommendListModel;
NS_ASSUME_NONNULL_BEGIN
//成功的Block
typedef void (^SuccessBlock)(NSArray *models);

//失败的Block
typedef void(^FailureBlock)(NSError *error);

@interface CCTrendDetailViewModel : NSObject


/**
 -- 请求评论列表

 @param params 请求参数
 @param success 成功回调
 @param failure 失败回调
 */
- (void)requestCommentListWith:(NSDictionary *)params success:(SuccessBlock)success failure:(FailureBlock)failure;

/**
 -- 添加评论
 
 @param params 请求参数
 @param success 成功回调
 @param failure 失败回调
 */
- (void)addCommentWithParams:(NSDictionary *)params success:(void(^)(void))success failure:(FailureBlock)failure;


/**
 -- 删除评论
 
 @param params 请求参数
 @param success 成功回调
 @param failure 失败回调
 */
- (void)deleteCommentWithParams:(NSDictionary *)params success:(void(^)(void))success failure:(FailureBlock)failure;

/**
 -- 举报评论
 
 @param params 请求参数
 @param success 成功回调
 @param failure 失败回调
 */
- (void)reportCommentWithParams:(NSDictionary *)params success:(void(^)(void))success failure:(FailureBlock)failure;
@end

NS_ASSUME_NONNULL_END
