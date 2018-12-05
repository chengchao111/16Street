//
//  NSString+Category.m
//  New16Hour
//
//  Created by apple on 2018/8/1.
//  Copyright © 2018年 ChengChao. All rights reserved.
//

#import "NSString+Category.h"

@implementation NSString (Category)

- (BOOL)isValidateByRegex:(NSString *)regex{
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pre evaluateWithObject:self];
}

#pragma mark -- 正则匹配电话号码
-(BOOL)isPhoneNumber
{
    NSString *mobileNoRegex = @"^1((3\\d|5[0-35-9]|8[025-9])\\d|70[059])\\d{7}$";//除4以外的所有个位整数，不能使用[^4,\\d]匹配，这里是否iOS Bug?
    NSString *phsRegex =@"^0(10|2[0-57-9]|\\d{3})\\d{7,8}$";
    BOOL ret = [self isValidateByRegex:mobileNoRegex];
    BOOL ret1 = [self isValidateByRegex:phsRegex];
    return (ret || ret1);
}
#pragma mark -- 正则匹配邮箱
-(BOOL)isEmail
{
    NSString *regex = @"[A-Z0-9a-z._%+-]aliyunzixun@xxx.com[A-Za-z0-9.-]+//.[A-Za-z]{2,4}";
    NSPredicate *emailTestPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [emailTestPredicate evaluateWithObject:self];
}
#pragma mark -- 正则匹配URL地址
-(BOOL)isUrl
{
    NSString *regex =@"[a-zA-z]+://[^\\s]*";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [urlTest evaluateWithObject:self];
}

#pragma mark -- 判断字符串是否以某个字符串开头
-(BOOL)isBeginsWith:(NSString *)string
{
    return ([self hasPrefix:string]) ? YES : NO;
}
#pragma mark -- 判断字符串是否以某个字符串结尾
-(BOOL)isEndssWith:(NSString *)string
{
    return ([self hasSuffix:string]) ? YES : NO;
}
#pragma mark -- 判断字符串是否包含某个字符串
-(BOOL)containsString:(NSString *)subString
{
    return ([self rangeOfString:subString].location == NSNotFound) ? NO : YES;
}
#pragma mark -- 新字符串替换老字符串
-(NSString *)replaceCharcter:(NSString *)olderChar withCharcter:(NSString *)newerChar
{
    return [self stringByReplacingOccurrencesOfString:olderChar withString:newerChar];
}
#pragma mark -- 截取字符串(字符串都是从第0个字符开始数的哦~)
-(NSString*)getSubstringFrom:(NSInteger)begin to:(NSInteger)end
{
    NSRange r;
    r.location = begin;
    r.length = end - begin;
    return [self substringWithRange:r];
}

#pragma mark -- 添加字符串

-(NSString *)addString:(NSString *)string
{
    if(!string || string.length == 0)
        return self;
    return [self stringByAppendingString:string];
}
#pragma mark -- 从主字符串中移除某个字符串
-(NSString *)removeSubString:(NSString *)subString
{
    if ([self containsString:subString])
    {
        NSRange range = [self rangeOfString:subString];
        return [self stringByReplacingCharactersInRange:range withString:@""];
    }
    return self;
}
#pragma mark -- 去掉字符串中的空格
-(NSString *)removeWhiteSpacesFromString
{
    NSString *trimmedString = [self stringByTrimmingCharactersInSet:
                               [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return trimmedString;
}
#pragma mark -- 判断字符串是否只包含字母-1
-(BOOL)containsOnlyLetters
{
    NSCharacterSet *letterCharacterset = [[NSCharacterSet letterCharacterSet] invertedSet];
    return ([self rangeOfCharacterFromSet:letterCharacterset].location == NSNotFound);
}
#pragma mark -- 判断字符串是否只包含字母-2(正则)
-(BOOL)isLetter {
    NSString *regEx = @"^[A-Za-z]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regEx];
    return [pred evaluateWithObject:self];
}
#pragma mark -- 判断字符串是否只包含数字-1
-(BOOL)containsOnlyNumbers
{
    NSCharacterSet *numbersCharacterSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    return ([self rangeOfCharacterFromSet:numbersCharacterSet].location == NSNotFound);
}
#pragma mark -- 判断字符串是否只包含数字-2(正则)
-(BOOL)isNumbers {
    NSString *regEx = @"^-?//d+.?//d?";
    NSPredicate *pred= [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regEx];
    return [pred evaluateWithObject:self];
}
#pragma mark -- 判断字符串是否只包含数字和字母
-(BOOL)containsOnlyNumbersAndLetters
{
    NSCharacterSet *numAndLetterCharSet = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
    return ([self rangeOfCharacterFromSet:numAndLetterCharSet].location == NSNotFound);
}
#pragma mark -- 由字母或数字组成 6-18位密码字符串(正则)
-(BOOL)isPassword {
    NSString * regex = @"^[A-Za-z0-9_]{6,18}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}
#pragma mark -- 判断数组中是否包含某个字符串
-(BOOL)isInThisarray:(NSArray*)array
{
    for(NSString *string in array) {
        if([self isEqualToString:string]) {
            return YES;
        }
    }
    return NO;
}
#pragma mark -- 字符串转Data
-(NSData *)convertToData
{
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}
#pragma mark -- Data转字符转
+(NSString *)getStringFromData:(NSData *)data
{ return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

#pragma mark -- 获取系统版本号

+(NSString *)getMyApplicationVersion
{
    NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    NSString *shortVersion = [info objectForKey:@"CFBundleShortVersionString"];
    return [NSString stringWithFormat:@"%@", shortVersion];
    // NSString *bundleVersion = [info objectForKey:@"CFBundleVersion"]; 测试字段号
    // NSString *name = [info objectForKey:@"CFBundleDisplayName"]; app 名字
}
#pragma mark -- 字符串编码
-(NSString*)EncodingWithUTF8
{
    NSString *urlStrl = [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return urlStrl;
}
#pragma mark -- 获取当前时间
+(NSString*)getCurrentTimeString
{
    //获取系统当前时间
    NSDate *currentDate = [NSDate date];
    //用于格式化NSDate对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设置格式:zzz表示时区
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    //NSDate转NSString
    NSString *currentDateString = [dateFormatter stringFromDate:currentDate];
    //输出currentDateString
    return currentDateString;
}
#pragma mark -- 通知字符串长度 (文字 2个字节 字母:1个字节) // 统计ASCII和Unicode混合文本长度
-(NSUInteger) unicodeLengthOfString {
    NSUInteger asciiLength = 0;
    for (NSUInteger i = 0; i < self.length; i++) {
        unichar uc = [self characterAtIndex: i];
        asciiLength += isascii(uc) ? 1 : 2;
    }
    NSUInteger unicodeLength = asciiLength / 2;
    if(asciiLength % 2) {
        unicodeLength++;
    }
    return unicodeLength;
}

+(NSString *)imageTobase64String:(UIImage *)image{
    NSData *imagedata = UIImagePNGRepresentation(image);
    
    NSString *image64 = [imagedata base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    return image64;
}



#pragma mark -- 计算属性字符文本占用的宽高

/**
 * 计算属性字符文本占用的宽高
 * @param font 显示的字体
 * @param maxSize 最大的显示范围
 * @param lineSpacing 行间距
 * @return 占用的宽高
 */
+ (CGSize)getTextSizeWithStr:(NSString *)textStr withSize:(CGSize)maxSize withFont:(UIFont *)font{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.lineSpacing = 3.0f;
    NSDictionary *attribute = @{NSFontAttributeName:font,NSParagraphStyleAttributeName:paragraphStyle.copy};
    CGSize size = [textStr boundingRectWithSize:maxSize
                                        options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                     attributes:attribute
                                        context:nil].size;
    return size;
}

#pragma mark -- 时间戳转时间
-(NSDate *)dateValueWithMillisecondsSince1970 {
    return [NSDate dateWithTimeIntervalSince1970:[self doubleValue] / 1000];
}


//富文本设置
+ (NSAttributedString *)textStringToMulticolor:(NSString *)textString addAttributes:(NSDictionary<NSAttributedStringKey, id> *)attrs range:(NSRange)range nextrange:(NSRange)nextrange
{
    
    NSMutableAttributedString * attributedText = [[NSMutableAttributedString alloc] initWithString:textString];
    [attributedText addAttributes:attrs range:range];
    [attributedText addAttributes:attrs range:nextrange];
    return attributedText;
}

//富文本设置
+ (NSAttributedString *)textStringToMulticolor:(NSString *)textString addAttributes:(NSDictionary<NSAttributedStringKey, id> *)attrs range:(NSRange)range
{
    
    NSMutableAttributedString * attributedText = [[NSMutableAttributedString alloc] initWithString:textString];
    [attributedText addAttributes:attrs range:range];

    return attributedText;
}

- (NSDictionary *)JsonStringToDictionary
{
    if (self == nil) {
        return nil;
    }
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                         
                                                        options:NSJSONReadingMutableContainers
                         
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

@end
