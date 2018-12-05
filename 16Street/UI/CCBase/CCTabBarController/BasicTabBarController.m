//
//  BasicTabBarController.m
//  SixTeenHourShoppingMall
//
//  Created by apple on 2018/10/10.
//  Copyright © 2018年 toerax. All rights reserved.
//

#import "BasicTabBarController.h"
#import "CCTabBar.h"

#import "CCMineVC.h"
#import "CCTrendVC.h"
#import "CCPostVC.h"
#import "CCWelfareVC.h"
#import "CCMassageVC.h"
#import "BaseNavigationController.h"
#import "CCLoginModel.h"
#import "CCLoginVC.h"
@interface BasicTabBarController ()<UITabBarControllerDelegate>

@property (nonatomic, strong) CCTabBar *tabbar;
@property (nonatomic, assign) NSUInteger selectItem;//选中的item
@property (nonatomic,assign) NSInteger lastSelectedIndex;
@end

@implementation BasicTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tabbar = [[CCTabBar alloc] init];
    [_tabbar.centerBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    //选中时的颜色
    _tabbar.tintColor = Color(251, 88, 118);
//    _tabbar.tintColor = [UIColor colorWithRed:27.0/255.0 green:118.0/255.0 blue:208/255.0 alpha:1];
    //透明设置为NO，显示白色，view的高度到tabbar顶部截止，YES的话到底部
    _tabbar.translucent = NO;
    //利用KVC 将自己的tabbar赋给系统tabBar
    [self setValue:_tabbar forKeyPath:@"tabBar"];
    
    self.selectItem = 0; //默认选中第一个
    self.delegate = self;
    [self addChildViewControllers];
    
}

//添加子控制器
- (void)addChildViewControllers{
    //图片大小建议32*32
    [self addChildrenViewController:[[CCTrendVC alloc] init] andTitle:@"潮show" andImageName:@"潮show2" andSelectImage:@"潮show1"];
    [self addChildrenViewController:[[CCWelfareVC alloc] init] andTitle:@"福利" andImageName:@"福利2" andSelectImage:@"福利1"];
    //中间这个不设置东西，只占位
    [self addChildrenViewController:nil andTitle:@"" andImageName:@"" andSelectImage:@""];
    [self addChildrenViewController:[[CCMassageVC alloc] init] andTitle:@"消息" andImageName:@"消息2" andSelectImage:@"消息1"];
    [self addChildrenViewController:[[CCMineVC alloc] init] andTitle:@"我的" andImageName:@"我的2" andSelectImage:@"我的1"];
}

- (void)addChildrenViewController:(UIViewController *)childVC andTitle:(NSString *)title andImageName:(NSString *)imageName andSelectImage:(NSString *)selectedImage{
    
    childVC.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    childVC.tabBarItem.selectedImage =  [[UIImage imageNamed:selectedImage] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    childVC.title = title;
    
    BaseNavigationController *baseNav = [[BaseNavigationController alloc] initWithRootViewController:childVC];
    
    [self addChildViewController:baseNav];
}

- (BOOL)tabBarController:(UITabBarController*)tabBarController shouldSelectViewController:(UIViewController*)viewController

{
    //获取上一个选中的item
    self.lastSelectedIndex = tabBarController.selectedIndex;
    return YES;
}

//选中中间按钮的时候
- (void)buttonAction:(UIButton *)button{

    WeakSelf(self);
    CCLoginModel *model = [CCArchiveManager unarchiveObjectWithfilePath:UserInfoPath];
    if (model.Id == nil) {
        [UserManager cheakNeedLogin];
    }else{
       NSDictionary *dic = [CCFileManager getFileWithFilePath:PostFilePath];
        if ([dic[@"images"] count] > 0 || ![Util isEmptyString:dic[@"title"]] || ![Util isEmptyString:dic[@"subTitle"]]) {
            UIAlertController *actionSheetController = [UIAlertController alertControllerWithTitle:nil message:@"是否继续编辑上次未发布的新潮show" preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction *goOnAction = [UIAlertAction actionWithTitle:@"继续编辑" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                CCPostVC *vc = [[CCPostVC alloc] init];
                [weakself presentViewController:vc animated:YES completion:nil];
            }];
            UIAlertAction *newAction = [UIAlertAction actionWithTitle:@"发布新潮show" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                [CCFileManager deleteFileWithFilePath:PostFilePath];
                CCPostVC *vc = [[CCPostVC alloc] init];
                [weakself presentViewController:vc animated:YES completion:nil];
            }];
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [actionSheetController addAction:goOnAction];
            [actionSheetController addAction:newAction];
            [actionSheetController addAction:cancelAction];
            [self presentViewController:actionSheetController animated:YES completion:nil];
        }else{
            CCPostVC *vc = [[CCPostVC alloc] init];
            [weakself presentViewController:vc animated:YES completion:nil];
        }

        
    }
//    self.selectedIndex = 2;//关联中间按钮
    if (self.selectItem != 2){
//        [self rotationAnimation];
        
    }
//    self.selectItem = 2;
}


//tabbar选择时的代理
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    if (tabBarController.selectedIndex == 3 || tabBarController.selectedIndex == 4) {

        NSLog(@"%lu",(unsigned long)self.lastSelectedIndex);
        CCLoginModel *model = [CCArchiveManager unarchiveObjectWithfilePath:UserInfoPath];
        if (model.Id == nil) {
            [UserManager cheakNeedLogin];
            tabBarController.selectedIndex = self.lastSelectedIndex;
//            return;
        }

    }

    NSLog(@"%lu",(unsigned long)tabBarController.selectedIndex);
    if (tabBarController.selectedIndex == 2){//选中中间的按钮
        if (self.selectItem != 2){
//            [self rotationAnimation];
        }
    }else {
        [_tabbar.centerBtn.layer removeAllAnimations];

    }
    self.selectItem = tabBarController.selectedIndex;
}


//旋转动画
- (void)rotationAnimation{
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI*2.0];
    rotationAnimation.duration = 3.0;
    rotationAnimation.repeatCount = HUGE;
    [_tabbar.centerBtn.layer addAnimation:rotationAnimation forKey:@"key"];
}
@end
