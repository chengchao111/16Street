//
//  CCLoginViewModel.h
//  16Street
//
//  Created by apple on 2018/10/11.
//  Copyright © 2018年 toerax. All rights reserved.
//

#import "CCBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

////成功的Block
//typedef void (^SuccessBlock)(NSDictionary *dic);
//
////失败的Block
//typedef void(^FailureBlock)(NSError *error);

@interface CCLoginViewModel : CCBaseViewModel

-(void)requestWithRequstParams:(NSDictionary *)param handleDataWithSuccess:(SuccessBlock)success failure:(FailureBlock)failure;

@end

NS_ASSUME_NONNULL_END
