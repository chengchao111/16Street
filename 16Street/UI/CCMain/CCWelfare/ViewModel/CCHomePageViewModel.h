//
//  CCHomePageViewModel.h
//  16Street
//
//  Created by apple on 2018/11/21.
//  Copyright © 2018年 toerax. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void (^FailureBlock)(NSError *error);
typedef void (^SuccessBlock)(NSArray *banners, NSArray *goodArray);

typedef void (^GoodsListBlock)(NSArray *goodArray);
@interface CCHomePageViewModel : NSObject

//首页
- (void)requestWithPrams:(NSDictionary *)prams success:(SuccessBlock)success failure:(FailureBlock)failure;

//商品列表
- (void)requestGoodListWithParams:(NSDictionary *)params isRefresh:(BOOL)isRefresh success:(GoodsListBlock)success failure:(FailureBlock)failure;

@end

NS_ASSUME_NONNULL_END
