//
//  NSString+Category.h
//  New16Hour
//
//  Created by apple on 2018/8/1.
//  Copyright © 2018年 ChengChao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Category)
#pragma mark -- 正则匹配电话号码
-(BOOL)isPhoneNumber;
#pragma mark -- 正则匹配邮箱
-(BOOL)isEmail;

#pragma mark -- 正则匹配URL地址
-(BOOL)isUrl;


#pragma mark -- 判断字符串是否以某个字符串开头
-(BOOL)isBeginsWith:(NSString *)string;
#pragma mark -- 判断字符串是否以某个字符串结尾
-(BOOL)isEndssWith:(NSString *)string;
#pragma mark -- 判断字符串是否包含某个字符串
-(BOOL)containsString:(NSString *)subString;

#pragma mark -- 新字符串替换老字符串
-(NSString *)replaceCharcter:(NSString *)olderChar withCharcter:(NSString *)newerChar;
#pragma mark -- 截取字符串(字符串都是从第0个字符开始数的哦~)
-(NSString*)getSubstringFrom:(NSInteger)begin to:(NSInteger)end;

#pragma mark -- 添加字符串

-(NSString *)addString:(NSString *)string;
#pragma mark -- 从主字符串中移除某个字符串
-(NSString *)removeSubString:(NSString *)subString;
#pragma mark -- 去掉字符串中的空格
-(NSString *)removeWhiteSpacesFromString;
#pragma mark -- 判断字符串是否只包含字母-1
-(BOOL)containsOnlyLetters;
#pragma mark -- 判断字符串是否只包含字母-2(正则)
-(BOOL)isLetter;
#pragma mark -- 判断字符串是否只包含数字-1
-(BOOL)containsOnlyNumbers;
#pragma mark -- 判断字符串是否只包含数字-2(正则)
-(BOOL)isNumbers;
#pragma mark -- 判断字符串是否只包含数字和字母
-(BOOL)containsOnlyNumbersAndLetters;
#pragma mark -- 由字母或数字组成 6-18位密码字符串(正则)
-(BOOL)isPassword ;
#pragma mark -- 判断数组中是否包含某个字符串
-(BOOL)isInThisarray:(NSArray*)array;
#pragma mark -- 字符串转Data
-(NSData *)convertToData;
#pragma mark -- Data转字符转
+(NSString *)getStringFromData:(NSData *)data;

#pragma mark -- 获取系统版本号

+(NSString *)getMyApplicationVersion;
#pragma mark -- 字符串编码
-(NSString*)EncodingWithUTF8;
#pragma mark -- 获取当前时间
+(NSString*)getCurrentTimeString;
#pragma mark -- 通知字符串长度 (文字 2个字节 字母:1个字节) // 统计ASCII和Unicode混合文本长度
-(NSUInteger) unicodeLengthOfString;

+ (NSString *)imageTobase64String:(UIImage *)image;

#pragma mark -- 计算属性字符文本占用的宽高

/**
 * 计算属性字符文本占用的宽高
 * @param font 显示的字体
 * @param maxSize 最大的显示范围
 * @param lineSpacing 行间距
 * @return 占用的宽高
 */
+ (CGSize)getTextSizeWithStr:(NSString *)textStr withSize:(CGSize)maxSize withFont:(UIFont *)font;

#pragma mark -- 时间戳转时间
-(NSDate *)dateValueWithMillisecondsSince1970;

+ (NSAttributedString *)textStringToMulticolor:(NSString *)textString addAttributes:(NSDictionary<NSAttributedStringKey, id> *)attrs range:(NSRange)range nextrange:(NSRange)nextrange;

+ (NSAttributedString *)textStringToMulticolor:(NSString *)textString addAttributes:(NSDictionary<NSAttributedStringKey, id> *)attrs range:(NSRange)range;

- (NSDictionary *)JsonStringToDictionary;
@end
