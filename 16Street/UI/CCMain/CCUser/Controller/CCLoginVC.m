//
//  CCLoginVC.m
//  16Street
//
//  Created by apple on 2018/10/11.
//  Copyright © 2018年 toerax. All rights reserved.
//

#import "CCLoginVC.h"
#import "CCLoginView.h"
#import "CCLoginViewModel.h"
#import "CCRegisterVC.h"
@interface CCLoginVC ()
@property (strong,nonatomic)CCLoginView *loginView;
@property (strong,nonatomic)CCLoginViewModel *viewModel;
@end

@implementation CCLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.view = self.loginView;
    [self viewModel];
    [self manageBlock];
}



- (void)manageBlock{
    WeakSelf(self);
    [_loginView setButtonBlock:^(NSInteger tag) {
        [weakself buttonClickWithTag:tag];
    }];
}

#pragma mark ************* 懒加载************
-(CCLoginView *)loginView{
    if (!_loginView) {
        _loginView = [[CCLoginView alloc]init];
    }
    return _loginView;
}

-(CCLoginViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[CCLoginViewModel alloc]init];
    }
    return _viewModel;
}

#pragma mark ************* 按钮点击处理************
- (void)buttonClickWithTag:(NSInteger)tag{
    switch (tag - 100) {
        case 0://返回
            [self dismissViewControllerAnimated:YES completion:nil];
            break;
        case 1://到登陆
            
            break;
        case 2://跳转注册
        {
            CCRegisterVC *vc = [[CCRegisterVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            
        }
            
            break;
        case 3://手机动态码登录
            
            break;
        case 4://忘记密码
            
            break;
        case 5://登陆
            [self login];
            break;
        case 6://查看用户协议
            
            break;
            
        default:
            break;
    }
}


#pragma mark --登陆
- (void)login{
    if (![_loginView.phoneTextfield.text isPhoneNumber]) {
        [MBManager showTips:@"请输入正确的手机号码"];
        return;
    }
    
    if (_loginView.passwordTextfield.text.length < 6 ||_loginView.passwordTextfield.text.length > 16) {
        [MBManager showTips:@"密码为6-16位"];
        return;
    }
    WeakSelf(self);
    NSDictionary *dic = @{@"phone":_loginView.phoneTextfield.text,@"password":_loginView.passwordTextfield.text};
    //调用登陆
    [_viewModel requestWithRequstParams:dic handleDataWithSuccess:^(NSDictionary * _Nonnull dic) {

        [weakself dismissViewControllerAnimated:YES completion:nil];
        
    } failure:^(NSError * _Nonnull error) {

        [MBManager showTips:@"网络失败，请重新尝试"];
    }];
}
@end
