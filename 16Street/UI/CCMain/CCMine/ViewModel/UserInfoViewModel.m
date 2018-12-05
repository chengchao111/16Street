//
//  UserInfoViewModel.m
//  16Street
//
//  Created by apple on 2018/10/25.
//  Copyright © 2018年 toerax. All rights reserved.
//

#import "UserInfoViewModel.h"



@implementation UserInfoViewModel
-(void)getUserInfoWithBlock:(callBlock)block{
    CCLoginModel *model = [CCArchiveManager unarchiveObjectWithfilePath:UserInfoPath];
    NSLog(@"model = %@",model.headImg);
    if (block) {
        block(model);
    }
}

@end
