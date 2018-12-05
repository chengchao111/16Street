//
//  CCTrendDetailViewModel.m
//  16Street
//
//  Created by apple on 2018/11/23.
//  Copyright © 2018年 toerax. All rights reserved.
//

#import "CCTrendDetailViewModel.h"
#import "CCCommendListModel.h"

@interface CCTrendDetailViewModel ()
@end



@implementation CCTrendDetailViewModel


-(void)requestCommentListWith:(NSDictionary *)params success:(SuccessBlock)success failure:(FailureBlock)failure{
    __block NSMutableArray *commentArray = [NSMutableArray array];
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseURL,GetCommentListUrl];
    [CCNetWorking postRequestWithURL:url parameters:params success:^(id response) {
        NSLog(@"response = %@",response);
        if ([response[@"isOk"] integerValue] == 1) {
            for (int i = 0; i < [response[@"data"][@"Page"][@"list"]count]; i ++) {
                CCCommendListModel *model = [CCCommendListModel mj_objectWithKeyValues:response[@"data"][@"Page"][@"list"][i]];
                NSLog(@"==%@",model.TelePhone);
                [commentArray addObject:model];
            }
            success(commentArray);
        }
    } failure:^(NSError *error) {
        
    }];
}
-(void)addCommentWithParams:(NSDictionary *)params success:(void (^)(void))success failure:(FailureBlock)failure{
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseURL,AddCommentUrl];
    [CCNetWorking postRequestWithURL:url parameters:params success:^(id response) {
        NSLog(@"response = %@",response);
        if ([response[@"isOk"] integerValue] == 1) {
           
            [MBManager showTips:@"评论成功"];
            success();
        }
    } failure:^(NSError *error) {
        
    }];
}


-(void)deleteCommentWithParams:(NSDictionary *)params success:(void (^)(void))success failure:(FailureBlock)failure{
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseURL,DeleteCommentUrl];
    [CCNetWorking postRequestWithURL:url parameters:params success:^(id response) {
        NSLog(@"response = %@",response);
        if ([response[@"isOk"] integerValue] == 1) {
            
            [MBManager showTips:@"评论删除成功"];
            success();
        }
    } failure:^(NSError *error) {
        
    }];
}

@end
