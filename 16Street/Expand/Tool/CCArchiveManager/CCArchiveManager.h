//
//  CCArchiveManager.h
//  16Street
//
//  Created by apple on 2018/10/11.
//  Copyright © 2018年 toerax. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CCArchiveManager : NSObject
//归档
+(void)archiveRootObject:(id)object filePath:(NSString *)filePath;

//解当
+(id)unarchiveObjectWithfilePath:(NSString *)filePath;

//删除归档文件
+ (void)removeObjectWithFilePath:(NSString *)filePath;
@end

NS_ASSUME_NONNULL_END
