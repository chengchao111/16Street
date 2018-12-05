//
//  CCNetWorking.h
//  MyDemo
//
//  Created by apple on 2018/7/18.
//  Copyright © 2018年 ChengChao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/**
 请求成功的block
 
 @param info     返回信息
 @param response 响应体数据
 */

typedef void (^SucceedHanlder)(id response);
/**
 请求失败的block
 
 @param extInfo 扩展信息
 */
typedef void (^FailureHander) (NSError *error);


@interface CCNetWorking : NSObject

/**
 *POST
 */
+ (NSURLSessionTask *)postRequestWithURL:(NSString *)URL
                              parameters:(NSDictionary *)parameter
                                 success:(SucceedHanlder)success
                                 failure:(FailureHander)failure;


/**
 *GET
 */
+ (NSURLSessionTask *)getRequestWithURL:(NSString *)URL
                             parameters:(NSDictionary *)parameter
                                success:(SucceedHanlder)success
                                failure:(FailureHander)failure;

/**
 *  上传文件
 *
 *  @param url        请求地址
 *  @param parameters 请求参数
 *  @param name       文件对应服务器上的字段
 *  @param filePath   文件本地的沙盒路径
 *  @param Progress   上传进度信息
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancel方法
 */
+ (NSURLSessionTask *)upLoadFileWithURL:(NSString *)url
                             parameters:(NSDictionary *)parameters
                                   name:(NSString *)name
                               filePath:(NSString *)filePath
                                success:(SucceedHanlder)success
                                failure:(FailureHander)failure;


/**
 *  上传单/多张图片
 *
 *  @param URL        请求地址
 *  @param parameters 请求参数
 *  @param name       图片对应服务器上的字段
 *  @param images     图片数组
 *  @param fileNames  图片文件名数组, 可以为nil, 数组内的文件名默认为当前日期时间"yyyyMMddHHmmss"
 *  @param imageScale 图片文件压缩比 范围 (0.f ~ 1.f)
 *  @param imageType  图片文件的类型,例:png、jpg(默认类型)....
 *  @param progress   上传进度信息
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancel方法
 */

+ (void)uploadImagesWithURL:(NSString *)URL
                               parameters:(id)parameters
                                     name:(NSString *)name
                                   images:(NSArray<UIImage *> *)images
                                fileNames:(NSArray<NSString *> *)fileNames
                               imageScale:(CGFloat)imageScale
                                imageType:(NSString *)imageType
                                  success:(SucceedHanlder)success
                                  failure:(FailureHander)failure;


@end
