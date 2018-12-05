//
//  CCTrendDetailVC.h
//  16Street
//
//  Created by apple on 2018/11/23.
//  Copyright © 2018年 toerax. All rights reserved.
//

#import "CCBasicViewController.h"
#import "SMTrendListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CCTrendDetailVC : CCBasicViewController

@property (strong,nonatomic)SMTrendListModel *model;

@property (strong,nonatomic)NSString         *type;
@end

NS_ASSUME_NONNULL_END
