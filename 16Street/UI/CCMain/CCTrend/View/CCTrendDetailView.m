//
//  CCTrendDetailView.m
//  16Street
//
//  Created by apple on 2018/11/23.
//  Copyright © 2018年 toerax. All rights reserved.
//

#import "CCTrendDetailView.h"

@implementation CCTrendDetailView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
        [self layout];
    }
    return self;
}


- (void)setUpUI{
    [self addSubview:self.tableView];
}

- (void)layout{
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:(UITableViewStyleGrouped)];
        [_tableView setSeparatorStyle:(UITableViewCellSeparatorStyleNone)];
        _tableView.backgroundColor = Color(246, 246, 246);
    }
    return _tableView;
}
@end
