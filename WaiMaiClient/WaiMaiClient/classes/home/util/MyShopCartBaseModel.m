//
//  MyShopCartBaseModel.m
//  WaiMaiClient
//
//  Created by 王 on 2017/8/8.
//  Copyright © 2017年 王. All rights reserved.
//

#import "MyShopCartBaseModel.h"

@implementation MyShopCartBaseModel


+ (NSDictionary *)mj_objectClassInArray{
    return @{
             @"dataArray":[MyShopCartSection class]
             };
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

+ (NSMutableArray *)getMyShopCartBaseModel:(ShopCartBaseModel *)baseModel{
    MyShopCartBaseModel *my_baseModel = [[MyShopCartBaseModel alloc] init];
    
    
    NSMutableArray *dataArray = [NSMutableArray array];
    NSMutableArray *array = [NSMutableArray arrayWithArray:baseModel.dataArray];
    for (int i = 0; i < array.count; i ++) {
        
        ShopCartModel *cart_i = array[i];
        NSMutableArray *tempArray = [@[] mutableCopy];
        [tempArray addObject:cart_i];
        for (int j = i+1; j < array.count; j ++) {
            ShopCartModel *cart_j = array[j];
            if([cart_i.store_id isEqualToString:cart_j.store_id]){
                [tempArray addObject:cart_j];
                [array removeObjectAtIndex:j];
                j = j -1;
            }
        }
        
        [dataArray addObject:tempArray];
    }
    
    for (NSMutableArray *cartArray in dataArray) {
        MyShopCartSection *section = [[MyShopCartSection alloc] init];
        section.isSelect = YES;
        for (ShopCartModel *cartModel in cartArray) {
            section.detailModel.store_id = cartModel.store_id;
            section.detailModel.store_image = cartModel.store_image;
            section.detailModel.store_name_cn = cartModel.store_name_cn;
            section.detailModel.store_name_en = cartModel.store_name_en;
            FoodsListModel *listModel = [[FoodsListModel alloc] init];
            listModel.specName_en = cartModel.specName_en;
            listModel.specName_cn = cartModel.specName_cn;
            listModel.foods_id = cartModel.food_id;
            listModel.foods_name_cn = cartModel.foods_name_cn;
            listModel.foods_name_en = cartModel.foods_name_en;
            listModel.foods_image_cn = cartModel.foods_image_cn;
            listModel.foods_image_en = cartModel.foods_image_en;
            listModel.price = cartModel.price;
            listModel.count = cartModel.count;
            listModel.specCount = cartModel.specCount;
            listModel.specAllID = cartModel.specAllId;
            listModel.isSelect = YES;
            [section.food_list addObject:listModel];
        }
        [my_baseModel.dataArray addObject:section];
    }
    return my_baseModel.dataArray;
    
}

@end
