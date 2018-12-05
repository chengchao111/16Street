//
//  CCPostViewModel.h
//  16Street
//
//  Created by apple on 2018/11/15.
//  Copyright © 2018年 toerax. All rights reserved.
//

#import "CCBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCPostViewModel : CCBaseViewModel

-(void)requestWithRequstParams:(NSDictionary *)param handleDataWithSuccess:(SuccessBlock)success;

@end

NS_ASSUME_NONNULL_END
