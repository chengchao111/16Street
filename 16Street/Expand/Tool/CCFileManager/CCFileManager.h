//
//  CCFileManager.h
//  16Street
//
//  Created by apple on 2018/11/15.
//  Copyright © 2018年 toerax. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CCFileManager : NSObject
+(void)saveFileWithData:(id)data filePath:(NSString *)filePath;
+(void)deleteFileWithFilePath:(NSString *)filePath;
+ (NSDictionary *)getFileWithFilePath:(NSString *)filePath;
@end

NS_ASSUME_NONNULL_END
