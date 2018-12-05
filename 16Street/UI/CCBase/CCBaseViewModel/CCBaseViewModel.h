//
//  CCBaseViewModel.h
//  16Street
//
//  Created by apple on 2018/10/11.
//  Copyright © 2018年 toerax. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//成功的Block
typedef void (^SuccessBlock)(NSDictionary *dic);

//失败的Block
typedef void(^FailureBlock)(NSError *error);

@interface CCBaseViewModel : NSObject



@end

NS_ASSUME_NONNULL_END
