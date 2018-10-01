//
//  HomeServer.h
//  WaiMaiClient
//
//  Created by 王 on 2017/8/10.
//  Copyright © 2017年 王. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StoreListModel.h"
#import "StoreDetailModel.h"
#import "StoreGoodsBaseModel.h"
#import "CollectionStateModel.h"
#import "FoodsDetailBaseModel.h"
#import "HomeMainModel.h"
#import "OrderUpBaseModel.h"
#import "PayParam.h"
#import "OrderResult.h"
#import "CreditCardParam.h"
#import "AmoutModel.h"
#import "RunCreateOrderParam.h"
#import "RunUploadFileParam.h"
#import "RunUserPointParam.h"
#import "RunUerPointModel.h"
#import "DeliveryTimeModel.h"

@interface HomeServer : NSObject

//首页接口
+ (void)getHomePageInfoSuccess:(void (^)(HomeMainModel *result))success failure:(void(^)(NSError *error))failure;

//获取商家列表
+ (void)getStoreListWithPage:(int)page type:(NSString *)type Success:(void (^)(StoreListModel *result))success failure:(void(^)(NSError *error))failure;
//获取商家详情
+ (void)getStoreDetailWithStoreId:(NSString *)storeId Success:(void (^)(StoreDetailModel *result))success failure:(void(^)(NSError *error))failure;
//获取商家商品
+ (void)getStoreFoodListWithStoreId:(NSString *)storeId Success:(void (^)(StoreGoodsBaseModel *result))success failure:(void(^)(NSError *error))failure;
//获取是否收藏
+ (void)getIsStoreCollectWithStoreId:(NSString *)storeId Success:(void (^)(CollectionStateModel *result))success failure:(void(^)(NSError *error))failure;

//商品单价
+ (void)getFoodsPriceUrlWithFoodId:(NSString *)foodId specIdList:(NSString *)spec_id_list Success:(void (^)(NSString *result))success failure:(void(^)(NSError *error))failure;

//获取商品详情
+ (void)getFoodsDetailUrlWithStoreId:(NSString *)storeId foodsId:(NSString *)foodsId Success:(void (^)(FoodsDetailBaseModel *result))success failure:(void(^)(NSError *error))failure;


//生成订单
+ (void)getOrderTotalMoneyWithParam:(OrderUpBaseModel *)param Success:(void (^)(AmoutModel *result))success failure:(void(^)(NSError *error))failure;

//生成订单
+ (void)getCreatOrderUrlWithParam:(OrderUpBaseModel *)param Success:(void (^)(OrderResult *result))success failure:(void(^)(NSError *error))failure;

+ (void)getOrderPayWithParam:(PayParam *)param Success:(void (^)(NSString *result))success failure:(void(^)(NSError *error))failure;

+ (void)postApplePayResultWithDict:(NSDictionary *)dict Success:(void (^)(NSString *result))success failure:(void(^)(NSError *error))failure;

+ (void)postPayPayResultWithDict:(NSDictionary *)dict Success:(void (^)(NSString *result))success failure:(void(^)(NSError *error))failure;

+ (void)postCreditCardResultWithParam:(CreditCardParam *)param Success:(void (^)(id result))success failure:(void(^)(NSError *error))failure;

+ (void)postRunOrderParam:(RunCreateOrderParam *)param Success:(void (^)(NSString *result))success failure:(void(^)(NSError *error))failure;

+ (void)postRunUploadFileParam:(RunUploadFileParam *)param uploadFormDataArray:(NSArray *)formDataArray Success:(void (^)(id result))success failure:(void(^)(NSError *error))failure;

+ (void)postRunUserPointParam:(RunUserPointParam *)param Success:(void (^)(RunUerPointModel *result))success failure:(void(^)(NSError *error))failure;

+ (void)getDeliveryTimeWithZip_code:(NSString *)zip_code success:(void (^)(DeliveryTimeModel *result))success failure:(void(^)(NSError *error))failure;


+ (void)postHowToGetRPSuccess:(void (^)(NSString *result))success failure:(void(^)(NSError *error))failure;

+ (void)postUserCouponsWithParam:(WMUserCouponsParam *)param success:(void (^)(WMUserCouponsModel *result))success failure:(void(^)(NSError *error))failure;

@end
