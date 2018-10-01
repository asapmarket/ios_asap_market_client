//
//  CalculatePrice.m
//  WaiMaiClient
//
//  Created by 王 on 2017/8/9.
//  Copyright © 2017年 王. All rights reserved.
//

#import "CalculatePrice.h"

@implementation CalculatePrice

+ (float)getPriceWithDataArray:(NSMutableArray *)dataArray{
    float price = 0;
    for (MyShopCartSection *model in dataArray) {
        for (FoodsListModel *listModel in model.food_list) {
            if (listModel.isSelect){
                if (listModel.specAllID){
                    price += [listModel.price floatValue]*listModel.specCount;
                }else{
                    price += [listModel.price floatValue]*listModel.count;
                }
            }
        }
    }
    
    return price;
}

+ (MyShopCartBaseModel *)updateMyShopCartBaseModel:(MyShopCartBaseModel *)baseModel{
    if (baseModel.dataArray.count == 0) {
        return nil;
    }
    MyShopCartBaseModel *model = [[MyShopCartBaseModel alloc] init];
    for (MyShopCartSection *sectionModel in baseModel.dataArray) {
        MyShopCartSection *subSection = [[MyShopCartSection alloc] init];
        subSection.detailModel = sectionModel.detailModel;
        for (FoodsListModel *listModel in sectionModel.food_list) {
            if(listModel.isSelect){
                [subSection.food_list addObject:listModel];
            }
        }

        if (subSection.food_list.count > 0){
            [model.dataArray addObject:subSection];
        }
    }
    
    return model;
    
}

+ (void)deleteUnWorkStoreWithArray:(NSArray *)array{}

@end
