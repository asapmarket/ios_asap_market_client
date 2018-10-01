//
//  MeServer.m
//  WaiMaiClient
//
//  Created by 王 on 2017/8/10.
//  Copyright © 2017年 王. All rights reserved.
//

#import "MeServer.h"
#import "WHttpTool.h"

@implementation MeServer

+ (void)getAddressListSuccess:(void (^)(AddressListModel *))success failure:(void (^)(NSError *))failure{
    
    NSString *url = [UrlsManager getAddressList];
    [WHttpTool getWithURL:url params:nil success:^(id json) {
        AddressListModel *result = [AddressListModel mj_objectWithKeyValues:json];
        
        success(result);
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)getAddAddressWithExtmName:(NSString *)extmName sex:(NSString *)sex address:(NSString *)address zipCode:(NSString *)zipCode extm_phone:(NSString *)extm_phone Success:(void (^)(AddressModel *result))success failure:(void(^)(NSError *error))failure{
    NSString *url = [UrlsManager getAddAddressWithExtmName:extmName sex:sex address:address zipCode:zipCode extm_phone:extm_phone];
    [WHttpTool getWithURL:url params:nil success:^(id json) {
        if ([json isKindOfClass:[NSDictionary class]]) {
            AddressModel *result = [AddressModel mj_objectWithKeyValues:json[@"extm"]];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)getEditAddressWithExtmId:(NSString *)extmId extmName:(NSString *)extmName sex:(NSString *)sex address:(NSString *)address zipCode:(NSString *)zipCode extm_phone:(NSString *)extm_phone Success:(void (^)(AddressModel *result))success failure:(void(^)(NSError *error))failure{
    NSString *url = [UrlsManager getEditAddressWithExtmId:extmId extmName:extmName sex:sex address:address zipCode:zipCode extm_phone:extm_phone];
    [WHttpTool getWithURL:url params:nil success:^(id json) {
        if ([json isKindOfClass:[NSDictionary class]]) {
            AddressModel *result = [AddressModel mj_objectWithKeyValues:json[@"extm"]];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)getDeleteAddressWithExtmId:(NSString *)extmId Success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    NSString *url = [UrlsManager getDeleteAddressWithExtmId:extmId];
    [WHttpTool getWithURL:url params:nil success:^(id json) {
        success(json);
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)getIsEffZipCodeWithZipCodel:(NSString *)zipCode Success:(void (^)(NSString *))success failure:(void (^)(NSError *))failure{
    [MBProgressHUD showMessage:nil];
    NSString *url = [UrlsManager getIsEffZipCodeUrlWithZipCodel:zipCode];
    [WHttpTool getWithURL:url params:nil success:^(id json) {
        NSString *result;
        if ([json isKindOfClass:[NSDictionary class]]) {
            result = json[@"in_range"];
        }
        success(result);
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void) updatePwdWithOldPwd:(NSString *)oldPwd newPwd:(NSString *)newPwd Success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    NSString *url = [UrlsManager getUpdatePwdWithOldPwd:oldPwd newPwd:newPwd];
    [WHttpTool getWithURL:url params:nil success:^(id json) {
        success(json);
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)meUploadFormDataArray:(NSArray *)formDataArray success:(void (^)(CodeModel *result))success failure:(void(^)(NSError *error))failure
{
    NSLog(@"URL:%@",kUploadURL);
    [WHttpTool postWithURL:kUploadURL params:nil formDataArray:formDataArray success:^(id json) {
        CodeModel *result = [CodeModel mj_objectWithKeyValues:json];
        success(result);
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)upDateNickName:(NSString *)nickName Success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    NSString *url = [UrlsManager getUpDateNickNameUrlWithNickName:nickName];
    [WHttpTool getWithURL:url params:nil success:^(id json) {
        success(json);
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)upDateHeadImage:(NSString *)headImage Success:(void (^)(CodeModel *result))success failure:(void (^)(NSError *))failure{
    NSString *url = [UrlsManager getUpdateHeadUrlWithHead_image:headImage];
    [WHttpTool getWithURL:url params:nil success:^(id json) {
        CodeModel *result = [CodeModel mj_objectWithKeyValues:json];
        success(result);
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)messageListWithPage:(int)page Success:(void (^)(MessageBaseModel *))success failure:(void (^)(NSError *))failure{
    NSString *url = [UrlsManager getMessageListUrlWithPage:page];
    [WHttpTool getWithURL:url params:nil success:^(id json) {
        MessageBaseModel *result = [MessageBaseModel mj_objectWithKeyValues:json];
        success(result);
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)delMessageWithMessageId:(NSString *)messageId Success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    NSString *url = [UrlsManager getDelMessageUrlWithMessageId:messageId];
    [WHttpTool getWithURL:url params:nil success:^(id json) {
        success(json);
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)readMessageWithMessageId:(NSString *)messageId Success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    NSString *url = [UrlsManager getReadMessageUrlWithMessageId:messageId];
    [WHttpTool getWithURL:url params:nil success:^(id json) {
        success(json);
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)creditCardListSuccess:(void (^)(CreditCardList *))success failure:(void (^)(NSError *))failure{
    
    [WHttpTool getWithURL:[UrlsManager getCreditCardListUrl] params:nil success:^(id json) {
        
        CreditCardList *result = [CreditCardList mj_objectWithKeyValues:json];
        success(result);
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)addCreditCardWithCardNo:(NSString *)cardNo date:(NSString *)date cvv:(NSString *)cvv address:(NSString *)adress firstName:(NSString *)firstName lastName:(NSString *)lastName zip_code:(NSString *)zip_code Success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    NSString *url = [UrlsManager getAddCreditCardUrlWithCardNo:cardNo expiration_date:date cvv:cvv address:adress first_name:firstName last_name:lastName zip_code:zip_code];
    [WHttpTool getWithURL:url params:nil success:^(id json) {
        success(json);
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}


+ (void)deletaCreditCardWithID:(NSString *)cardId Success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    NSString *url = [UrlsManager getDeleteCreditCartWithId:cardId];
    [WHttpTool getWithURL:url params:nil success:^(id json) {
        success(json);
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
