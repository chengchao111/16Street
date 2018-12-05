//
//  CCNetWorking.m
//  MyDemo
//
//  Created by apple on 2018/7/18.
//  Copyright © 2018年 ChengChao. All rights reserved.
//

#import "CCNetWorking.h"
#import <PPNetworkHelper.h>
#define PPLog(...) printf("[%s] %s [第%d行]: %s\n", __TIME__ ,__PRETTY_FUNCTION__ ,__LINE__, [[NSString stringWithFormat:__VA_ARGS__] UTF8String])
@implementation CCNetWorking

#pragma mark -- post请求
+ (NSURLSessionTask *)postRequestWithURL:(NSString *)URL
                              parameters:(NSDictionary *)parameter
                                 success:(SucceedHanlder)success
                                 failure:(FailureHander)failure{
    // 在请求之前你可以统一配置你请求的相关参数 ,设置请求头, 请求参数的格式, 返回数据的格式....这样你就不需要每次请求都要设置一遍相关参数
    // 设置请求头
    //    [PPNetworkHelper setValue:@"9" forHTTPHeaderField:@"fromType"];
    
    //设置请求数据格式，默认是二进制，
    [PPNetworkHelper setRequestSerializer:(PPRequestSerializerJSON)];
    return [PPNetworkHelper POST:URL parameters:parameter success:^(id responseObject) {
        success(responseObject);
        
    } failure:^(NSError *error) {
        failure(error);
        [MBManager dismiss];
        NSLog(@"error = %@",error.localizedDescription);
    }];
}

#pragma mark --get请求
+ (NSURLSessionTask *)getRequestWithURL:(NSString *)URL
                             parameters:(NSDictionary *)parameter
                                success:(SucceedHanlder)success
                                failure:(FailureHander)failure{
    // 在请求之前你可以统一配置你请求的相关参数 ,设置请求头, 请求参数的格式, 返回数据的格式....这样你就不需要每次请求都要设置一遍相关参数
    // 设置请求头
    //    [PPNetworkHelper setValue:@"9" forHTTPHeaderField:@"fromType"];
    
     //设置请求数据格式，默认是二进制，
    [PPNetworkHelper setRequestSerializer:PPRequestSerializerJSON];

    //发起请求
    return [PPNetworkHelper GET:URL parameters:parameter success:^(id responseObject) {

        success(responseObject);
        
    } failure:^(NSError *error) {
        
        failure(error);
    }];
    
}

#pragma mark --上传文件
+ (NSURLSessionTask *)upLoadFileWithURL:(NSString *)url
                             parameters:(NSDictionary *)parameters
                                   name:(NSString *)name
                               filePath:(NSString *)filePath
                                success:(SucceedHanlder)success
                                failure:(FailureHander)failure{
    
    return [PPNetworkHelper uploadFileWithURL:url parameters:parameters name:name filePath:filePath progress:^(NSProgress *progress) {
        
    } success:^(id responseObject) {
        
        //请求成功
        if ([responseObject[@"isOk"] integerValue] == 1) {
            
        }
        success(responseObject);
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}

#pragma mark --多张图片上传
+ (void)uploadImagesWithURL:(NSString *)URL
                               parameters:(id)parameters
                                     name:(NSString *)name
                                   images:(NSArray<UIImage *> *)images
                                fileNames:(NSArray<NSString *> *)fileNames
                               imageScale:(CGFloat)imageScale
                                imageType:(NSString *)imageType
                                  success:(SucceedHanlder)success
                                  failure:(FailureHander)failure{
    
    [PPNetworkHelper uploadImagesWithURL:URL parameters:parameters name:name images:images fileNames:fileNames imageScale:imageScale imageType:imageType progress:^(NSProgress *progress) {
        
    } success:^(id responseObject) {
        
        success(responseObject);
        
    } failure:^(NSError *error) {
        
        failure(error);
    }];

}

@end
