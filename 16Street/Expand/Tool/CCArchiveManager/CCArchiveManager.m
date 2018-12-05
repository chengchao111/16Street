//
//  CCArchiveManager.m
//  16Street
//
//  Created by apple on 2018/10/11.
//  Copyright © 2018年 toerax. All rights reserved.
//

#import "CCArchiveManager.h"
#import <UIKit/UIKit.h>
@implementation CCArchiveManager
//归档
+(void)archiveRootObject:(id)object filePath:(NSString *)filePath{
    
    NSString *Path = NSHomeDirectory();
    NSString * fileStr = [Path stringByAppendingPathComponent:filePath];
    NSLog(@"fileStr = %@",fileStr);
    [NSKeyedArchiver archiveRootObject:object toFile:fileStr];
    BOOL success = [NSKeyedArchiver archiveRootObject:object toFile:fileStr];
    if (success) {
        NSLog(@"归档成功");
    }else{
        NSLog(@"归档失败");
    }
}

//解当
+(id)unarchiveObjectWithfilePath:(NSString *)filePath{
    NSString * Path = NSHomeDirectory();
    NSString * fileStr = [Path stringByAppendingPathComponent:filePath];
    id obj = [NSKeyedUnarchiver unarchiveObjectWithFile:fileStr];
    return obj;
}

//删除归档数据
+(void)removeObjectWithFilePath:(NSString *)filePath{
    NSString * Path = NSHomeDirectory();
    NSString * fileStr = [Path stringByAppendingPathComponent:filePath];
    NSFileManager *defaultManager = [NSFileManager defaultManager];
    if ([defaultManager isDeletableFileAtPath:fileStr]) {
        [defaultManager removeItemAtPath:fileStr error:nil];
    }
}

@end
