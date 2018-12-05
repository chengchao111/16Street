
//
//  CCPostViewModel.m
//  16Street
//
//  Created by apple on 2018/11/15.
//  Copyright © 2018年 toerax. All rights reserved.
//

#import "CCPostViewModel.h"

@implementation CCPostViewModel

-(void)requestWithRequstParams:(NSDictionary *)param handleDataWithSuccess:(SuccessBlock)success{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",BaseURL,AddTrendUrl];
    [CCNetWorking postRequestWithURL:urlStr parameters:param success:^(id response) {
        
        if (success) {
            success(response);
        }
        
    } failure:^(NSError *error) {
        [MBManager dismiss];
        [MBManager showTips:@"请求失败，请检查网络重试"];
        
    }];
}

@end
