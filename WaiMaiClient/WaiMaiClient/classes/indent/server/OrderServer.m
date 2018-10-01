//
//  OrderServer.m
//  WaiMaiClient
//
//  Created by 王 on 2017/8/11.
//  Copyright © 2017年 王. All rights reserved.
//

#import "OrderServer.h"
#import "WHttpTool.h"

@implementation OrderServer

+(void)getOrderListUrlWithPage:(int)page state:(NSString *)state Success:(void (^)(OrderBaseModel *))success failure:(void (^)(NSError *))failure{
    NSString *url = [UrlsManager getOrderListUrlWithPage:[NSString stringWithFormat:@"%d",page] state:state];
    [WHttpTool getWithURL:url params:nil success:^(id json) {
        OrderBaseModel *result = [OrderBaseModel mj_objectWithKeyValues:json];
        success(result);
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

//订单详情
+ (void)getOrderDetailUrlWithOrderId:(NSString *)orderId Success:(void (^)(OrderDetailBaseModel *))success failure:(void (^)(NSError *))failure{
    NSString *url = [UrlsManager getOrderDetailUrlWithOrderId:orderId];
    [WHttpTool getWithURL:url params:nil success:^(id json) {
        OrderDetailBaseModel *result = [OrderDetailBaseModel mj_objectWithKeyValues:json];
        success(result);
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

//跑腿订单
+ (void)postRunOrderListWithParam:(RunOrderParam *)param success:(void (^)(RunOrderModel *))success failure:(void (^)(NSError *))failure{
    [WHttpTool postWithURL:kRunOrderURL params:param.mj_keyValues success:^(id json) {
        RunOrderModel *model = [RunOrderModel mj_objectWithKeyValues:json];
        success(model);
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

//跑腿订单详情
+ (void)postRunOrderDeatailListWithParam:(RunOrderDetailParam *)param success:(void (^)(RunOrderDetailModel *))success failure:(void (^)(NSError *))failure{
    [WHttpTool postWithURL:kRunOrderDeatailURL params:param.mj_keyValues success:^(id json) {
        RunOrderDetailModel *model = [RunOrderDetailModel mj_objectWithKeyValues:json];
        success(model);
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)postRunOrderStateWitahParam:(RunOrderDetailParam *)param success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [WHttpTool postWithURL:kRunOrderStateURL params:param.mj_keyValues success:^(id json) {
        success(json);
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)postRunOrderPaypalWithDict:(NSDictionary *)dict success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [WHttpTool postWithURL:kRunPayPalUrl params:dict success:^(id json) {
        success(json);
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)postRunMoneyPayWithParam:(RunPayParam *)param success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [WHttpTool postWithURL:kRunMoneyPay params:param.mj_keyValues success:^(id json) {
        success(json);
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}



@end
