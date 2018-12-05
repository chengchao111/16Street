//
//  CCHomePageViewModel.m
//  16Street
//
//  Created by apple on 2018/11/21.
//  Copyright © 2018年 toerax. All rights reserved.
//

#import "CCHomePageViewModel.h"
#import "CCHomePageListModel.h"
#import "CCHomePageBannerModel.h"
@interface CCHomePageViewModel ()
@property (strong,nonatomic)NSMutableArray *banners;
@property (strong,nonatomic)NSMutableArray *goodLists;
@end

@implementation CCHomePageViewModel

-(NSMutableArray *)banners{
    if (!_banners) {
        _banners = [NSMutableArray array];
    }
    return _banners;
}

-(NSMutableArray *)goodLists{
    if (!_goodLists) {
        _goodLists = [NSMutableArray array];
    }
    return _goodLists;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self banners];
        [self goodLists];
    }
    return self;
}

-(void)requestWithPrams:(NSDictionary *)prams success:(SuccessBlock)success failure:(nonnull FailureBlock)failure{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",BaseURL,HomePageUrl];
    [CCNetWorking postRequestWithURL:urlStr parameters:prams success:^(id response) {
        WeakSelf(self);
        [self.goodLists removeAllObjects];
        [self.banners removeAllObjects];
        if ([response[@"isOk"] integerValue] == 1) {
            for (int i = 0; i < [response[@"data"][@"Headers"] count]; i ++) {
                CCHomePageBannerModel *model = [CCHomePageBannerModel mj_objectWithKeyValues:response[@"data"][@"Headers"][i]];
                [weakself.banners addObject:model];
            }
            
            for (int k = 0; k<[response[@"data"][@"GoodPrice"][@"list"] count]; k ++) {
                CCHomePageListModel *model = [CCHomePageListModel mj_objectWithKeyValues:response[@"data"][@"GoodPrice"][@"list"][k]];
                [weakself.goodLists addObject:model];
            }
            success(weakself.banners,weakself.goodLists);
        }else{
            success(weakself.banners,weakself.goodLists);
            [MBManager showTips:response[@"msg"]];
        }
    
    } failure:^(NSError *error) {
        SLog(@"error = %@",error.localizedDescription);
    }];
}

-(void)requestGoodListWithParams:(NSDictionary *)params isRefresh:(BOOL)isRefresh success:(GoodsListBlock)success failure:(FailureBlock)failure{
    WeakSelf(self);
    [self.goodLists removeAllObjects];
    //判断参数重有没有type这个健，如果没有，说明时请求店铺列表，如果有就是商品列表
    NSString *urlString;
    if ([[params allKeys] containsObject:@"type"]) {
        urlString = [NSString stringWithFormat:@"%@%@",BaseURL,GoodsList];
    }else{
        urlString = [NSString stringWithFormat:@"%@%@",BaseURL,ShopList];
    }
    
    [CCNetWorking postRequestWithURL:urlString parameters:params success:^(id response) {

        SLog(@"response = %@",response);
        if ([response[@"isOk"] integerValue] == 1) {
            
            for (int i = 0; i <[response[@"data"][@"Page"][@"list"]count] ; i ++) {
                CCHomePageListModel *model = [CCHomePageListModel mj_objectWithKeyValues:response[@"data"][@"Page"][@"list"][i]];
                [weakself.goodLists addObject:model];
            }
            success(weakself.goodLists);
        }else{
            success(weakself.goodLists);
            [MBManager showTips:response[@"msg"]];
        }
     
    } failure:^(NSError *error) {
        failure(error);
        SLog(@"error = %@",error.localizedDescription);
    }];
}

@end
