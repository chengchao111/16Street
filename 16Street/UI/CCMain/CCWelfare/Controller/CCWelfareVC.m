//
//  CCWelfareVC.m
//  SixTeenHourShoppingMall
//
//  Created by apple on 2018/10/10.
//  Copyright © 2018年 toerax. All rights reserved.
//

#import "CCWelfareVC.h"
#import "CCWelfareHeaderView.h"
#import "CCHomePageViewModel.h"
#import "CCHomePageBannerModel.h"
#import "CCBannerCell.h"
#import "CWCarousel.h"

#import "CCGoodPriceCell.h"
#import "CCGoodShopCell.h"
#import "CCGoodGoodsCell.h"
typedef NS_ENUM(NSInteger,DisplayCellType)
{
    DisplayCellTypeWithGoodPrice,
    DisplayCellTypeWithWelfare,
    DisplayCellTypeWithGoodShop,
    DisplayCellTypeWithGoodsNew,
    DisplayCellTypeWithGoodGoods,
    
};

@interface CCWelfareVC ()<CWCarouselDelegate,CWCarouselDatasource,UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic)UIButton             *searchBtn;
@property (strong,nonatomic)CCWelfareHeaderView  *header;
@property (strong,nonatomic)UITableView          *tableView;
@property (strong,nonatomic)CCLoginModel         *model;
@property (strong,nonatomic)CCHomePageViewModel  *homePageViewModel;
@property (assign,nonatomic)DisplayCellType         cellType;
@property (strong,nonatomic)NSMutableDictionary  *params;

@property (strong,nonatomic)NSMutableArray       *goodListArray;
@property (strong,nonatomic)NSMutableArray       *bannerArray;

//请求时传的参数，好价：1  福利：101 好店：无 上新：2 好物：3；
@property (strong,nonatomic)NSString             *type;
//请求时用到的页数
@property (assign,nonatomic)NSInteger            page;
@property (assign,nonatomic)BOOL                 isRefresh;
@end

static NSString *bannerIdentifier = @"CCBannerCell";
static NSString *goodPriceIdentifier = @"CCGoodPriceCell";
static NSString *goodShopIdentifier = @"CCGoodShopCell";
static NSString *goodGoodsIdentifier = @"CCGoodGoodsCell";

@implementation CCWelfareVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kWhiteColor;
    [self initlizeDatasource];
    [self setUpUI];
    [self layout];
    [self block];
    [self reFresh];
   
}

#pragma mark ************* 初始数据源设置************
- (void)initlizeDatasource{
    self.page = 1;
    self.isRefresh = YES;
    self.type = @"1";
    
    self.goodListArray = [NSMutableArray array];
    self.bannerArray = [NSMutableArray array];
    self.model = [CCArchiveManager unarchiveObjectWithfilePath:UserInfoPath];
    
    NSDictionary *dic= @{@"id":CHECK_STRING(_model.Id)};
    [self requestDataWithPrams:dic];
    
}

#pragma mark ************* UI************
-(void)setUpUI{
    self.navigationItem.titleView =self.searchBtn;
    [self.view addSubview:self.tableView];
}

#pragma mark ************* Action************
///MARK:--刷新和加载
-(void)reFresh{
    WeakSelf(self);
    //刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself.tableView.mj_footer endRefreshing];
        NSDictionary *dic= @{@"id":CHECK_STRING(weakself.model.Id)};
        weakself.isRefresh = YES;
        weakself.page     = 1;
        [weakself requestWitCellType:weakself.cellType];
        [weakself refreshAllTableViewWithBannerParams:dic listParams:weakself.params];
    }];
    
    //加载
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self.tableView.mj_header endRefreshing];
        weakself.isRefresh = NO;
        weakself.page     ++;
        [weakself requestWitCellType:weakself.cellType];
        [weakself requestGoodListWithParams:weakself.params];
    }];
}

///MARK:--配置请求参数Type
- (void)requestWitCellType:(DisplayCellType)cellType{
    
    switch (cellType) {
        case DisplayCellTypeWithGoodPrice:
            self.type = @"1";
            break;
        
        case DisplayCellTypeWithWelfare:
            self.type = @"101";
            break;
            
        case DisplayCellTypeWithGoodShop:
            self.type = @"";
            break;
            
        case DisplayCellTypeWithGoodsNew:
            self.type = @"2";
            break;
            
        case DisplayCellTypeWithGoodGoods:
            self.type = @"3";
            break;
            
        default:
            break;
    }
    
    if ([Util isEmptyString:self.type]) {
        [self.params removeObjectForKey:@"type"];
    }else{
        [self.params setValue:self.type forKey:@"type"];
    }
    
    [self.params setValue:[NSNumber numberWithInteger:self.page] forKey:@"page"];
   
}

#pragma mark ************* block回调************
-(void)block{
    WeakSelf(self);
    ///MARK:--segmentControl点击事件
    [self.header setSegBlock:^(NSInteger index) {
        weakself.cellType = index;
        weakself.page = 1;
        weakself.isRefresh = YES;
        [weakself requestWitCellType:weakself.cellType];
        [weakself requestGoodListWithParams:weakself.params];
    }];
    ///MARK:--分类按钮点击事件
    [self.header setButtonBlock:^(NSInteger index) {
        
    }];
}

///MARK:--搜索
- (void)searchBtnClick{
    
}


#pragma mark ************* 懒加载************
///MARK:-- 搜索按钮
-(UIButton *)searchBtn{

    if (!_searchBtn) {
        _searchBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _searchBtn.frame = CGRectMake(0, 0, SCREEN_WIDTH - 40, 40);
        [_searchBtn setTitleColor:Color(155, 155, 155) forState:(UIControlStateNormal)];
        _searchBtn.titleLabel.font = SYSTEMFONT(14);
        [_searchBtn setImage:IMAGE(@"顶部搜索") forState:(UIControlStateNormal)];
        _searchBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _searchBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 18, 0, 0);
        _searchBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [_searchBtn setTitle:@"搜索你想要的商品名称" forState:(UIControlStateNormal)];
        _searchBtn.backgroundColor = Color(246, 246, 246);
        _searchBtn.layer.cornerRadius = 20;
        [_searchBtn addTarget:self action:@selector(searchBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _searchBtn;
}

///MARK:-- tableView
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        [_tableView setSeparatorStyle:(UITableViewCellSeparatorStyleNone)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = self.header;
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CCGoodPriceCell class]) bundle:nil] forCellReuseIdentifier:goodPriceIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CCGoodShopCell class]) bundle:nil] forCellReuseIdentifier:goodShopIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CCGoodGoodsCell class]) bundle:nil] forCellReuseIdentifier:goodGoodsIdentifier];
    }
    return _tableView;
}

///MARK:-- 首页ViewModel
-(CCHomePageViewModel *)homePageViewModel{
    if (!_homePageViewModel) {
        _homePageViewModel = [[CCHomePageViewModel alloc]init];
    }
    return _homePageViewModel;
}

///MARK:-- header
-(CCWelfareHeaderView *)header{
    if (!_header) {
        _header = [[CCWelfareHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 400)];
        _header.bannerView.delegate = self;
        _header.bannerView.datasource = self;
    }
    return _header;
}

///MARK:--首页列表请求参数
-(NSMutableDictionary *)params{
    if (!_params) {
        _params = [NSMutableDictionary dictionary];
        [_params setValue:CHECK_STRING(self.model.Id) forKey:@"id"];
        [_params setValue:[NSNumber numberWithInteger:self.page] forKey:@"page"];
        [_params setValue:@"20" forKey:@"rows"];
        [_params setValue:self.type forKey:@"type"];

    }
    return _params;
}

#pragma mark ************* 控件约束************
- (void)layout{
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
        
    }];
    
}

#pragma mark ************* 轮播的Delegate && datasource************
///MARK:--banner个数
-(NSInteger)numbersForCarousel{
    return _bannerArray.count;
}

///MARK:--banner数据源
-(UICollectionViewCell *)viewForCarousel:(CWCarousel *)carousel indexPath:(NSIndexPath *)indexPath index:(NSInteger)index{
    CCBannerCell *cell = [carousel.carouselView dequeueReusableCellWithReuseIdentifier:bannerIdentifier forIndexPath:indexPath];
    
    CCHomePageBannerModel *model = self.bannerArray[index];
    cell.model = model;
    return cell;
}

///MARK:--banner点击事件
- (void)CWCarousel:(CWCarousel *)carousel didSelectedAtIndex:(NSInteger)index {
    NSLog(@"...%ld...", (long)index);
}

#pragma mark ************* UITableViewDelegate && UITableViewDatasource************
///MARK:--cell个数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.goodListArray.count;
}

///MARK:--tableView数据源
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (self.cellType) {
        case DisplayCellTypeWithGoodPrice://好价
            {
               CCGoodPriceCell *cell = [tableView dequeueReusableCellWithIdentifier:goodPriceIdentifier];
               if (!cell) {
                   cell = [[CCGoodPriceCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:goodPriceIdentifier];
               }
                cell.model = self.goodListArray[indexPath.row];
                return cell;
            }
          
            break;
        case DisplayCellTypeWithGoodShop://好店
        {
            CCGoodShopCell *cell = [tableView dequeueReusableCellWithIdentifier:goodShopIdentifier];
            if (!cell) {
                cell = [[CCGoodShopCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:goodShopIdentifier];
            }
            cell.model = self.goodListArray[indexPath.row];
            return cell;
        }
            break;
        case DisplayCellTypeWithWelfare://福利
        {
            CCGoodGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:goodGoodsIdentifier];
            if (!cell) {
                cell = [[CCGoodGoodsCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:goodGoodsIdentifier];
            }
            cell.model = self.goodListArray[indexPath.row];
            return cell;
        }
            break;
        case DisplayCellTypeWithGoodsNew://上新
        {
            CCGoodPriceCell *cell = [tableView dequeueReusableCellWithIdentifier:goodPriceIdentifier];
            if (!cell) {
                cell = [[CCGoodPriceCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:goodPriceIdentifier];
            }
            cell.model = self.goodListArray[indexPath.row];
            return cell;
        }
            break;
        case DisplayCellTypeWithGoodGoods://好物
        {
            CCGoodGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:goodGoodsIdentifier];
            if (!cell) {
                cell = [[CCGoodGoodsCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:goodGoodsIdentifier];
            }
            cell.model = self.goodListArray[indexPath.row];
            return cell;
        }
            break;
            
        default:
            break;
    }
    
    return nil;
}

///MARK:--tableViewCell高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (self.cellType) {
        case DisplayCellTypeWithGoodPrice://好价
            return 102;
            break;
        case DisplayCellTypeWithGoodShop://好店
            return 156;
            break;
        case DisplayCellTypeWithWelfare://福利
            return 102;
            break;
        case DisplayCellTypeWithGoodsNew://上新
            return 102;
            break;
        case DisplayCellTypeWithGoodGoods://好物
            return 102;
            break;
            
        default:
            break;
    }
    return 0;
}

///MARK:--视图将要出现
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.header.bannerView controllerWillAppear];
}
///MARK:--试图简要消失
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [self.header.bannerView controllerWillDisAppear];
}


#pragma mark ************* 网络请求************
///MARK:--请求商品列表
- (void)requestGoodListWithParams:(NSDictionary *)params{
    SLog(@"==%@",params);
    WeakSelf(self);
    [self.homePageViewModel requestGoodListWithParams:params isRefresh:_isRefresh success:^(NSArray * _Nonnull goodArray) {
        NSLog(@"=== %lu",(unsigned long)goodArray.count);
        
        if (self.isRefresh) {//刷新
            [weakself.goodListArray removeAllObjects];
            [weakself.goodListArray addObjectsFromArray:goodArray];
            [weakself.tableView.mj_header endRefreshing];
            
        }else{//加载
            if (goodArray.count > 0) {
                [weakself.goodListArray addObjectsFromArray:goodArray];
                [weakself.tableView.mj_footer endRefreshing];
            }else{
                [weakself.tableView.mj_footer endRefreshingWithNoMoreData];
            }
        }
        [weakself.tableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        [weakself.tableView.mj_header endRefreshing];
        [weakself.tableView.mj_footer endRefreshing];
        [weakself.tableView reloadData];
    }];
    
}

///MARK:--请求首页所有数据
- (void)requestDataWithPrams:(NSDictionary *)parmas{
    WeakSelf(self);
    [self.homePageViewModel requestWithPrams:parmas success:^(NSArray * _Nonnull banners, NSArray * _Nonnull goodArray) {
        [weakself.bannerArray addObjectsFromArray:banners];
        [weakself.goodListArray addObjectsFromArray:goodArray];
        [weakself.header.bannerView freshCarousel];
        [weakself.tableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

///MARK:--刷新操作（需要请求轮播和列表）
- (void)refreshAllTableViewWithBannerParams:(NSDictionary *)bannerPrams listParams:(NSDictionary *)listParams{
    SLog(@"listParams + %@",listParams);
    WeakSelf(self)
    __block NSMutableDictionary *data = [NSMutableDictionary dictionary];
    dispatch_group_t group = dispatch_group_create();
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (int i = 0; i < 2; i ++) {
            dispatch_group_enter(group);
            switch (i) {
                case 0:
                    {
                        //首页数据（banner请求）
                        [weakself.homePageViewModel requestWithPrams:bannerPrams success:^(NSArray * _Nonnull banners, NSArray * _Nonnull goodArray) {
                            [data setValue:banners forKey:@"banners"];
                            dispatch_group_leave(group);
                        } failure:^(NSError * _Nonnull error) {
                            dispatch_group_leave(group);
                        }];
                        
                    }
                    break;
                case 1:
                    {
                        [weakself.homePageViewModel requestGoodListWithParams:listParams isRefresh:weakself.isRefresh success:^(NSArray * _Nonnull goodArray) {
                            [data setValue:goodArray forKey:@"goodArray"];
                            dispatch_group_leave(group);
                        } failure:^(NSError * _Nonnull error) {
                             dispatch_group_leave(group);
                        }];
                    }
                     break;
                default:
                    break;
            }
        }
        //线程等待
        dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakself.tableView.mj_header endRefreshing];
            //请求完毕，处理业务逻辑
            SLog(@"data = %@",data);
            [weakself.tableView reloadData];
            [weakself.header.bannerView freshCarousel];
            
        });
    });
}
@end
