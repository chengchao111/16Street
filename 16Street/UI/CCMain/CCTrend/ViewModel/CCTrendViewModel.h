//
//  CCTrendViewModel.h
//  16Street
//
//  Created by apple on 2018/10/11.
//  Copyright © 2018年 toerax. All rights reserved.
//

#import "CCBaseViewModel.h"
#import "LMJVerticalFlowLayout.h"
#import "SMTideModel.h"
#import "SMTrendListModel.h"
#import "SMDampNomalCell.h"
#import "SMDampOtherCell.h"
NS_ASSUME_NONNULL_BEGIN
typedef void (^FinishBlock)(NSArray *array);
@interface CCTrendViewModel : CCBaseViewModel<LMJVerticalFlowLayoutDelegate,UICollectionViewDataSource,UICollectionViewDelegate>


/**
 数据源
 */
@property (nonatomic,strong)NSMutableArray *dataArray;

/**
 cell点击回调
 */
@property (copy,nonatomic)void(^callBlock)(SMTrendListModel *model);

@property (nonatomic,copy)void(^cellBtnBlock)(SMDampNomalCell *cell,NSInteger tag);

/**
 数据回调
 @param success 成功返回请求model
 @param failure 失败返回 错误信息
 */
- (void)requestWithRequstPrams:(NSDictionary *)parasm isRefresh:(BOOL)refresh handleDataWithSuccess:(FinishBlock)success failure:(FailureBlock)failure;

@end

NS_ASSUME_NONNULL_END
