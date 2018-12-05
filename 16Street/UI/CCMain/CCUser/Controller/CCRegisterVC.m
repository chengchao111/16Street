//
//  CCRegisterVC.m
//  16Street
//
//  Created by apple on 2018/11/12.
//  Copyright © 2018年 toerax. All rights reserved.
//

#import "CCRegisterVC.h"
#import "CCResgisterHeaderView.h"
#import "CCUserCell.h"
#import "CCUserWithBtnCell.h"
#import "CCRegisterFooterView.h"
@interface CCRegisterVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;
@property (strong,nonatomic)NSArray *images;
@property (strong,nonatomic)NSArray *placeHolders;
@property (strong,nonatomic)NSMutableArray *contentsText;

@property (strong,nonatomic)CCRegisterFooterView *footer;
@property (strong,nonatomic)CCResgisterHeaderView *header;
@property (assign,nonatomic)BOOL isSelect;

@end

static NSString *const btnCellIden = @"CCUserWithBtnCell";
static NSString *const cellIden = @"CCUserCell";
@implementation CCRegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showBackBtnWithTitle:@""];
    self.view.backgroundColor = kWhiteColor;
    [self.view addSubview:self.tableView];
    self.isSelect = NO;
    [self images];
    [self placeHolders];
    [self block];
}

#pragma mark ************* Block* ***********
- (void)block{
    WeakSelf(self);
    self.header.buttonBlock = ^(NSInteger tag) {
        if (tag == 0) {
            [weakself.navigationController popViewControllerAnimated:YES];
        }
    };
    
    self.footer.buttonBlock = ^(NSInteger tag) {
        switch (tag) {
            case 0://是否同意用户协议
                {
                
                    weakself.isSelect =! weakself.isSelect;
                }
                break;
            case 1://跳转用户协议
                {
                  
                }
                break;
            case 2://注册
                {
                
                    [weakself  userRegister];
                
                }
                break;
                
            default:
                
                break;
        }
    };
}

#pragma mark ************* 获取验证码************
- (void)getCodeWithCell:(CCUserWithBtnCell *)cell{
    if (![Util isPhoneNum:self.contentsText[1]]) {
        [MBManager showTips:@"电话号码格式不正确"];
        return;
    }
}

#pragma mark --注册
- (void)userRegister{
    if ([Util isEmptyString:self.contentsText[0]]) {
        [MBManager showTips:@"请输入昵称"];
        return;
    }
    
    if (![Util isPhoneNum:self.contentsText[1]]) {
        [MBManager showTips:@"电话号码格式不正确"];
        return;
    }
    
    if ([self.contentsText[2] length] != 6) {
        [MBManager showTips:@" 验证码不正确"];
        return;
    }
    
    if (![self.contentsText[3] isPassword]) {
        [MBManager showTips:@"密码为6-18位字母和数字组合"];
        return;
    }
    
    if (!self.isSelect) {
        [MBManager showTips:@"请同意用户协议"];
        return;
    }
}

#pragma mark --跳转用户协议
- (void)goToUserDelegate{
    
}





#pragma mark ************* UITableViewDatasource && UITableViewdelegate************

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _placeHolders.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WeakSelf(self);
    if (indexPath.row == 2) {
        CCUserWithBtnCell *cell = [tableView dequeueReusableCellWithIdentifier:btnCellIden];
        cell.placeHolder = self.placeHolders[indexPath.row];
        cell.image = self.images[indexPath.row];
        [cell setTextFieldBlock:^(NSString * _Nonnull text) {
            [weakself.contentsText replaceObjectAtIndex:indexPath.row withObject:text];
        }];
        
        [cell setButtonBlock:^(CCUserWithBtnCell * _Nonnull cell) {
            [weakself getCodeWithCell:cell];
        }];
        return cell;
    }else{
        CCUserCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIden];
        cell.placeHolder = self.placeHolders[indexPath.row];
        cell.image = self.images[indexPath.row];
        if (indexPath.row == 1) {
            [cell.textField setKeyboardType:(UIKeyboardTypeNumberPad)];
        }else{
            [cell.textField setKeyboardType:(UIKeyboardTypeNamePhonePad)];
        }
        [cell setTextFieldBlock:^(NSString * _Nonnull text) {
            [weakself.contentsText replaceObjectAtIndex:indexPath.row withObject:text];
        }];
        return cell;
    }
}


#pragma mark ************* 懒加载************
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NavHeight, SCREEN_WIDTH, SCREENH_HEIGHT - NavHeight) style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = self.header;
        _tableView.tableFooterView = self.footer;
        _tableView.rowHeight = 58;
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CCUserCell class]) bundle:nil] forCellReuseIdentifier:cellIden];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CCUserWithBtnCell class]) bundle:nil] forCellReuseIdentifier:btnCellIden];
        [_tableView setSeparatorStyle:(UITableViewCellSeparatorStyleNone)];
    }
    return _tableView;
}

-(CCResgisterHeaderView *)header{
    if (!_header) {
        _header = [[CCResgisterHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 172)];
    }
    return _header;
}

-(CCRegisterFooterView *)footer{
    if (!_footer) {
        _footer = [[CCRegisterFooterView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 164)];
    }
    return _footer;
}

-(NSArray *)images{
    if (!_images) {
        _images = @[@"注册-用户名",@"注册-电话号码",@"注册验证码",@"注册密码"];
    }
    return _images;
}

-(NSArray *)placeHolders{
    if (!_placeHolders) {
        _placeHolders = @[@"请输入您的昵称",@"请输入您的手机号",@"请输入验证码",@"请输入您的密码"];
    }
    return _placeHolders;
}

-(NSMutableArray *)contentsText{
    if (!_contentsText) {
        WeakSelf(self);
        _contentsText = [NSMutableArray arrayWithCapacity:_placeHolders.count];
        [_placeHolders enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [weakself.contentsText addObject:@""];
        }];
    }
    return _contentsText;
}


#pragma mark ************* 计时器************

@end
