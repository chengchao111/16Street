//
//  CCLoginModel.m
//  16Street
//
//  Created by apple on 2018/10/11.
//  Copyright © 2018年 toerax. All rights reserved.
//

#import "CCLoginModel.h"
#import "NSObject+CC_Coding.h"
@implementation CCLoginModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"Id":@"id"};
}

CCCoding;

@end
