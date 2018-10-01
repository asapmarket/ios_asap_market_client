//
//  MeServer.h
//  WaiMaiClient
//
//  Created by 王 on 2017/8/10.
//  Copyright © 2017年 王. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddressListModel.h"
#import "CodeModel.h"
#import "MessageBaseModel.h"
#import "CreditCardList.h"

@interface MeServer : NSObject

+ (void)getAddressListSuccess:(void (^)(AddressListModel *result))success failure:(void(^)(NSError *error))failure;

+ (void)getAddAddressWithExtmName:(NSString *)extmName sex:(NSString *)sex address:(NSString *)address zipCode:(NSString *)zipCode extm_phone:(NSString *)extm_phone Success:(void (^)(AddressModel *result))success failure:(void(^)(NSError *error))failure;

+ (void)getEditAddressWithExtmId:(NSString *)extmId extmName:(NSString *)extmName sex:(NSString *)sex address:(NSString *)address zipCode:(NSString *)zipCode extm_phone:(NSString *)extm_phone Success:(void (^)(AddressModel *result))success failure:(void(^)(NSError *error))failure;

+ (void)getDeleteAddressWithExtmId:(NSString *)extmId Success:(void (^)(id result))success failure:(void(^)(NSError *error))failure;

//判断地址是否在配送范围
+ (void)getIsEffZipCodeWithZipCodel:(NSString *)zipCode Success:(void (^)(NSString *result))success failure:(void(^)(NSError *error))failure;

+ (void)updatePwdWithOldPwd:(NSString *)oldPwd newPwd:(NSString *)newPwd Success:(void (^)(id result))success failure:(void(^)(NSError *error))failure;

+(void)meUploadFormDataArray:(NSArray *)formDataArray success:(void (^)(CodeModel *result))success failure:(void(^)(NSError *error))failure;

+ (void)upDateHeadImage:(NSString *)headImage Success:(void (^)(CodeModel *result))success failure:(void(^)(NSError *error))failure;

+ (void)upDateNickName:(NSString *)nickName Success:(void (^)(id result))success failure:(void(^)(NSError *error))failure;

//会员消息
+ (void)messageListWithPage:(int)page Success:(void (^)(MessageBaseModel *result))success failure:(void(^)(NSError *error))failure;

+ (void)delMessageWithMessageId:(NSString *)messageId Success:(void (^)(id result))success failure:(void(^)(NSError *error))failure;

+ (void)readMessageWithMessageId:(NSString *)messageId Success:(void (^)(id result))success failure:(void(^)(NSError *error))failure;

//信用卡列表
+ (void)creditCardListSuccess:(void (^)(CreditCardList *result))success failure:(void(^)(NSError *error))failure;

//增加信用卡
+ (void)addCreditCardWithCardNo:(NSString *)cardNo date:(NSString *)date cvv:(NSString *)cvv address:(NSString *)adress firstName:(NSString *)firstName lastName:(NSString *)lastName zip_code:(NSString *)zip_code Success:(void (^)(id result))success failure:(void(^)(NSError *error))failure;

//删除信用卡
+ (void)deletaCreditCardWithID:(NSString *)cardId Success:(void (^)(id result))success failure:(void(^)(NSError *error))failure;


@end
