//
//  NSArray+XDhandle.m
//  XDSlideController
//
//  Created by 谢兴达 on 2018/8/15.
//  Copyright © 2018年 谢兴达. All rights reserved.
//

#import "NSArray+XDhandle.h"

@implementation NSArray (XDhandle)
- (BOOL)hasRepeatItemInArray {
    NSArray *arr = self;
    id repeatItem = nil;
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    for (id obj in arr) {
        if ([dic objectForKey:obj]) {
            repeatItem = obj;
            break;
        } else {
            [dic setObject:obj forKey:obj];
        }
    }
    dic = nil;
    return repeatItem ? YES : NO;
}
@end
