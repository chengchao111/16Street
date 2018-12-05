//
//  UserManager.m
//  New16Hour
//
//  Created by apple on 2018/7/31.
//  Copyright © 2018年 ChengChao. All rights reserved.
//

#import "UserManager.h"
#import "CCLoginVC.h"
#import "BaseNavigationController.h"
@implementation UserManager
#pragma mark --判断是否需要登录
+ (BOOL)cheakNeedLogin{
    BOOL isNeed = YES;
    dispatch_async(dispatch_get_main_queue(), ^{
        CCLoginVC *vc = [[CCLoginVC alloc]init];;
        BaseNavigationController * navigation = [[BaseNavigationController alloc]initWithRootViewController:vc];
        [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:navigation animated:YES completion:nil];
    });
    return isNeed;
}
@end
