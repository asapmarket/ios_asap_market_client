//
//  SCUtil.m
//  WaiMaiClient
//
//  Created by 王 on 2017/8/3.
//  Copyright © 2017年 王. All rights reserved.
//

#import "SCUtil.h"
#import "SpecListUtil.h"

@implementation SCUtil

+ (ShopCartBaseModel*)updateWithshopCartBaseModel:(ShopCartBaseModel *)baseModel shopCartModel:(ShopCartModel *)cartModel{
    BOOL isStoreID = NO;
    BOOL isFoodID = NO;
    BOOL isSpecID = NO;
    
    if (baseModel.dataArray.count == 0) {
        [baseModel.dataArray addObject:cartModel];
        return baseModel;
    }
    for (ShopCartModel *model in baseModel.dataArray) {
        if ([model.store_id isEqualToString:cartModel.store_id]) {
            isStoreID = YES;
            if ([model.food_id isEqualToString:cartModel.food_id]) {
                isFoodID = YES;
                if ([model.specAllId isEqualToString:cartModel.specAllId] || (model.specAllId == nil && cartModel.specAllId == nil)) {
                    model.specCount = cartModel.specCount;
                    model.count = cartModel.count;
                    isSpecID = YES;
                    break;
                }
            }
        }
        
    }
    
    if (!isStoreID || !isFoodID || !isSpecID) {
        [baseModel.dataArray addObject:cartModel];
    }
    return baseModel;
    
}

//移除商品
+ (ShopCartBaseModel *)removeWithShopCartBaseModel:(ShopCartBaseModel *)baseModel shopCartModel:(ShopCartModel *)cartModel{
    
    for (ShopCartModel *model in baseModel.dataArray) {
        
        if ([model.store_id isEqualToString:cartModel.store_id]) {
            
            if ([model.food_id isEqualToString:cartModel.food_id]) {
                
                if (cartModel.specAllId == nil && model.specAllId == nil) {
                    
                    if (cartModel.count == 0) {
                        
                        [baseModel.dataArray removeObject:model];
                        return baseModel;
                        
                    }else{
                        
                        model.count = cartModel.count;
                        return baseModel;
                    }
                }else{
                    
                    if (cartModel.specCount == 0) {
                        
                        [baseModel.dataArray removeObject:model];
                        return baseModel;

                    }else{
                        
                        model.count = cartModel.count;
                        model.specCount = cartModel.specCount;
                        return baseModel;

                    }
                }
            }
        }
        
    }
    return baseModel;
}




+ (NSMutableArray *)updateStoreDataWithStoreDetail:(StoreDetailModel *)detailModel storeBaseModel:(StoreGoodsBaseModel *)storeBaseModel{
    
    ShopCartBaseModel *baseModel = [[ShopCartManager shareManager] loadShopCartBaseModel];
    
    if (baseModel.dataArray == nil || baseModel.dataArray.count == 0) {
        return storeBaseModel.type_list;
    }
    
    NSMutableArray *dataArray = [NSMutableArray array];
    
    if (baseModel.dataArray.count > 0) {
        for (FoodsTypeModel *typeModel in storeBaseModel.type_list) {
            if (typeModel.foods_list.count > 0) {
                for (FoodsListModel *foodModel in typeModel.foods_list) {
                    foodModel.specCount = 0;
                    foodModel.count = 0;
                }
            }
        }
        for (ShopCartModel *cartModel in baseModel.dataArray) {
            if ([cartModel.store_id isEqualToString:detailModel.store_id]) {
                [SCUtil updateArrayWithCartArray:cartModel storeArray:storeBaseModel.type_list];
            }
        }
    }
    dataArray = storeBaseModel.type_list;

    return dataArray;
}

+ (NSMutableArray *)updateArrayWithCartArray:(ShopCartModel *)cartModel storeArray:(NSMutableArray *)storeArray{
    if (storeArray.count == 0) {
        return storeArray;
    }
    for (FoodsTypeModel *typeModel in storeArray) {
        if (typeModel.foods_list.count > 0) {
            for (FoodsListModel *foodModel in typeModel.foods_list) {
                if ([cartModel.food_id isEqualToString:foodModel.foods_id]) {
                    if ([foodModel.has_spec isEqualToString:@"0"]) {
                        foodModel.specCount = cartModel.specCount;
                    }
                    if (foodModel.count < cartModel.count) {
                        foodModel.count = cartModel.count;
                    }
                }
            }
        }
    }

    return storeArray;
}


//更新商品详情数据
+ (FoodsDetailBaseModel *)updataFoodsDetailBaseModel:(FoodsDetailBaseModel *)model
{
    ShopCartBaseModel *baseModel = [[ShopCartManager shareManager] loadShopCartBaseModel];
    
    if (baseModel.dataArray == nil || baseModel.dataArray.count == 0) {
        return model;
    }
    
    for (ShopCartModel *cartModel in baseModel.dataArray) {
        if ([cartModel.store_id isEqualToString:model.store_id]) {
            if ([cartModel.food_id isEqualToString:model.foods_id]) {
                if (model.count < cartModel.count) {
                    model.count = cartModel.count;
                }
                if (model.specCount < cartModel.specCount) {
                    model.specCount = cartModel.specCount;
                }
            }
        }
    }

    
    return model;

    
}

+ (int)getGoodsCount{
    int count = 0;
    ShopCartBaseModel *baseModel = [[ShopCartManager shareManager] loadShopCartBaseModel];
    
    if (baseModel.dataArray.count == 0 || !baseModel.dataArray) {
        return 0;
    }
    for (ShopCartModel *cartModel in baseModel.dataArray) {
        if (cartModel.specAllId == nil) {
            count += cartModel.count;
        }else{
            count += cartModel.specCount;
        }
    }
    if (count > 0) {
        [[ShopCartManager shareManager] setShopCartCount:count];;
    }else{
        [ShopCartManager shareManager].tabBar.badge = @"0";
    }

    return count;
}



+ (ShopCartModel *)getShopCartModel:(StoreDetailModel *)storeDetail foodDetail:(FoodsListModel *)foodModel{
    ShopCartModel *model = [[ShopCartModel alloc] init];
    model.store_id = storeDetail.store_id;
    model.store_name_cn = storeDetail.store_name_cn;
    model.store_name_en = storeDetail.store_name_en;
    model.store_image = storeDetail.store_image;
    
    model.food_id = foodModel.foods_id;
    model.foods_name_cn = foodModel.foods_name_cn;
    model.foods_name_en = foodModel.foods_name_en;
    model.foods_image_cn = foodModel.foods_image_cn;
    model.foods_name_en = foodModel.foods_name_en;
    model.price = foodModel.price;
    model.specCount = foodModel.specCount;
    model.count = foodModel.count;
    
    model.specName_cn = foodModel.specName_cn;
    model.specName_en = foodModel.specName_en;
    
    if ([foodModel.has_spec isEqualToString:@"0"]) {
        model.specAllId = nil;
    }else{
        model.specAllId = foodModel.specAllID;
    }

    return model;
}


+ (FoodsListModel *)getFoodListModel:(FoodsDetailBaseModel *)foodBaseModel{
    FoodsListModel *model = [[FoodsListModel alloc] init];
    model.store_id = foodBaseModel.store_id;
    model.foods_id = foodBaseModel.foods_id;
    model.foods_name_cn = foodBaseModel.foods_name_cn;
    model.foods_name_en = foodBaseModel.foods_name_en;
    model.foods_image_cn = foodBaseModel.foods_image_cn;
    model.foods_name_en = foodBaseModel.foods_name_en;
    model.price = foodBaseModel.price;
    model.specCount = foodBaseModel.specCount;
    model.count = foodBaseModel.count;
    model.spec_class_list = [NSMutableArray arrayWithArray:foodBaseModel.spec_class_list];
    
    if ([foodBaseModel.has_spec isEqualToString:@"0"]) {
        model.specAllID = nil;
    }else{
        model.specAllID = foodBaseModel.specAllID;
    }

    return model;
    
}



@end














