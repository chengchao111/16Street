//
//  SMTideModel.h
//  SixTeenHourShoppingMall
//
//  Created by apple on 2018/9/11.
//  Copyright © 2018年 TuoYuanCulture. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMTrendListModel.h"
@interface SMTideModel : NSObject

@property (strong,nonatomic)NSString *totalRow;

@property (strong,nonatomic)NSString *pageNumber;

@property (strong,nonatomic)NSString *firstPage;

@property (strong,nonatomic)NSString *lastPage;

@property (strong,nonatomic)NSString *totalPage;

@property (strong,nonatomic)NSString *pageSize;

@property (strong,nonatomic)NSMutableArray <SMTrendListModel *>*list;

@end
