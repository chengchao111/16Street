//
//  CCSixteenVC.m
//  16Street
//
//  Created by apple on 2018/10/24.
//  Copyright © 2018年 toerax. All rights reserved.
//

#import "CCSixteenVC.h"
#import "CCMineCell.h"
#import "CCSixStreenTableHeaderView.h"

@interface CCSixteenVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, assign) NSInteger pageTag;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSArray *datasource;
@property (nonatomic,strong)CCSixStreenTableHeaderView *headerView;

@end

static NSString *const identifier = @"CCMineCell";
@implementation CCSixteenVC
- (instancetype)initWithTag:(NSInteger)tag {
    self = [super init];
    if (self) {
        _pageTag = tag;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _datasource = @[@"购物车",@"我的订单",@"我的积分",@"分销员中心",@"领取优惠券",@"推荐有礼",@"关于"];
     [self.view addSubview:self.tableView];
    
    [self managerBlock];
}


- (void)managerBlock{
    WeakSelf(self);
    [self.headerView setHeaderBlock:^(NSInteger tag) {
        switch (tag) {
            case 0://会员卡
                {
                    
                }
                break;
            case 1://足迹
            {
                
            }
                break;
            case 2://收藏
            {
                
            }
                break;
            case 3://评论
            {
                
            }
                break;
                
            default:
                break;
        }
    }];
}


-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = BasicViewColor;
        [_tableView setSeparatorStyle:(UITableViewCellSeparatorStyleNone)];
        _tableView.rowHeight = 44;
        [_tableView registerNib:[UINib nibWithNibName:@"CCMineCell" bundle:nil] forCellReuseIdentifier:identifier];
        _headerView = [[CCSixStreenTableHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
        
        _tableView.tableHeaderView = _headerView;
    }
    return _tableView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _datasource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CCMineCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[CCMineCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    }
    cell.title.text = _datasource[indexPath.row];
    return cell;
}


@end
