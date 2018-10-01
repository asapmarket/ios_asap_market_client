//
//  HomeServer.m
//  WaiMaiClient
//
//  Created by 王 on 2017/8/10.
//  Copyright © 2017年 王. All rights reserved.
//

#import "HomeServer.h"
#import "WHttpTool.h"

@implementation HomeServer

+ (void)getStoreListWithPage:(int)page type:(NSString *)type Success:(void (^)(StoreListModel *))success failure:(void (^)(NSError *))failure{
    NSString *url = [UrlsManager getStoreListUrlWithPage:[NSString stringWithFormat:@"%d",page] type:type];
    NSLog(@"getStoreListWithPage %@",url);
    [WHttpTool getWithURL:url params:nil success:^(id json) {
        StoreListModel *result = [StoreListModel mj_objectWithKeyValues:json];
        success(result);
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

//首页接口
+ (void)getHomePageInfoSuccess:(void (^)(HomeMainModel *))success failure:(void (^)(NSError *))failure{
    NSString *url = [UrlsManager getHomePageUrl];
    [WHttpTool getWithURL:url params:nil success:^(id json) {
        HomeMainModel *result = [HomeMainModel mj_objectWithKeyValues:json];
        success(result);
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)getStoreDetailWithStoreId:(NSString *)storeId Success:(void (^)(StoreDetailModel *))success failure:(void (^)(NSError *))failure{
    NSString *url = [UrlsManager getStoreDetailUrlWithStoreId:storeId];
    NSLog(@"getStoreDetailWithStoreId  %@",url);
    [WHttpTool getWithURL:url params:nil success:^(id json) {
        StoreDetailModel *result = [StoreDetailModel mj_objectWithKeyValues:json];
        success(result);
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)getStoreFoodListWithStoreId:(NSString *)storeId Success:(void (^)(StoreGoodsBaseModel *))success failure:(void (^)(NSError *))failure{
    NSString *url = [UrlsManager getStoreFoodsListWithStoreId:storeId];
    [WHttpTool getWithURL:url params:nil success:^(id json) {
        StoreGoodsBaseModel *result = [StoreGoodsBaseModel mj_objectWithKeyValues:json];
        success(result);
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)getIsStoreCollectWithStoreId:(NSString *)storeId Success:(void (^)(CollectionStateModel *))success failure:(void (^)(NSError *))failure{
    NSString *url = [UrlsManager getIsStoreCollectWithStoreId:storeId];
    [WHttpTool getWithURL:url params:nil success:^(id json) {
        CollectionStateModel *result = [CollectionStateModel mj_objectWithKeyValues:json];
        success(result);
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

//商品单价
+ (void)getFoodsPriceUrlWithFoodId:(NSString *)foodId specIdList:(NSString *)spec_id_list Success:(void (^)(NSString *))success failure:(void (^)(NSError *))failure{
    NSString *url = [UrlsManager getFoodsPriceUrlWithFoodId:foodId specIdList:spec_id_list];
    [WHttpTool getWithURL:url params:nil success:^(id json) {
        success(json[@"price"]);
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}

//获取商品详情
+(void)getFoodsDetailUrlWithStoreId:(NSString *)storeId foodsId:(NSString *)foodsId Success:(void (^)(FoodsDetailBaseModel *))success failure:(void (^)(NSError *))failure{
    NSString *url = [UrlsManager getFoodsDetailUrlWithStoreId:storeId foodsId:foodsId];
    [WHttpTool getWithURL:url params:nil success:^(id json) {
        FoodsDetailBaseModel *result = [FoodsDetailBaseModel mj_objectWithKeyValues:json];
        success(result);
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)getCreatOrderUrlWithParam:(OrderUpBaseModel *)param Success:(void (^)(OrderResult *))success failure:(void (^)(NSError *))failure{
    [WHttpTool postWithURL:kCreateOrderUrl params:param.mj_keyValues success:^(id json) {
        OrderResult *result = [OrderResult mj_objectWithKeyValues:json[@"order"]];
        success(result);
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)getOrderTotalMoneyWithParam:(OrderUpBaseModel *)param Success:(void (^)(AmoutModel *))success failure:(void (^)(NSError *))failure{
    [WHttpTool postWithURL:kCountOrderAmountUrl params:param.mj_keyValues success:^(id json) {
        
        AmoutModel *result = [AmoutModel mj_objectWithKeyValues:json];
        success(result);
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)getOrderPayWithParam:(PayParam *)param Success:(void (^)(NSString *))success failure:(void (^)(NSError *))failure{
    [WHttpTool postWithURL:kOrderPayUrl params:param.mj_keyValues success:^(id json) {
        success(json[@"pay_url"]);
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)postApplePayResultWithDict:(NSDictionary *)dict Success:(void (^)(NSString *))success failure:(void (^)(NSError *))failure{
    [WHttpTool postWithURL:kApplePayUrl params:dict success:^(id json) {
        success(json[@"status"]);
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)postPayPayResultWithDict:(NSDictionary *)dict Success:(void (^)(NSString *))success failure:(void (^)(NSError *))failure{
    [WHttpTool postWithURL:kPaypalUrl params:dict success:^(id json) {
        success(json);
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)postCreditCardResultWithParam:(CreditCardParam *)param Success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [WHttpTool loginPostWithURL:kCreditCardUrl params:param.mj_keyValues success:^(id json) {
        success(json);
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)postRunOrderParam:(RunCreateOrderParam *)param Success:(void (^)(NSString *))success failure:(void (^)(NSError *))failure{
    [WHttpTool postWithURL:kRunCreateOrderURL params:param.mj_keyValues success:^(id json) {
        success(json[@"order_id"]);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

+ (void)postRunUploadFileParam:(RunUploadFileParam *)param uploadFormDataArray:(NSArray *)formDataArray Success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [WHttpTool postWithURL:kRunUploadFileURL params:param.mj_keyValues formDataArray:formDataArray success:^(id json) {
        success(json);
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)postRunUserPointParam:(RunUserPointParam *)param Success:(void (^)(RunUerPointModel *))success failure:(void (^)(NSError *))failure{
    [WHttpTool postWithURL:kRunGetUserPointURL params:param.mj_keyValues success:^(id json) {
        RunUerPointModel *model = [RunUerPointModel mj_objectWithKeyValues:json];
        success(model);
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)getDeliveryTimeWithZip_code:(NSString *)zip_code success:(void (^)(DeliveryTimeModel *))success failure:(void (^)(NSError *))failure{
    NSString *url = [NSString stringWithFormat:@"%@?zip_code=%@",kDeliveryTimeURL, zip_code];
    NSLog(@"getDeliveryTimeWithZip_code = %@", url);
    [WHttpTool getWithURL:url params:nil success:^(id json) {
        DeliveryTimeModel *model = [DeliveryTimeModel mj_objectWithKeyValues:json];
        success(model);
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)postHowToGetRPSuccess:(void (^)(NSString *))success failure:(void (^)(NSError *))failure{
    [WHttpTool postWithURL:kHowToGetPTUrl params:nil success:^(id json) {
        if ([LanguageManager shareManager].language == 0) {
            success(json[@"instructions_en"]);
        }else{
            success(json[@"instructions_cn"]);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)postUserCouponsWithParam:(WMUserCouponsParam *)param success:(void (^)(WMUserCouponsModel *))success failure:(void (^)(NSError *))failure{
    NSLog(@"===%@",kUserCouponUrl);
    [WHttpTool postWithURL:kUserCouponUrl params:param.mj_keyValues success:^(id json) {
        WMUserCouponsModel *model = [WMUserCouponsModel mj_objectWithKeyValues:json];
        success(model);
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
