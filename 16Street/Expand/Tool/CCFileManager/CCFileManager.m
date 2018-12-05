//
//  CCFileManager.m
//  16Street
//
//  Created by apple on 2018/11/15.
//  Copyright © 2018年 toerax. All rights reserved.
//

#import "CCFileManager.h"

@implementation CCFileManager
+(void)saveFileWithData:(id)data filePath:(NSString *)filePath{
    NSString *docment = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString *path = [docment stringByAppendingPathComponent:filePath];
    [data writeToFile:path atomically:YES];
    
}

///MARK:--删除缓存草稿
+(void)deleteFileWithFilePath:(NSString *)filePath{
    NSFileManager *fileMger = [NSFileManager defaultManager];
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:filePath];
    //如果文件路径存在的话
    BOOL bRet = [fileMger fileExistsAtPath:path];
    if (bRet) {
        NSError *err;
        [fileMger removeItemAtPath:path error:&err];
    }
}

///MARK:--读取保存草稿
+ (id)getFileWithFilePath:(NSString *)filePath{
    NSString *docment = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString *path = [docment stringByAppendingPathComponent:filePath];
    NSDictionary *resultDic = [NSDictionary dictionaryWithContentsOfFile:path];
    return resultDic;
}
@end
