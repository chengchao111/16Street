//
//  SMTideModel.m
//  SixTeenHourShoppingMall
//
//  Created by apple on 2018/9/11.
//  Copyright © 2018年 TuoYuanCulture. All rights reserved.
//

#import "SMTideModel.h"

@implementation SMTideModel

+(instancetype)mj_objectWithKeyValues:(id)keyValues{
    
    SMTideModel *model = [super mj_objectWithKeyValues:keyValues];
    [model.list enumerateObjectsUsingBlock:^(SMTrendListModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        SMTrendListModel *list = [SMTrendListModel mj_objectWithKeyValues:obj];
        [model.list replaceObjectAtIndex:idx withObject:list];
    }];
    return model;
}

@end
