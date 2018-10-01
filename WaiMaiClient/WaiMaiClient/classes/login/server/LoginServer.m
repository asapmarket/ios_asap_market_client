//
//  LoginServer.m
//  WaiMaiClient
//
//  Created by 王 on 2017/8/10.
//  Copyright © 2017年 王. All rights reserved.
//

#import "LoginServer.h"

@implementation LoginServer


+ (void)loginWithPhone:(NSString *)phone pwd:(NSString *)pwd Success:(void (^)(UserInfo *))success failure:(void (^)(NSError *))failure{
    NSString *url = [UrlsManager getLoginUrlWithPhoneNo:phone pwd:pwd];
    [WHttpTool getWithURL:url params:nil success:^(id json) {
        UserInfo *userInfo = [UserInfo mj_objectWithKeyValues:json];
        success(userInfo);
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
        
    }];
}

+ (void)userRegistWithPhone:(NSString *)phone pwd:(NSString *)pwd code:(NSString *)code Success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    NSString *url = [UrlsManager getUserRegUrlWithPhone:phone pwd:pwd code:code];
    [WHttpTool getWithURL:url params:nil success:^(id json) {
        success(json);
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
        
    }];
}

+ (void)getCerCodeWithPhoneNO:(NSString *)phoneNo Success:(void (^)(CodeModel *result))success failure:(void(^)(NSError *error))failure{
    NSString *url = [UrlsManager getCerCodeUrlWithPhoneNo:phoneNo];
    [WHttpTool getWithURL:url params:nil success:^(id json) {
        CodeModel *result = [CodeModel mj_objectWithKeyValues:json];
        success(result);
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}

+ (void)forgetPwdWithPhone:(NSString *)phone code:(NSString *)code pwd:(NSString *)pwd Success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    NSString *url = [UrlsManager getForgetPwdUrlWithPhone:phone code:code pwd:pwd];
    [WHttpTool getWithURL:url params:nil success:^(id json) {
        success(json);
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}


@end
