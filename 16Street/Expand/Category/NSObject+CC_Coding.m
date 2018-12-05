//
//  NSObject+CC_Coding.m
//  奶爸钱包
//
//  Created by 王毅 on 2018/3/8.
//  Copyright © 2018年 MYJF. All rights reserved.
//

#import "NSObject+CC_Coding.h"
#import <objc/message.h>

@implementation NSObject (CC_Coding)

-(void)CC_encode:(NSCoder *)aCoder{
    unsigned int count = 0 ;
    Ivar *ivars = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i ++) {
        Ivar  ivar = ivars[i];
        const char*name = ivar_getName(ivar);
        NSString *key = [[NSString alloc]initWithUTF8String:name];
        [aCoder encodeObject:[self valueForKey:key] forKey:key];
    }
}

-(void)CC_decode:(NSCoder *)aDecoder{
    
    unsigned int count = 0  ;
    Ivar *ivars = class_copyIvarList([self class], &count);
    for (int i = 0; i <count; i ++) {
        Ivar ivar = ivars[i];
        const char *name = ivar_getName(ivar);
        NSString *key = [[NSString alloc] initWithUTF8String:name];
        id value = [aDecoder decodeObjectForKey:key];
        [self setValue:value forKey:key];
        
    }
    
}

@end
