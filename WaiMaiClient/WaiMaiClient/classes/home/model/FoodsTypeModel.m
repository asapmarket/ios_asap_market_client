//
//  FoodsTypeModel.m
//  WaiMaiClient
//
//  Created by 王 on 2017/8/2.
//  Copyright © 2017年 王. All rights reserved.
//

#import "FoodsTypeModel.h"

@implementation FoodsTypeModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"foods_list":[FoodsListModel class]};
}

- (NSMutableArray *)foods_list{
    if (!_foods_list) {
        _foods_list = [NSMutableArray array];
    }
    return _foods_list;
}

+ (FoodsTypeModel *)initFoodsTypeModel:(FoodsTypeModel *)typeModel listModel:(FoodsListModel *)listModel{
    FoodsTypeModel *model = [[FoodsTypeModel alloc] init];
    model.index = typeModel.index;
    model.type_id = typeModel.type_id;
    model.type_name_cn = typeModel.type_name_cn;
    model.type_name_en = typeModel.type_name_en;
    model.foods_list = [NSMutableArray arrayWithObject:listModel];
    return model;
}

@end
