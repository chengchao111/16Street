//
//  UserInfoViewModel.h
//  16Street
//
//  Created by apple on 2018/10/25.
//  Copyright © 2018年 toerax. All rights reserved.
//

#import "CCBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

//成功的Block
typedef void (^callBlock)(CCLoginModel *model);

@interface UserInfoViewModel : CCBaseViewModel

-(void)getUserInfoWithBlock:(callBlock)block;

@end

NS_ASSUME_NONNULL_END
