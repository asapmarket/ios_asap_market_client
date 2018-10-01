//
//  WHttpTool.m
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/7/20.
//  Copyright © 2017年 王. All rights reserved.
//

#import "WHttpTool.h"
#import "AFNetworking.h"

@implementation WHttpTool

+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
//    [MBProgressHUD showMessage:nil];
    
    //创建请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    url = [WHttpTool stringByAddingPercentEscapesUsingUTF8StringEncoding:url];
    mgr.requestSerializer = [AFJSONRequestSerializer serializer];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", @"text/json", nil];
    [mgr POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        // 数据请求的进度
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"responseObject:%@",responseObject);
        
        // 判断code  0000:成功 0001:失败
        // 判断 数据是否正确
        [WHttpTool requestFinished:responseObject success:success failure:failure];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@",error);
        if( [LanguageManager shareManager].language == 0){
            error = [NSError errorWithDomain:kResultErrorDomin
                                        code:123
                                    userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"oops！something is wrong.",kResultErrorDesKey, nil]];
        }else{
            error = [NSError errorWithDomain:kResultErrorDomin
                                        code:123
                                    userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"哎呀，又出错了？",kResultErrorDesKey,nil]];
        }
        failure(error);
    }];

    
}

+ (void)loginPostWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
//    [MBProgressHUD showMessage:nil];
    
    //创建请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    url = [WHttpTool stringByAddingPercentEscapesUsingUTF8StringEncoding:url];
    [mgr POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        // 数据请求的进度
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"responseObject:%@",responseObject);
        // 判断code  0000:成功 0001:失败
        // 判断 数据是否正确
        [WHttpTool requestFinished:responseObject success:success failure:failure];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if( [LanguageManager shareManager].language == 0){
            error = [NSError errorWithDomain:kResultErrorDomin
                                        code:123
                                    userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"oops！something is wrong.",kResultErrorDesKey, nil]];
        }else{
            error = [NSError errorWithDomain:kResultErrorDomin
                                        code:123
                                    userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"哎呀，又出错了？",kResultErrorDesKey,nil]];
        }
        failure(error);
    }];
    
    
}


+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params formDataArray:(NSArray *)formDataArray success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    
//    [MBProgressHUD showMessage:nil];
    //创建请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    url = [WHttpTool stringByAddingPercentEscapesUsingUTF8StringEncoding:url];

    [mgr POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull totalFormData) {
        for (WFormData *formData in formDataArray) {
            [totalFormData appendPartWithFileData:formData.data name:formData.name fileName:formData.filename mimeType:formData.mimeType];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 判断 数据是否正确
        [WHttpTool requestFinished:responseObject success:success failure:failure];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            if( [LanguageManager shareManager].language == 0){
                error = [NSError errorWithDomain:kResultErrorDomin
                                            code:123
                                        userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"oops！something is wrong.",kResultErrorDesKey, nil]];
            }else{
                error = [NSError errorWithDomain:kResultErrorDomin
                                            code:123
                                        userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"哎呀，又出错了？",kResultErrorDesKey,nil]];
            }
            failure(error);
        }
    }];
    
}

+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
//    [MBProgressHUD showMessage:nil];

    //创建请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    url = [WHttpTool stringByAddingPercentEscapesUsingUTF8StringEncoding:url];
    
    [mgr GET:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
//                [MBProgressHUD showMessage:nil];

        // 数据请求的进度
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        // 判断 数据是否正确
        [WHttpTool requestFinished:responseObject success:success failure:failure];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if( [LanguageManager shareManager].language == 0){
            error = [NSError errorWithDomain:kResultErrorDomin
                                        code:123
                                    userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"oops！something is wrong.",kResultErrorDesKey, nil]];
        }else{
            error = [NSError errorWithDomain:kResultErrorDomin
                                        code:123
                                    userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"哎呀，又出错了？",kResultErrorDesKey,nil]];
        }
        failure(error);
    }];
    
    
}

+ (void)requestFinished:(id  _Nullable)responseObject success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 服务器返回数据是否有错误
    // 不是OK 就错了
    
//    dispatch_async(dispatch_get_main_queue(), ^{
//       [MBProgressHUD hideHUD];
//    });
    if (![responseObject[@"status"] isEqualToString:@"10001"]) {
        NSError *error;
        if( [LanguageManager shareManager].language == 0){
            error = [NSError errorWithDomain:kResultErrorDomin
                                                 code:[responseObject[@"status"] integerValue]
                                             userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseObject[@"msg_en"],kResultErrorDesKey, nil]];
        }else{
            error = [NSError errorWithDomain:kResultErrorDomin
                                        code:[responseObject[@"status"] integerValue]
                                    userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseObject[@"msg_cn"],kResultErrorDesKey,nil]];
        }
        failure(error);
    } else {
        
        success(responseObject[@"data"]);
    }
}

+ (NSString *)stringByAddingPercentEscapesUsingUTF8StringEncoding:(NSString *)string
{
    NSString *tmpString =[string stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    if (tmpString == nil)
    {
        tmpString = [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    else
    {
        tmpString = [tmpString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    return tmpString;
}

@end

/**
 *  用来封装文件数据的模型
 */
@implementation WFormData

@end
