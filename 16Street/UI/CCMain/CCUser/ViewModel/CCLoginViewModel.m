//
//  CCLoginViewModel.m
//  16Street
//
//  Created by apple on 2018/10/11.
//  Copyright © 2018年 toerax. All rights reserved.
//

#import "CCLoginViewModel.h"
#import "CCLoginModel.h"



@implementation CCLoginViewModel

-(void)requestWithRequstParams:(NSDictionary *)param handleDataWithSuccess:(SuccessBlock)success failure:(FailureBlock)failure{
   __block NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",BaseURL,loginUrl];
    [CCNetWorking postRequestWithURL:urlStr parameters:param success:^(id response) {
        if ([response[@"isOk"] integerValue] == 1) {
            [dic addEntriesFromDictionary:response[@"data"][@"Member"] ];
            [CCNetWorking postRequestWithURL:[NSString stringWithFormat:@"%@%@",BaseURL,GetPhotographerInfoUrl] parameters:@{@"fkId":response[@"data"][@"Member"][@"id"]} success:^(id response) {
                [dic addEntriesFromDictionary:response[@"data"][@"memberInfo"] ];
                NSLog(@"dic = %@",dic);
                CCLoginModel *model = [CCLoginModel mj_objectWithKeyValues:dic];
                //归档
                [CCArchiveManager archiveRootObject:model filePath:UserInfoPath];
                success(dic);
            } failure:^(NSError *error) {
                
                failure(error);
                
            }];
        }
      

    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end
