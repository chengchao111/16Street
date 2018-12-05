//
//  Util.h
//  New16Hour
//
//  Created by apple on 2018/8/1.
//  Copyright © 2018年 ChengChao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Util : NSObject

//四舍五入
+(NSString *)dataFormWithFloat:(CGFloat)floatData;

//3.时间戳转化为时间
+(NSString*)TimeTrasformWithDate:(NSString *)dateString;

//MD5加密
+ (NSString *)MD5EncryptWithString:(NSString *)data;

//sha1加密
+ (NSString *)sha1:(NSString *)input;

//字典转json
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

//压缩图片
+(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;

//获取AuthData
+ (id)getUserDefaultsForKey:(NSString *)key;

//保存AuthData
+ (void)setUserDefaultsObject:(id)value ForKey:(NSString *)key;

//删除NSUserdefault
+ (void)UserDefaultRemoveObjectForKey:(NSString *)key;


+ (NSAttributedString *)textStringToMulticolor:(NSString *)textString addAttributes:(NSDictionary<NSAttributedStringKey, id> *)attrs range:(NSRange)range nextrange:(NSRange)nextrange;

//根据经纬度 计算两点距离

+(double)distanceBetweenOrderByLat1:(double)lat1 lat2:(double)lat2 lng1:(double)lng1 lng2:(double)lng2;

#pragma mark --是否打开设备手电筒
+ (void)turnTorchOn:(bool)on;

//判断空字符串
+  (BOOL)isEmptyString:(NSString *)aStr;

//判断是否是村数字
+ (BOOL)isNum:(NSString *)checkedNumString;

#pragma mark --判断是否是手机号码（村数字 + 11位）
+ (BOOL)isPhoneNum:(NSString *)str;
@end
