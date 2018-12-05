//
//  SMTrendListModel.m
//  SixTeenHourShoppingMall
//
//  Created by apple on 2018/9/11.
//  Copyright © 2018年 TuoYuanCulture. All rights reserved.
//

#import "SMTrendListModel.h"

@implementation SMTrendListModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"Id":@"id",@"news":@"mark"};
}
@end
