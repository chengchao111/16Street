//
//  CCMineSettingVC.m
//  16Street
//
//  Created by apple on 2018/10/29.
//  Copyright © 2018年 toerax. All rights reserved.
//

#import "CCMineSettingVC.h"
#import "CCMineSettingView.h"
@interface CCMineSettingVC ()
@property (nonatomic,strong)CCMineSettingView *mainView;
@end

@implementation CCMineSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showBackBtnWithTitle:@"设置"];
    [self.view addSubview:self.mainView];
    [self layout];
    [self managerBlock];


}

#pragma mark ************* Block************
- (void)managerBlock{
    WeakSelf(self);
    [_mainView setButtonBlock:^(NSInteger tag) {
        [weakself buttonClickWith:tag];
    }];
}


#pragma mark ************* Action************
-(void)buttonClickWith:(NSInteger)tag{
    NSLog(@"tag = %ld",tag);
    if (tag == 0) {//修改密码

    }else if (tag == 1){//退出登录
        [CCArchiveManager removeObjectWithFilePath:UserInfoPath];
        self.tabBarController.selectedIndex = 0;
        [UserManager cheakNeedLogin];
    }
}
#pragma mark ************* 懒加载************
-(CCMineSettingView *)mainView{
    if (!_mainView) {
        _mainView = [[CCMineSettingView alloc]init];
    }
    return _mainView;
}

#pragma mark ************* 约束************
-(void)layout{
    [_mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.width.mas_equalTo(self.view);
        make.height.mas_equalTo(58 * 2);
        make.top.mas_equalTo(50 + NavHeight);
    }];
}

@end
