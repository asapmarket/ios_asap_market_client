//
//  UrlsManager.m
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/7/20.
//  Copyright © 2017年 王. All rights reserved.
//

#import "UrlsManager.h"
#import<CommonCrypto/CommonDigest.h>

@implementation UrlsManager

+ (NSString *)token{
    UserInfo *userInfo = [UserInfoTool loadLoginAccount];
    return userInfo.token;
}

+ (NSString *)userID{
    UserInfo *userInfo = [UserInfoTool loadLoginAccount];
    return userInfo.user_id;
}

//登录
+ (NSString *)getLoginUrlWithPhoneNo:(NSString *)phoneNo pwd:(NSString *)pwd{
    pwd = [UrlsManager md5:pwd];
    return [NSString stringWithFormat:@"%@?phone=%@&pwd=%@",kLoginUrl,phoneNo,pwd];
}

//注册
+ (NSString *)getUserRegUrlWithPhone:(NSString *)phone pwd:(NSString *)pwd code:(NSString *)code{
    pwd = [UrlsManager md5:pwd];
    return [NSString stringWithFormat:@"%@?phone=%@&pwd=%@&code=%@",kUserRegUrl,phone,pwd,code];
}

//修改昵称
+ (NSString *)getUpDateNickNameUrlWithNickName:(NSString *)nickName{
    return [NSString stringWithFormat:@"%@?%@&nick_name=%@",kUpDateNickNameUrl,kUserBaseUrl,nickName];
}

//忘记密码
+ (NSString *)getForgetPwdUrlWithPhone:(NSString *)phone code:(NSString *)code pwd:(NSString *)pwd{
    pwd = [UrlsManager md5:pwd];
    return [NSString stringWithFormat:@"%@?phone=%@&new_pwd=%@&code=%@",kForgetPwdUrl,phone,pwd,code];
}

//修改头像
+ (NSString *)getUpdateHeadUrlWithHead_image:(NSString *)head_image{
    return [NSString stringWithFormat:@"%@?%@&head_image=%@",kUpDateHeadUrl,kUserBaseUrl,head_image];
}


+ (NSString *)getUpdatePwdWithOldPwd:(NSString *)oldPwd newPwd:(NSString *)newPwd{
    oldPwd = [UrlsManager md5:oldPwd];
    newPwd = [UrlsManager md5:newPwd];
    return [NSString stringWithFormat:@"%@?%@&old_pwd=%@&new_pwd=%@",kUpdatePwdUrl,kUserBaseUrl,oldPwd,newPwd];
}

+ (NSString *)getUserBaseUrl{
    UserInfo *userInfo = [UserInfoTool loadLoginAccount];
    return [NSString stringWithFormat:@"user_id=%@&token=%@",userInfo.user_id,userInfo.token];
}

+ (NSString *)getMessageListUrlWithPage:(int)page{
    return [NSString stringWithFormat:@"%@?%@&page_size=10&page=%d",kMessageListUrl,kUserBaseUrl,page];
}

+ (NSString *)getDelMessageUrlWithMessageId:(NSString *)messageId{
    return [NSString stringWithFormat:@"%@?%@&message_id=%@",kDelMessageUrl,kUserBaseUrl,messageId];
}

+ (NSString *)getReadMessageUrlWithMessageId:(NSString *)messageId{
    return [NSString stringWithFormat:@"%@?%@&message_id=%@",kReadMessageUrl,kUserBaseUrl,messageId];
}

//首页接口
+ (NSString *)getHomePageUrl{
    return [NSString stringWithFormat:@"%@",kHomePageUrl];
}

+ (NSString *)getCerCodeUrlWithPhoneNo:(NSString *)phoneNo{
    return [NSString stringWithFormat:@"%@?phone=%@",kCerCodeUrl,phoneNo];
}

+ (NSString *)getColletListUrlWithPage:(NSString *)page{
    return [NSString stringWithFormat:@"%@?%@&page_size=10&page=%@",kCollectListUrl,kUserBaseUrl,page];
}

+ (NSString *)getStoreListUrlWithPage:(NSString *)page type:(NSString *)type{
    if ([type isEqualToString:@"0"]) {
        return [NSString stringWithFormat:@"%@?page_size=9&page=%@&type=%@",kStoreListUrl,page,type];
    }else{
        return [NSString stringWithFormat:@"%@?page_size=9&page=%@&type=1&type_id=%@",kStoreListUrl,page,type];
    }
}

+ (NSString *)getStoreDetailUrlWithStoreId:(NSString *)storeId{
    return [NSString stringWithFormat:@"%@?%@&store_id=%@",kStoreDetailUrl,kUserBaseUrl,storeId];
}

+ (NSString *)getStoreFoodsListWithStoreId:(NSString *)storeId{
    return [NSString stringWithFormat:@"%@?%@&store_id=%@",kStoreFoodsListUrl,kUserBaseUrl,storeId];
}

+ (NSString *)getIsStoreCollectWithStoreId:(NSString *)storeId{
    return [NSString stringWithFormat:@"%@?%@&store_id=%@",kIsStoreCollectUrl,kUserBaseUrl,storeId];
}

//商品单价
+ (NSString *)getFoodsPriceUrlWithFoodId:(NSString *)foodId specIdList:(NSString *)spec_id_list{
    return [NSString stringWithFormat:@"%@?%@&foods_id=%@&spec_id_list=%@",kFoodsPriceUrl,kUserBaseUrl,foodId,spec_id_list];
}

//获取商品详情
+ (NSString *)getFoodsDetailUrlWithStoreId:(NSString *)storeId foodsId:(NSString *)foodsId{
    return [NSString stringWithFormat:@"%@?%@&foods_id=%@&store_id=%@",kFoodsDetailUrl,kUserBaseUrl,foodsId,storeId];
}

//订单列表
+ (NSString *)getOrderListUrlWithPage:(NSString *)page state:(NSString *)state{
    return [NSString stringWithFormat:@"%@?%@&page_size=10&page=%@&state=%@",kOrderListUrl,kUserBaseUrl,page, state];
}

//订单详情
+ (NSString *)getOrderDetailUrlWithOrderId:(NSString *)orderId{
     return [NSString stringWithFormat:@"%@?%@&order_id=%@",kOrderDetailUrl,kUserBaseUrl,orderId];
}

+ (NSString *)getAppleOrderResultUrlWithOrderId:(NSString *)order_id token:(NSString *)token{
    return [NSString stringWithFormat:@"%@?%@&order_id=%@&apple_pay_token=%@",kApplePayUrl,kUserBaseUrl,order_id,token];
}


+ (NSString *)getAddressList{
    return [NSString stringWithFormat:@"%@?%@",kAddressListUrl,kUserBaseUrl];
}

+ (NSString *)getAddAddressWithExtmName:(NSString *)extmName sex:(NSString *)sex address:(NSString *)address zipCode:(NSString *)zipCode extm_phone:(NSString *)extm_phone{
    return [NSString stringWithFormat:@"%@?%@&extm_name=%@&sex=%@&address=%@&zip_code=%@&extm_phone=%@",kAddAddressUrl,kUserBaseUrl,extmName,sex,address,zipCode,extm_phone];
}

+ (NSString *)getEditAddressWithExtmId:(NSString *)extmId extmName:(NSString *)extmName sex:(NSString *)sex address:(NSString *)address zipCode:(NSString *)zipCode extm_phone:(NSString *)extm_phone{
    return [NSString stringWithFormat:@"%@?%@&extm_id=%@&extm_name=%@&sex=%@&address=%@&zip_code=%@&extm_phone=%@",kEditAddressUrl,kUserBaseUrl,extmId,extmName,sex,address,zipCode,extm_phone];
}

+ (NSString *)getDeleteAddressWithExtmId:(NSString *)extmId{
    return [NSString stringWithFormat:@"%@?%@&extm_id=%@",kDeleteAddressUrl,kUserBaseUrl,extmId];
}

//判断地址是否在配送范围
+ (NSString *)getIsEffZipCodeUrlWithZipCodel:(NSString *)zipCode{
    return [NSString stringWithFormat:@"%@?zip_code=%@",kIsEffZipCodeUrl,zipCode];
}

+ (NSString *)getCreditCardListUrl{
    return [NSString stringWithFormat:@"%@?%@",kCreditCardListUrl,kUserBaseUrl];
}

+ (NSString *)getAddCreditCardUrlWithCardNo:(NSString *)cardNo expiration_date:(NSString *)expiration_date cvv:(NSString *)cvv address:(NSString *)address first_name:(NSString *)first_name last_name:(NSString *)last_name zip_code:(NSString *)zip_code{
    return [NSString stringWithFormat:@"%@?%@&card_no=%@&expiration_date=%@&cvv=%@&address=%@&first_name=%@&last_name=%@&zip_code=%@",kAddCreditCardUrl,kUserBaseUrl, cardNo, expiration_date,cvv, address, first_name, last_name, zip_code];
}

+ (NSString *)getDeleteCreditCartWithId:(NSString *)cardId{
    return [NSString stringWithFormat:@"%@?%@&id=%@",kDeleteCreditCardUrl,kUserBaseUrl, cardId];
}

+ (NSString *)getWalletPageURL{
    NSString *requestUrl = [NSString stringWithFormat:@"%@?%@",kGetWalletPageURL,kUserBaseUrl];
    NSLog(@"getWalletPageURL = %@",requestUrl);
    return requestUrl;
}

+ (NSString *)getExchangeURL{
    NSString *requestUrl = [NSString stringWithFormat:@"%@?%@",kExchangeURL, kUserBaseUrl];
    NSLog(@"getExchangeURL = %@",requestUrl);
    return requestUrl;
}

//md5加密
+ (NSString *) md5:(NSString *) input {
    const char *cStr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return  output;
}




@end
