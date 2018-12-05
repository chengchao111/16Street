//
//  CCWriterCenterViewModel.m
//  16Street
//
//  Created by apple on 2018/10/25.
//  Copyright © 2018年 toerax. All rights reserved.
//

#import "CCWriterCenterViewModel.h"
static NSString * nomalIdentifer = @"SMDampNomalCell";
static NSString * otherIdentifer = @"SMDampOtherCell";
@implementation CCWriterCenterViewModel

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self dataArray];
    }
    return self;
}

//-(void)requestWithRequstPrams:(NSDictionary *)parasm isRefresh:(BOOL)refresh handleDataWithSuccess:(FinishBlock)success failure:(FailureBlock)failure{
//    //网络请求
//    WeakSelf(self);
//    NSString *urlStr = [NSString stringWithFormat:@"%@%@",BaseURL,GetPhotographerInfoUrl];
//    [CCNetWorking postRequestWithURL:urlStr parameters:parasm success:^(id response) {
//
//        SMTideModel *model = [SMTideModel mj_objectWithKeyValues:response[@"data"][@"Page"]];
//        //刷新
//        if (refresh) {
//
//            [weakself.dataArray removeAllObjects];
//            [weakself.dataArray addObjectsFromArray:model.list];
//
//        }else{//加载
//            [weakself.dataArray addObjectsFromArray:model.list];
//
//        }
//
//        success(weakself.dataArray);
//
//
//    } failure:^(NSError *error) {
//        failure(error);
//
//    }];
//}
//
//
//- (NSInteger)waterflowLayout:(LMJVerticalFlowLayout *)waterflowLayout columnsInCollectionView:(UICollectionView *)collectionView
//{
//    return 2;
//}
//
//-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    return _dataArray.count;
//}
//
//
//
//-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//    SMTrendListModel *model = self.dataArray[indexPath.row];
//    WeakSelf(self);
//
//    if ([model.type integerValue] == 1) {
//        SMDampNomalCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:nomalIdentifer forIndexPath:indexPath];
//        [cell setButtonClickBlock:^(SMDampNomalCell *cell, NSInteger tag) {
//
//            [weakself buttonClickWithCell:cell tag:tag];
//
//        }];
//        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:Image_Url_Path(model.img)] placeholderImage:IMAGE(@"defaultHead") completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//            if (image) {
//                if (!CGSizeEqualToSize(model.imageSize, image.size)) {
//                    model.imageSize = image.size;
//
//                    [collectionView reloadItemsAtIndexPaths:@[indexPath]];
//                }
//            }
//        }];
//
//        cell.model = model;
//        return cell;
//    }else{
//        SMDampOtherCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:otherIdentifer forIndexPath:indexPath];
//        [cell setGotoLookBlock:^(SMDampOtherCell *cell) {
//
//        }];
//        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:Image_Url_Path(model.img)] placeholderImage:IMAGE(@"defaultHead") completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//            if (image) {
//                if (!CGSizeEqualToSize(model.imageSize, image.size)) {
//                    model.imageSize = image.size;
//
//                    [collectionView reloadItemsAtIndexPaths:@[indexPath]];
//                }
//            }
//        }];
//        cell.model = model;
//        return cell;
//    }
//
//}
//
//
//- (CGFloat)waterflowLayout:(LMJVerticalFlowLayout *)waterflowLayout collectionView:(UICollectionView *)collectionView heightForItemAtIndexPath:(NSIndexPath *)indexPath itemWidth:(CGFloat)itemWidth{
//    SMTrendListModel *model = self.dataArray[indexPath.row];
//    CGFloat height = model.imageSize.height/model.imageSize.width * (SCREEN_WIDTH - 30)/2;
//    if (!isnan(height)) {
//        if ([model.type integerValue] == 1) {
//            return 84 + height;
//        }else{
//            return 124 + height;
//        }
//    }else{
//
//        if ([model.type integerValue] == 1) {
//            return 0;
//        }else{
//            return 0;
//        }
//    }
//
//}
//
//-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    if (self.callBlock) {
//        SMTrendListModel *model = self.dataArray[indexPath.row];
//        self.callBlock(model);
//    }
//}
//
//
//- (void)buttonClickWithCell:(SMDampNomalCell *)cell tag:(NSInteger)tag{
//
//    if (_cellBtnBlock) {
//        _cellBtnBlock(cell,tag);
//    }
//}
@end
