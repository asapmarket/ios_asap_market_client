//
//  LoginServer.h
//  WaiMaiClient
//
//  Created by 王 on 2017/8/10.
//  Copyright © 2017年 王. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WHttpTool.h"
#import "LoginParam.h"
#import "RegisterParam.h"
#import "CodeModel.h"

@interface LoginServer : NSObject


+ (void)loginWithPhone:(NSString *)phone pwd:(NSString *)pwd Success:(void (^)(UserInfo *result))success failure:(void(^)(NSError *error))failure;

+ (void)userRegistWithPhone:(NSString *)phone pwd:(NSString *)pwd code:(NSString *)code Success:(void (^)(id result))success failure:(void(^)(NSError *error))failure;

//忘记密码
+ (void)forgetPwdWithPhone:(NSString *)phone code:(NSString *)code pwd:(NSString *)pwd Success:(void (^)(id result))success failure:(void(^)(NSError *error))failure;


/** 发送验证码 */

+ (void)getCerCodeWithPhoneNO:(NSString *)phoneNo Success:(void (^)(CodeModel *result))success failure:(void(^)(NSError *error))failure;

@end
