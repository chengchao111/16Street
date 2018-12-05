//
//  CCWaterFullVC.h
//  16Street
//
//  Created by apple on 2018/10/24.
//  Copyright © 2018年 toerax. All rights reserved.
//

#import "CCBasicViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCWaterFullVC : CCBasicViewController
//自定义init,用于传参
- (instancetype)initWithTag:(NSInteger)tag frame:(CGRect)frame;
@property (nonatomic,assign)NSInteger index;

@end

NS_ASSUME_NONNULL_END
