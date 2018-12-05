//
//  CCWaterFullVC.m
//  16Street
//
//  Created by apple on 2018/10/24.
//  Copyright © 2018年 toerax. All rights reserved.
//

#import "CCWaterFullVC.h"
#import "CCWaterView.h"
#import "CCWriterCenterVC.h"
#import "CCTrendViewModel.h"
#import "CCTrendDetailVC.h"

#import "SMDampNomalCell.h"
#import "SMDampOtherCell.h"
#import <PPNetworkHelper.h>
@interface CCWaterFullVC ()<LMJVerticalFlowLayoutDelegate>
@property (nonatomic,strong)UICollectionView *collectionView;

@property (nonatomic,strong)CCTrendViewModel *viewModel;

@property (strong,nonatomic)NSMutableDictionary *params;

@property (assign ,nonatomic)NSInteger page;

@property (assign,nonatomic)NSInteger location;

@property (assign,nonatomic)BOOL isRefresh;

@property (nonatomic,strong)NSArray *data;

@property (nonatomic,strong)NSString *noNetwork;

@property (assign,nonatomic)CGRect frame;
@end

@implementation CCWaterFullVC

- (instancetype)initWithTag:(NSInteger)tag frame:(CGRect)frame{
    self = [super init];
    if (self) {
        self.frame = frame;
        _location = tag + 1;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self viewModel];
    [self.view addSubview:self.collectionView];
    [self refresh];
    [self.collectionView.mj_header beginRefreshing];
    [self managerBlock];
   
}

//-(void)viewWillAppear:(BOOL)animated{
//    if (!PPNetworkHelper.isNetwork) {
//        self.collectionView.mj_footer.hidden = YES;
//    }
//}


- (void)managerBlock{
    WeakSelf(self);
    //cell点击block
    [_viewModel setCallBlock:^(SMTrendListModel * _Nonnull model) {

        ///MARK:--跳转详情页
        CCTrendDetailVC *vc=  [[CCTrendDetailVC alloc]init];
        vc.model = model;
        vc.type = @"5";//潮show的type为5；
        [weakself.navigationController pushViewController:vc animated:YES];
    }];
    
    //cell上的按钮点击处理
    [_viewModel setCellBtnBlock:^(SMDampNomalCell * _Nonnull cell, NSInteger tag) {
        NSIndexPath *indexPath = [weakself.collectionView indexPathForCell:cell];
        SMTrendListModel *model = weakself.data[indexPath.row];
        if (tag == 0) {
            CCWriterCenterVC *vc = [[CCWriterCenterVC alloc]init];
            vc.model = model;
            [weakself.navigationController pushViewController:vc animated:YES];
        }else{
            NSLog(@"点赞了");
        }
        
       
        
    }];
}


-(NSMutableDictionary *)params{
    if (!_params) {
        _params = [NSMutableDictionary dictionary];
        [_params setObject:@20 forKey:@"rows"];
        [_params setObject:[NSNumber numberWithInteger:_page] forKey:@"page"];
        [_params setObject:@(self.location) forKey:@"location"];
    }
    return _params;
}

-(void)initData{
    
    _page = 1;
    _isRefresh = YES;
    [self params];
}

- (void)refresh{
    WeakSelf(self);
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakself.isRefresh = YES;
        weakself.page = 1;
        weakself.params[@"page"] = [NSNumber numberWithInteger:weakself.page];
        weakself.params[@"location"] = @(weakself.location);
       
        [weakself requestData];
    }];
    
    self.collectionView.mj_footer= [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakself.isRefresh = NO;
        weakself.page ++;
        weakself.params[@"page"] = [NSNumber numberWithInteger:weakself.page];
        weakself.params[@"location"] = @(weakself.location);
        [weakself requestData];
    }];
}

#pragma mark ---数据处理
- (void)requestData{
    WeakSelf(self);
    NSLog(@"dic = %@",self.params);
    [_viewModel requestWithRequstPrams:_params isRefresh:self.isRefresh handleDataWithSuccess:^(NSArray *array) {
        
        [weakself.collectionView.mj_footer endRefreshing];
        [weakself.collectionView.mj_header endRefreshing];
        weakself.data = array;
        if (array.count == 0) {
            weakself.collectionView.mj_footer.hidden = YES;
        }else{
            weakself.collectionView.mj_footer.hidden = NO;
        }
        [weakself.collectionView reloadData];
    } failure:^(NSError *error) {
        weakself.collectionView.mj_footer.hidden = YES;
        [weakself.collectionView.mj_footer endRefreshing];
        [weakself.collectionView.mj_header endRefreshing];
        [MBManager showTips:error.localizedDescription];
    }];
    
    
}

-(CCTrendViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[CCTrendViewModel alloc]init];
        
    }
    return _viewModel;
}

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        LMJVerticalFlowLayout *layout = [[LMJVerticalFlowLayout alloc] initWithDelegate:self];
        _collectionView = [[UICollectionView alloc]initWithFrame:_frame collectionViewLayout:layout];
        _collectionView.backgroundColor = BasicViewColor;
        _collectionView.delegate = self.viewModel;
        _collectionView.dataSource = self.viewModel;

        [_collectionView registerNib:[UINib nibWithNibName:@"SMDampNomalCell" bundle:nil] forCellWithReuseIdentifier:@"SMDampNomalCell"];
        [_collectionView registerNib:[UINib nibWithNibName:@"SMDampOtherCell" bundle:nil] forCellWithReuseIdentifier:@"SMDampOtherCell"];
        //隐藏滑动条
        //        _collectionView.showsVerticalScrollIndicator = NO;
    }
    return _collectionView;
}


@end
