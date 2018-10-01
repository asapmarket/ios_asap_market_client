//
//  StoreGoodsBaseModel.m
//  WaiMaiClient
//
//  Created by 王 on 2017/8/2.
//  Copyright © 2017年 王. All rights reserved.
//

#import "StoreGoodsBaseModel.h"

@implementation StoreGoodsBaseModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"type_list":[FoodsTypeModel class]};
}

- (NSMutableArray *)type_list{
    if (!_type_list) {
        _type_list = [NSMutableArray array];
    }
    return _type_list;
}

@end
