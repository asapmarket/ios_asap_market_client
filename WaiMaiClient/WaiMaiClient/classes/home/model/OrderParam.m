//
//  OrderParam.m
//  WaiMaiClient
//
//  Created by 王 on 2017/8/13.
//  Copyright © 2017年 王. All rights reserved.
//

#import "OrderParam.h"

@implementation OrderParam

+ (OrderUpBaseModel *)getOrderParamWithCartBaseModel:(MyShopCartBaseModel *)cartBaseModel patType:(NSString *)payType remark:(NSString *)remark ectmId:(NSString *)extmId distribution_time:(NSString *)distribution_time{
    UserInfo *userInfo =[UserInfoTool loadLoginAccount];
    OrderUpBaseModel *baseModel = [[OrderUpBaseModel alloc] init];
    baseModel.user_id = userInfo.user_id;
    baseModel.token = userInfo.token;
    baseModel.order.remark = remark;
    baseModel.order.extm_id = extmId;
    baseModel.order.payment_method = payType;
    baseModel.order.distribution_time = distribution_time;
    baseModel.order.store_list = [OrderParam getStoreInfoWithCartModel:cartBaseModel];
    return baseModel;
}

+ (NSMutableArray *)getStoreInfoWithCartModel:(MyShopCartBaseModel *)baseModel{
    NSMutableArray *storeArray = [NSMutableArray array];
    
    for (MyShopCartSection *section in baseModel.dataArray) {
        UpStoreListModel *upStoreModel = [[UpStoreListModel alloc] init];
        upStoreModel.store_id = section.detailModel.store_id;
        for (FoodsListModel *listModel in section.food_list) {
            UpFoodListModel *upFoodModel = [[UpFoodListModel alloc] init];
            upFoodModel.foods_id = listModel.foods_id;
            upFoodModel.spec_id_list = listModel.specAllID;
            if (listModel.specAllID) {
                upFoodModel.quantity = listModel.specCount;
            }else{
                upFoodModel.quantity = listModel.count;
            }
            upFoodModel.price = listModel.price;
            [upStoreModel.foods_list addObject:upFoodModel];
        }
        [storeArray addObject:upStoreModel];
    }
    return storeArray;
}

@end
