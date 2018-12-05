//
//  Util.m
//  New16Hour
//
//  Created by apple on 2018/8/1.
//  Copyright © 2018年 ChengChao. All rights reserved.
//

#import "Util.h"
#import <CommonCrypto/CommonDigest.h>
#import <AVFoundation/AVFoundation.h>
@implementation Util
#pragma mark --四舍五入
+(NSString *)dataFormWithFloat:(CGFloat)floatData{
    return [NSString stringWithFormat:@"%.2f",round(floatData *100)/100];
}

#pragma mark --MD5加密
+ (NSString *)MD5EncryptWithString:(NSString *)data {
    //需要导入#import<CommonCrypto/CommonDigest.h>
    const char *cStr = [data UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (unsigned int) strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

#pragma mark ---sha1 加密
+ (NSString *)sha1:(NSString *)input{
    
    //需要导入#import<CommonCrypto/CommonDigest.h>
    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i=0; i<CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return output;
}

#pragma mark -- 字典转json,不去掉空格的
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

#pragma mark --时间戳转化为时间
+(NSString*)TimeTrasformWithDate:(NSString *)dateString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Beijing"]];
    
    NSString *date = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:dateString.integerValue/1000]];
    ////(@"date1:%@",date);
    return date;
    
}

#pragma mark --照片压缩
+(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize {
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}


#pragma mark -获取AuthData
+ (id)getUserDefaultsForKey:(NSString *)key
{
    if (key ==nil || [key length] <=0) {
        return nil;
    }
    id  AuthData = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    return AuthData;
}

#pragma mark -保存AuthData
+ (void)setUserDefaultsObject:(id)value ForKey:(NSString *)key
{
    if (key !=nil && [key length] >0) {
        [[NSUserDefaults standardUserDefaults]setObject:value forKey:key];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
}
#pragma mark -删除NSUserdefault
+ (void)UserDefaultRemoveObjectForKey:(NSString *)key
{
    if (key !=nil && [key length] >0) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

//富文本设置
+ (NSAttributedString *)textStringToMulticolor:(NSString *)textString addAttributes:(NSDictionary<NSAttributedStringKey, id> *)attrs range:(NSRange)range nextrange:(NSRange)nextrange
{
    
    NSMutableAttributedString * attributedText = [[NSMutableAttributedString alloc] initWithString:textString];
    [attributedText addAttributes:attrs range:range];
    [attributedText addAttributes:attrs range:nextrange];
    return attributedText;
}

//根据经纬度 计算两点距离
+(double)distanceBetweenOrderByLat1:(double)lat1 lat2:(double)lat2 lng1:(double)lng1 lng2:(double)lng2{
    
    double dd = M_PI/180;
    
    double x1=lat1*dd,x2=lat2*dd;
    
    double y1=lng1*dd,y2=lng2*dd;
    
    double R = 6371004;
    
    double distance = (2*R*asin(sqrt(2-2*cos(x1)*cos(x2)*cos(y1-y2) - 2*sin(x1)*sin(x2))/2));
    
    //km  返回
    
    //return  distance*1000;
    
    //返回 m
    
    return   distance;
    
}

#pragma mark --是否打开设备手电筒
+ (void)turnTorchOn:(bool)on

{
    
    Class captureDeviceClass = NSClassFromString(@"AVCaptureDevice");
    
    if (captureDeviceClass != nil) {
        
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        
        if ([device hasTorch] && [device hasFlash]){
    
            [device lockForConfiguration:nil];
            
            if (on) {
                
                [device setTorchMode:AVCaptureTorchModeOn];
                
                [device setFlashMode:AVCaptureFlashModeOn];
                
                on = YES;
                
            } else {
                
                [device setTorchMode:AVCaptureTorchModeOff];
                
                [device setFlashMode:AVCaptureFlashModeOff];
                
                on = NO;
                
            }
            
            [device unlockForConfiguration];
            
        }
        
    }
    
}

//判断空字符串
+  (BOOL)isEmptyString:(NSString *)aStr {
    if (!aStr) {
        return YES;
    }
    if ([aStr isKindOfClass:[NSNull class]]) {
        return YES;
    }
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmedStr = [aStr stringByTrimmingCharactersInSet:set];
    if (!trimmedStr.length) {
        return YES;
    }
    return NO;
}

//判断是否是村数字
+ (BOOL)isNum:(NSString *)checkedNumString {
    checkedNumString = [checkedNumString stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(checkedNumString.length > 0) {
        return NO;
    }
    return YES;
}
#pragma mark --判断是否是手机号码（村数字 + 11位）
+ (BOOL)isPhoneNum:(NSString *)str{
    
    if (str.length == 11 && [self isNum:str]) {
        return YES;
    }else{
        return NO;
    }
}


@end
