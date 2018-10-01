//
//  OrderServer.h
//  WaiMaiClient
//
//  Created by 王 on 2017/8/11.
//  Copyright © 2017年 王. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderBaseModel.h"
#import "OrderDetailBaseModel.h"
#import "RunOrderModel.h"
#import "RunOrderParam.h"
#import "RunOrderDetailModel.h"
#import "RunOrderDetailParam.h"
#import "RunOrderStateParam.h"
#import "RunPayParam.h"

@interface OrderServer : NSObject


//订单列表
+ (void)getOrderListUrlWithPage:(int)page state:(NSString *)state Success:(void (^)(OrderBaseModel *result))success failure:(void(^)(NSError *error))failure;

//订单详情
+ (void)getOrderDetailUrlWithOrderId:(NSString *)orderId Success:(void (^)(OrderDetailBaseModel *result))success failure:(void(^)(NSError *error))failure;

//跑腿订单
+ (void)postRunOrderListWithParam:(RunOrderParam *)param success:(void (^)(RunOrderModel *result))success failure:(void(^)(NSError *error))failure;


//跑腿订单详情
+ (void)postRunOrderDeatailListWithParam:(RunOrderDetailParam *)param success:(void (^)(RunOrderDetailModel *result))success failure:(void(^)(NSError *error))failure;

//修改订单状态
+ (void)postRunOrderStateWitahParam:(RunOrderStateParam *)param success:(void (^)(id result))success failure:(void(^)(NSError *error))failure;

+ (void)postRunOrderPaypalWithDict:(NSDictionary *)dict success:(void (^)(id result))success failure:(void(^)(NSError *error))failure;

+ (void)postRunMoneyPayWithParam:(RunPayParam *)param success:(void (^)(id result))success failure:(void(^)(NSError *error))failure;

@end
