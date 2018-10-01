//
//  SCUtil.h
//  WaiMaiClient
//
//  Created by 王 on 2017/8/3.
//  Copyright © 2017年 王. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShopCartModel.h"
#import "ShopCartBaseModel.h"
#import "ShopCartManager.h"
#import "FoodsDetailBaseModel.h"
#import "FoodDetailModel.h"

@interface SCUtil : NSObject

//移除商品
+ (ShopCartBaseModel *)removeWithShopCartBaseModel:(ShopCartBaseModel *)baseModel shopCartModel:(ShopCartModel *)cartModel;

//删除重复店家
+ (ShopCartBaseModel *)updateWithshopCartBaseModel:(ShopCartBaseModel *)baseModel shopCartModel:(ShopCartModel *)cartModel;

//更新商品详情数据
+ (FoodsDetailBaseModel *)updataFoodsDetailBaseModel:(FoodsDetailBaseModel *)model;

//进入商店更新店家数据
+ (NSMutableArray *)updateStoreDataWithStoreDetail:(StoreDetailModel *)detailModel storeBaseModel:(StoreGoodsBaseModel *)storeBaseModel;

+ (int)getGoodsCount;

+ (ShopCartModel *)getShopCartModel:(StoreDetailModel *)storeDetail foodDetail:(FoodsListModel *)foodModel;

+ (FoodsListModel *)getFoodListModel:(FoodsDetailBaseModel *)foodBaseModel;

@end
