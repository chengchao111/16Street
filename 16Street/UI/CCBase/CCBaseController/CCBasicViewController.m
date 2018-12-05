//
//  CCBasicViewController.m
//  SixTeenHourShoppingMall
//
//  Created by apple on 2018/10/10.
//  Copyright © 2018年 toerax. All rights reserved.
//

#import "CCBasicViewController.h"
@interface CCBasicViewController ()
@property (strong,nonatomic)UIButton *backBtn;
@end

@implementation CCBasicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.view addSubview:self.backBtn];
    
    
    self.view.backgroundColor = BasicViewColor;
  
    if (@available(iOS 11.0, *)) {
        
        UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        
    } else {
        
        self.automaticallyAdjustsScrollViewInsets = NO;
        
    }
    
    // 判断是否有上级页面，有的话再调用
    if ([self.navigationController.viewControllers indexOfObject:self] > 0) {
        [self setBackBarButtonWithImage:@"黑色返回" title:@""];
    }
    [self preferredStatusBarStyle];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:[UIColor blackColor]}];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
  
}

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message type:(UIAlertControllerStyle)type  buttonArr:(NSArray *)buttonArr alerAction:(void (^)(NSInteger index))alerAction
{
    //解决在cell中点击时的延迟问题
    dispatch_async(dispatch_get_main_queue(), ^{
        
        UIAlertController *actionSheetController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:type];
        
        for (NSInteger i = 0; i < buttonArr.count; i++) {
            
            UIAlertActionStyle buttonStyle = UIAlertActionStyleDefault;
            if ([buttonArr[i] isEqualToString:@"取消"]) {
                buttonStyle = UIAlertActionStyleCancel;
            }
            
            if (type == UIAlertControllerStyleAlert && message.length > 0) {
                
                NSMutableAttributedString *hogan = [[NSMutableAttributedString alloc] initWithString:message];
                [hogan addAttribute:NSFontAttributeName value:SYSTEMFONT(16) range:NSMakeRange(0, [[hogan string] length])];
                [hogan addAttribute:NSForegroundColorAttributeName value:kDarkGrayColor range:NSMakeRange(0, [[hogan string] length])];
                [actionSheetController setValue:hogan forKey:@"attributedTitle"];
            }
            
            UIAlertAction *confirm = [UIAlertAction actionWithTitle:[buttonArr objectAtIndex:i] style:buttonStyle handler:^(UIAlertAction * _Nonnull action) {
                
                if (alerAction) {
                    alerAction(i);
                }
                
            }];
            
            if (type == UIAlertControllerStyleActionSheet) {
                if (![buttonArr[i] isEqualToString:@"取消"]) {
                    if (@available(iOS 9.0, *))
                    {
                        [confirm setValue:kDarkGrayColor forKey:@"titleTextColor"];
                    }
                }
            }
            
            if (type == UIAlertControllerStyleAlert) {
                if (@available(iOS 9.0, *)) {
                    if ([buttonArr[i] isEqualToString:@"取消"])
                    {
                        [confirm setValue:kDarkGrayColor forKey:@"titleTextColor"];
                    }
                    else
                    {
                        [confirm setValue:kDarkGrayColor forKey:@"titleTextColor"];
                    }
                }
            }
            
            [actionSheetController addAction:confirm];
        }
        [self presentViewController:actionSheetController animated:YES completion:nil];
    });
    
}

- (void)backBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)showBackBtnWithTitle:(NSString *)title{
    [self.view addSubview:self.backBtn];
    [self subLayout];
}

-(UIButton *)backBtn{
    if (!_backBtn) {
        _backBtn = [CCUtil createBtnTitle:@"" titleColor:kBlackColor backgroundColor:kClearColor bgImageName:@"黑色返回" target:self action:@selector(backBtnClick)];
        _backBtn.titleLabel.font = BOLDSYSTEMFONT(22);
        _backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _backBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 0);
        _backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    }
    return _backBtn;
}


- (void)subLayout{
    [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.width.mas_equalTo(120);
        make.top.mas_equalTo(StatusBarHeight);
        make.height.mas_equalTo(64);
    }];
    
    
}


#pragma mark -- 返回按钮以及文字设置
- (void)setBackBarButtonWithImage:(NSString *)image title:(NSString *)title{
    
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.frame = CGRectMake(0, 0, 45, 44);
    [button setTitle:title forState:(UIControlStateNormal)];
    [button setImage:[UIImage imageNamed:image] forState:(UIControlStateNormal)];
    button.titleLabel.font = [UIFont systemFontOfSize:20];
    [button setTitleColor:[UIColor darkGrayColor] forState:(UIControlStateNormal)];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [button addTarget:self action:@selector(backBarButtonAction) forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)backBarButtonAction{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
