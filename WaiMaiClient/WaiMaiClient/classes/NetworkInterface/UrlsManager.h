//
//  UrlsManager.h
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/7/20.
//  Copyright © 2017年 王. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 主机地址
 */
#ifdef DEBUG //调试阶段
//#define KBaseUrl @"http://123.56.234.98:9091/app/"
#define KBaseUrl @"http://47.90.202.220:9092/app/"

#else   //发布阶段
#define KBaseUrl @"http://47.90.202.220:9092/app/"
#endif

#define kUserBaseUrl [UrlsManager getUserBaseUrl]

//登录
#define kLoginUrl [NSString stringWithFormat:@"%@login/login.do",KBaseUrl]

//注册
#define kUserRegUrl [NSString stringWithFormat:@"%@login/userReg.do",KBaseUrl]

//修改密码
#define kUpdatePwdUrl [NSString stringWithFormat:@"%@login/updatePwd.do",KBaseUrl]

//修改昵称
#define kUpDateNickNameUrl [NSString stringWithFormat:@"%@login/updateNickName.do",KBaseUrl]
//修改头像
#define kUpDateHeadUrl [NSString stringWithFormat:@"%@login/updateHead.do",KBaseUrl]

//短信验证码
#define kCerCodeUrl  [NSString stringWithFormat:@"%@login/getCerCode.do",KBaseUrl]
//首页接口
#define kHomePageUrl [NSString stringWithFormat:@"%@store/getHomePage.do",KBaseUrl]

//收藏列表
#define kCollectListUrl [NSString stringWithFormat:@"%@store/getCollectionStoreList.do",KBaseUrl]

//商家列表
#define kStoreListUrl [NSString stringWithFormat:@"%@store/getStoreList.do",KBaseUrl]

//商家详情
#define kStoreDetailUrl [NSString stringWithFormat:@"%@store/getStoreDetail.do",KBaseUrl]

//商家商品
#define kStoreFoodsListUrl [NSString stringWithFormat:@"%@store/getStoreFoodsList.do",KBaseUrl]

//商家收藏
#define kIsStoreCollectUrl [NSString stringWithFormat:@"%@store/collectStore.do",KBaseUrl]
//商品单价
#define kFoodsPriceUrl [NSString stringWithFormat:@"%@store/getFoodsPrice.do",KBaseUrl]
//商品详情
#define kFoodsDetailUrl  [NSString stringWithFormat:@"%@store/getFoodsDetail.do",KBaseUrl]

//order/countOrderAmount.do
#define kCountOrderAmountUrl [NSString stringWithFormat:@"%@order/countOrderAmount.do",KBaseUrl]


#define kHowToGetPTUrl [NSString stringWithFormat:@"%@bulletin/howToGetPoint.do",KBaseUrl]

#define kUserCouponUrl [NSString stringWithFormat:@"%@order/useCoupon.do",KBaseUrl]




/*
 订单
 **/
//订单列表
#define kOrderListUrl  [NSString stringWithFormat:@"%@order/getOrderList.do",KBaseUrl]

//订单详情
#define kOrderDetailUrl [NSString stringWithFormat:@"%@order/getOrderDetail.do",KBaseUrl]

//生成订单order/createOrder.do
#define kCreateOrderUrl [NSString stringWithFormat:@"%@order/createOrder.do",KBaseUrl]

//order/pay.do
#define kOrderPayUrl [NSString stringWithFormat:@"%@order/pay.do",KBaseUrl]

//order/applepay_notify.do
#define kApplePayUrl [NSString stringWithFormat:@"%@order/applepay_notify.do",KBaseUrl]

//order/paypal_notify4ios.do
#define kPaypalUrl [NSString stringWithFormat:@"%@order/paypal_notify4ios.do",KBaseUrl]

/*
 me
 **/
//获取地址详情
#define kAddressListUrl [NSString stringWithFormat:@"%@address/getAddressList.do",KBaseUrl]
//新增地址
#define kAddAddressUrl [NSString stringWithFormat:@"%@address/addAddress.do",KBaseUrl]

//修改地址
#define kEditAddressUrl [NSString stringWithFormat:@"%@address/editAddress.do",KBaseUrl]
//删除地址
#define kDeleteAddressUrl [NSString stringWithFormat:@"%@address/delAddress.do",KBaseUrl]
//判断地址是否在配送范围address/isEffZipCode.do
#define kIsEffZipCodeUrl [NSString stringWithFormat:@"%@address/isEffZipCode.do",KBaseUrl]

//忘记密码
#define kForgetPwdUrl  [NSString stringWithFormat:@"%@login/forgetPwd.do",KBaseUrl]

//会员消息
#define kMessageListUrl [NSString stringWithFormat:@"%@message/getMessageList.do",KBaseUrl]
//删除会员消息message/delMessage.do
#define kDelMessageUrl [NSString stringWithFormat:@"%@message/delMessage.do",KBaseUrl]
//阅读消息
#define kReadMessageUrl [NSString stringWithFormat:@"%@message/readMessage.do",KBaseUrl]

//文件上传
#define kUploadURL [NSString stringWithFormat:@"%@common/upload.do",KBaseUrl]


//信用卡支付order/authorize_pay.do
#define kCreditCardUrl  [NSString stringWithFormat:@"%@order/authorize_pay.do",KBaseUrl]

//信用卡列表member/getCardList.do
#define kCreditCardListUrl [NSString stringWithFormat:@"%@member/getCardList.do",KBaseUrl]

//新增信用卡 member/saveCard.do
#define kAddCreditCardUrl [NSString stringWithFormat:@"%@member/saveCard.do",KBaseUrl]

//删除信用卡信息member/delCard.do
#define kDeleteCreditCardUrl [NSString stringWithFormat:@"%@member/delCard.do",KBaseUrl]

//钱包接口
#define kGetWalletPageURL    [NSString stringWithFormat:@"%@wallet/getWalletPage.do",KBaseUrl]

//饭点
#define kExchangeURL [NSString stringWithFormat:@"%@wallet/exchange.do",KBaseUrl]

//跑腿订单
#define kRunOrderURL [NSString stringWithFormat:@"%@orderErrands/getOrderList.do",KBaseUrl]
//跑腿订单详情
#define kRunOrderDeatailURL [NSString stringWithFormat:@"%@orderErrands/getOrderDetail.do",KBaseUrl]

//跑腿订单下单
#define kRunCreateOrderURL [NSString stringWithFormat:@"%@orderErrands/createOrder.do",KBaseUrl]

//上传图片
#define kRunUploadFileURL [NSString stringWithFormat:@"%@common/uploadNew.do",KBaseUrl]

//修改订单状态
#define kRunOrderStateURL [NSString stringWithFormat:@"%@orderErrands/updateOrderErrandsState.do",KBaseUrl]
//查询饭点
#define kRunGetUserPointURL [NSString stringWithFormat:@"%@orderErrands/getUserPoint.do",KBaseUrl]

//配送时间
#define kDeliveryTimeURL [NSString stringWithFormat:@"%@order/getDistributionTimeListByZipCode.do",KBaseUrl]

//跑腿订单支付
#define kRunPayPalUrl [NSString stringWithFormat:@"%@orderErrands/paypalNotifyIos.do",KBaseUrl]

//跑腿现金饭点支付
#define kRunMoneyPay [NSString stringWithFormat:@"%@orderErrands/updateOrderErrandsPaymentMethod.do",KBaseUrl]

@interface UrlsManager : NSObject

+ (NSString *)token;

+ (NSString *)userID;
//登录
+ (NSString *)getLoginUrlWithPhoneNo:(NSString *)phoneNo pwd:(NSString *)pwd;
//注册
+ (NSString *)getUserRegUrlWithPhone:(NSString *)phone pwd:(NSString *)pwd code:(NSString *)code;

+ (NSString *)getUserBaseUrl;

+ (NSString *)getForgetPwdUrlWithPhone:(NSString *)phone code:(NSString *)code pwd:(NSString *)pwd;

//修改密码
+ (NSString *)getUpdatePwdWithOldPwd:(NSString *)oldPwd newPwd:(NSString *)newPwd;

//修改昵称
+ (NSString *)getUpDateNickNameUrlWithNickName:(NSString *)nickName;

//修改头像
+ (NSString *)getUpdateHeadUrlWithHead_image:(NSString *)head_image;


//首页接口
+ (NSString *)getHomePageUrl;
//验证码
+ (NSString *)getCerCodeUrlWithPhoneNo:(NSString *)phoneNo;
//收藏列表
+ (NSString *)getColletListUrlWithPage:(NSString *)page;
//商家列表
+ (NSString *)getStoreListUrlWithPage:(NSString *)page type:(NSString *)type;
//商家详情
+ (NSString *)getStoreDetailUrlWithStoreId:(NSString *)storeId;
//商家商品
+ (NSString *)getStoreFoodsListWithStoreId:(NSString *)storeId;
//商家收藏
+ (NSString *)getIsStoreCollectWithStoreId:(NSString *)storeId;
//商品单价
+ (NSString *)getFoodsPriceUrlWithFoodId:(NSString *)foodId specIdList:(NSString *)spec_id_list;
//获取商品详情
+ (NSString *)getFoodsDetailUrlWithStoreId:(NSString *)storeId foodsId:(NSString *)foodsId;



/*
 订单
 */
//订单列表
+ (NSString *)getOrderListUrlWithPage:(NSString *)page state:(NSString *)state;
//订单详情
+ (NSString *)getOrderDetailUrlWithOrderId:(NSString *)orderId;

+ (NSString *)getAppleOrderResultUrlWithOrderId:(NSString *)order_id token:(NSString *)token;

/**
 me
 */
//获取地址详情
+ (NSString *)getAddressList;
//新增地址
+ (NSString *)getAddAddressWithExtmName:(NSString *)extmName sex:(NSString *)sex address:(NSString *)address zipCode:(NSString *)zipCode extm_phone:(NSString *)extm_phone;
//修改地址
+ (NSString *)getEditAddressWithExtmId:(NSString *)extmId extmName:(NSString *)extmName sex:(NSString *)sex address:(NSString *)address zipCode:(NSString *)zipCode extm_phone:(NSString *)extm_phone;
//删除地址
+ (NSString *)getDeleteAddressWithExtmId:(NSString *)extmId;
//判断地址是否在配送范围
+ (NSString *)getIsEffZipCodeUrlWithZipCodel:(NSString *)zipCode;
//会员消息
+ (NSString *)getMessageListUrlWithPage:(int)page;
//删除会员消息
+ (NSString *)getDelMessageUrlWithMessageId:(NSString *)messageId;
+ (NSString *)getReadMessageUrlWithMessageId:(NSString *)messageId;



//信用卡列表
+ (NSString *)getCreditCardListUrl;

//新增信用卡
+ (NSString *)getAddCreditCardUrlWithCardNo:(NSString *)cardNo expiration_date:(NSString *)expiration_date cvv:(NSString *)cvv address:(NSString *)address first_name:(NSString *)first_name last_name:(NSString *)last_name zip_code:(NSString *)zip_code;

+ (NSString *)getDeleteCreditCartWithId:(NSString *)cardId;

//钱包
+ (NSString *)getWalletPageURL;

//饭点
+ (NSString *)getExchangeURL;


@end
