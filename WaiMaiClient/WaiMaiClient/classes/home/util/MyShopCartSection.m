//
//  MyShopCartSection.m
//  WaiMaiClient
//
//  Created by 王 on 2017/8/8.
//  Copyright © 2017年 王. All rights reserved.
//

#import "MyShopCartSection.h"

@implementation MyShopCartSection

+ (NSDictionary *)mj_objectClassInArray{
    return @{
             @"food_list":[FoodsListModel class]
             };
}

- (NSMutableArray *)food_list{
    if (!_food_list) {
        _food_list = [NSMutableArray array];
    }
    return _food_list;
}

- (StoreDetailModel *)detailModel{
    if (!_detailModel) {
        _detailModel = [[StoreDetailModel alloc] init];
    }
    return _detailModel;
}

@end
